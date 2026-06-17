// lib/features/constellation/constellation_screen.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:graphview/GraphView.dart';

import '../../core/local_db/app_database.dart' hide Theme;
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/constellation_side_panel.dart';
import '../../shared/widgets/update_badge.dart';
import '../encyclopedia/encyclopedia_notifier.dart';
import '../encyclopedia/encyclopedia_screen.dart';
import 'constellation_notifier.dart';

enum FilterType { all, prophets, locations, nature, themes }

class ConstellationScreen extends ConsumerStatefulWidget {
  final String? highlightEntityId;

  const ConstellationScreen({
    Key? key,
    this.highlightEntityId,
  }) : super(key: key);

  @override
  ConsumerState<ConstellationScreen> createState() => _ConstellationScreenState();
}

class _ConstellationScreenState extends ConsumerState<ConstellationScreen> {
  late final TransformationController _transformationController;
  late final GraphViewController _graphViewController;

  late final FruchtermanReingoldAlgorithm _algorithm;

  String? _selectedEntityId;
  String? _highlightedEntityId;
  FilterType _activeFilter = FilterType.all;
  String? _processedHighlightId;
  ConstellationNotifier? _constellationNotifier;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _graphViewController = GraphViewController(
      transformationController: _transformationController,
    );
    _constellationNotifier = ref.read(constellationNotifierProvider.notifier);
    _algorithm = FruchtermanReingoldAlgorithm(
      FruchtermanReingoldConfiguration(
        shuffleNodes: false, // Centroid seeding handles initial node positions
        repulsionPercentage: 0.5,
        attractionPercentage: 0.5,
        iterations: 300,
      ),
      renderer: ConstellationEdgeRenderer(),
    );

    // Call setForeground(true) on screen initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _constellationNotifier?.setForeground(true);
    });
  }

  @override
  void dispose() {
    // Call setForeground(false) on screen disposal
    _constellationNotifier?.setForeground(false);
    _transformationController.dispose();
    super.dispose();
  }

  bool _isFilteredOut(Entity entity) {
    if (_activeFilter == FilterType.all) return false;
    final type = entity.type.toLowerCase();
    switch (_activeFilter) {
      case FilterType.prophets:
        return type != 'prophet' && type != 'historical_figure' && type != 'matriarch';
      case FilterType.locations:
        return type != 'location';
      case FilterType.nature:
        return type != 'animal' && type != 'plant' && type != 'nature';
      case FilterType.themes:
        return type != 'theme';
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Switch to Encyclopedia view if showEncyclopediaProvider is true
    final showEncyclopedia = ref.watch(showEncyclopediaProvider);
    if (showEncyclopedia) {
      return EncyclopediaScreen();
    }

    final graphStateAsync = ref.watch(constellationNotifierProvider);
    final allEntitiesAsync = ref.watch(watchEntitiesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A), // Always-dark surface
      body: graphStateAsync.when(
        data: (graphState) {
          // If no discovered nodes, render the centered empty state
          if (graphState.nodes.isEmpty) {
            return _buildEmptyState();
          }

          return allEntitiesAsync.when(
            data: (allEntities) {
              final Map<String, Node> nodeInstances = {};
              final Graph graph = Graph();

              // Build node data lookup map
              final Map<String, ConstellationNodeData> nodeDataMap = {};
              final controller = ref.read(constellationNotifierProvider.notifier).controller;

              for (final entity in allEntities) {
                final isGhost = !entity.isDiscovered || _isFilteredOut(entity);
                nodeDataMap[entity.id] = ConstellationNodeData(entity: entity, isGhost: isGhost);

                final Node node = Node.Id(entity.id);
                // Centroid Seeding position assignment
                final savedPos = controller.nodePositions[entity.id];
                if (savedPos != null) {
                  node.position = savedPos;
                }
                graph.addNode(node);
                nodeInstances[entity.id] = node;
              }

              // Add RelationEdges (Solid Teal)
              for (final edge in graphState.staticEdges) {
                final srcNode = nodeInstances[edge.entityAId];
                final dstNode = nodeInstances[edge.entityBId];
                if (srcNode != null && dstNode != null) {
                  final paint = Paint()
                    ..color = const Color(0xFF2A6B5A)
                    ..strokeWidth = 1.0
                    ..style = PaintingStyle.stroke;
                  graph.addEdge(srcNode, dstNode, paint: paint);
                }
              }

              // Add ConstellationEdges (Dashed Teal, weighted opacity)
              for (final edge in graphState.dynamicEdges) {
                final srcNode = nodeInstances[edge.entityAId];
                final dstNode = nodeInstances[edge.entityBId];
                if (srcNode != null && dstNode != null) {
                  final opacity = (edge.weight / 10.0).clamp(0.2, 0.8);
                  final paint = Paint()
                    ..color = const Color(0xFF2A6B5A).withOpacity(opacity)
                    ..strokeWidth = 1.0
                    ..style = PaintingStyle.stroke;

                  final graphEdge = ConstellationGraphEdge(
                    srcNode,
                    dstNode,
                    edge.weight.toDouble(),
                    paint: paint,
                  );
                  graph.addEdgeS(graphEdge);
                }
              }

              // Check for highlight parameter or global highlighted entity from detail screen
              final globalHighlightId = widget.highlightEntityId ?? ref.watch(highlightedEntityIdProvider);
              if (globalHighlightId != null && globalHighlightId != _processedHighlightId) {
                _processedHighlightId = globalHighlightId;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  try {
                    _graphViewController.animateToNode(ValueKey(globalHighlightId));
                    setState(() {
                      _selectedEntityId = globalHighlightId;
                      _highlightedEntityId = globalHighlightId;
                    });
                    ref.read(highlightedEntityIdProvider.notifier).highlight(null);
                  } catch (e) {
                    // Node may not be rendered yet or invalid key
                  }
                });
              }

              return Stack(
                children: [
                  // Layer 0: Background GestureDetector to dismiss side panel on empty tap
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedEntityId = null;
                        });
                      },
                      child: Container(color: Colors.transparent),
                    ),
                  ),

                  // Layer 1: Interactive GraphView canvas
                  Positioned.fill(
                    child: GraphView.builder(
                      graph: graph,
                      algorithm: _algorithm,
                      paint: Paint()
                        ..color = const Color(0xFF2A6B5A)
                        ..strokeWidth = 1.0
                        ..style = PaintingStyle.stroke,
                      builder: (Node node) {
                        final nodeData = nodeDataMap[node.key!.value];
                        if (nodeData == null) return const SizedBox.shrink();
                        return _buildNodeWidget(nodeData);
                      },
                      controller: _graphViewController,
                      centerGraph: true,
                    ),
                  ),

                  // Layer 2: UpdateBadge (Floating update pill at top center)
                  UpdateBadge(
                    visible: graphState.isUpdatePending,
                    onTap: () {
                      ref.read(constellationNotifierProvider.notifier).applyDeferredRefresh();
                    },
                  ),

                  // Layer 3: Filter Chips Row
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: _buildFilterChipsRow(),
                  ),

                  // Layer 4: ConstellationSidePanel (Slide-in detail panel on right)
                  ConstellationSidePanel(
                    entityId: _selectedEntityId,
                    visible: _selectedEntityId != null,
                    onClose: () {
                      setState(() {
                        _selectedEntityId = null;
                      });
                    },
                  ),
                ],
              );
            },
            loading: () => const PulsingDotGrid(),
            error: (err, stack) => _buildErrorState(err),
          );
        },
        loading: () => const PulsingDotGrid(),
        error: (err, stack) => _buildErrorState(err),
      ),
    );
  }

  Widget _buildNodeWidget(ConstellationNodeData data) {
    if (data.isGhost) {
      return Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF2A2E35),
          border: Border.all(color: const Color(0xFF3A3F47), width: 1.0),
        ),
      );
    }

    final entity = data.entity;
    final fillColor = _getFillColor(entity.type);
    final icon = _getIcon(entity.type);
    final isSelected = entity.id == _selectedEntityId;
    final isHighlighted = entity.id == _highlightedEntityId;

    final nodeCircle = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: fillColor,
        border: Border.all(
          color: isSelected ? Colors.white : fillColor.withOpacity(0.6),
          width: isSelected ? 2.0 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: fillColor.withOpacity(0.3),
            blurRadius: 4,
            spreadRadius: 2,
          )
        ],
      ),
      child: Icon(icon, size: 18, color: Colors.white),
    );

    Widget resultWidget = GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedEntityId == entity.id) {
            _selectedEntityId = null;
          } else {
            _selectedEntityId = entity.id;
          }
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isHighlighted
              ? PulsingHighlightRing(
                  onAnimationEnd: () {
                    setState(() {
                      if (_highlightedEntityId == entity.id) {
                        _highlightedEntityId = null;
                      }
                    });
                  },
                  child: nodeCircle,
                )
              : nodeCircle,
          const SizedBox(height: 4),
          SizedBox(
            width: 80,
            child: Text(
              entity.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'SF Pro',
                fontSize: 11,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return resultWidget;
  }

  Color _getFillColor(String rawType) {
    switch (rawType.toLowerCase()) {
      case 'prophet':
      case 'historical_figure':
      case 'matriarch':
        return const Color(0xFF1D9E75); // teal-400
      case 'location':
        return const Color(0xFFEF9F27); // amber-400
      case 'animal':
      case 'plant':
      case 'nature':
        return const Color(0xFF639922); // green-400
      case 'theme':
        return const Color(0xFF7F77DD); // purple-400
      default:
        return const Color(0xFF7F77DD);
    }
  }

  IconData _getIcon(String rawType) {
    switch (rawType.toLowerCase()) {
      case 'prophet':
      case 'historical_figure':
      case 'matriarch':
        return Icons.person_outline;
      case 'location':
        return Icons.place_outlined;
      case 'animal':
        return Icons.pets_outlined;
      case 'plant':
      case 'nature':
        return Icons.eco_outlined;
      case 'theme':
        return Icons.wb_sunny_outlined;
      default:
        return Icons.circle;
    }
  }

  Widget _buildFilterChipsRow() {
    final filters = [
      {'type': FilterType.all, 'label': 'All'},
      {'type': FilterType.prophets, 'label': 'Prophets'},
      {'type': FilterType.locations, 'label': 'Locations'},
      {'type': FilterType.nature, 'label': 'Nature'},
      {'type': FilterType.themes, 'label': 'Themes'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: filters.map((f) {
          final type = f['type'] as FilterType;
          final label = f['label'] as String;
          final isActive = _activeFilter == type;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _activeFilter = type;
                });
              },
              child: Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFF1D9E75) : const Color(0xFF1A2A23),
                  borderRadius: BorderRadius.circular(999),
                  border: isActive
                      ? null
                      : Border.all(color: const Color(0xFF2A4A3A), width: 1.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isActive ? Colors.white : const Color(0xFF5DCAA5),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _GlowingTealDot(),
          const SizedBox(height: 20),
          const SizedBox(
            width: 220,
            child: Text(
              'Start reading to build your constellation',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'SF Pro',
                fontSize: 14,
                color: QkaTheme.neutral400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(dynamic err) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error loading constellation: $err',
            style: const TextStyle(color: QkaTheme.teal400, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1D9E75),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              ref.read(constellationNotifierProvider.notifier).applyDeferredRefresh();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class ConstellationNodeData {
  final Entity entity;
  final bool isGhost;

  ConstellationNodeData({required this.entity, required this.isGhost});
}

class ConstellationGraphEdge extends Edge {
  final double weight;
  ConstellationGraphEdge(Node source, Node destination, this.weight, {Paint? paint})
      : super(source, destination, paint: paint);
}

class ConstellationEdgeRenderer extends ArrowEdgeRenderer {
  ConstellationEdgeRenderer() : super(noArrow: true);

  @override
  void renderEdge(Canvas canvas, Edge edge, Paint paint) {
    final isDashed = edge is ConstellationGraphEdge;
    final source = edge.source;
    final destination = edge.destination;

    final sourceOffset = getNodePosition(source);
    final destinationOffset = getNodePosition(destination);

    final startX = sourceOffset.dx + source.width * 0.5;
    final startY = sourceOffset.dy + source.height * 0.5;
    final stopX = destinationOffset.dx + destination.width * 0.5;
    final stopY = destinationOffset.dy + destination.height * 0.5;

    final clippedLine = clipLineEnd(
      startX,
      startY,
      stopX,
      stopY,
      destinationOffset.dx,
      destinationOffset.dy,
      destination.width,
      destination.height,
    );

    final start = Offset(clippedLine[0], clippedLine[1]);
    final end = Offset(clippedLine[2], clippedLine[3]);

    final currentPaint = (edge.paint ?? paint)..style = PaintingStyle.stroke;

    if (isDashed) {
      // Draw dashed line manually [4, 4]
      _drawDashedLine(canvas, start, end, currentPaint, 4.0, 4.0);
    } else {
      // Draw solid line
      canvas.drawLine(start, end, currentPaint);
    }
  }

  void _drawDashedLine(
    Canvas canvas,
    Offset start,
    Offset end,
    Paint paint,
    double dashWidth,
    double dashSpace,
  ) {
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final distance = sqrt(dx * dx + dy * dy);
    if (distance == 0) return;

    final stepX = dx / distance;
    final stepY = dy / distance;

    double currentDistance = 0.0;
    while (currentDistance < distance) {
      final chunk = min(dashWidth, distance - currentDistance);
      final segmentStart = Offset(
        start.dx + currentDistance * stepX,
        start.dy + currentDistance * stepY,
      );
      currentDistance += chunk;
      final segmentEnd = Offset(
        start.dx + currentDistance * stepX,
        start.dy + currentDistance * stepY,
      );

      canvas.drawLine(segmentStart, segmentEnd, paint);
      currentDistance += dashSpace;
    }
  }
}

class PulsingDotGrid extends StatefulWidget {
  const PulsingDotGrid({Key? key}) : super(key: key);

  @override
  State<PulsingDotGrid> createState() => _PulsingDotGridState();
}

class _PulsingDotGridState extends State<PulsingDotGrid> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.2, end: 0.6).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      builder: (context, child) {
        return CustomPaint(
          painter: _DotGridPainter(opacity: _opacity.value),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _DotGridPainter extends CustomPainter {
  final double opacity;
  _DotGridPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = QkaTheme.neutral600.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    final double spacingX = size.width / 9;
    final double spacingY = size.height / 9;
    for (int i = 1; i <= 8; i++) {
      for (int j = 1; j <= 8; j++) {
        canvas.drawCircle(Offset(i * spacingX, j * spacingY), 1.0, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotGridPainter oldDelegate) => oldDelegate.opacity != opacity;
}

class _GlowingTealDot extends StatefulWidget {
  const _GlowingTealDot({Key? key}) : super(key: key);

  @override
  State<_GlowingTealDot> createState() => _GlowingTealDotState();
}

class _GlowingTealDotState extends State<_GlowingTealDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.4, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      builder: (context, child) {
        return Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF1D9E75).withOpacity(_opacity.value),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1D9E75).withOpacity(_opacity.value * 0.5),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
        );
      },
    );
  }
}

class PulsingHighlightRing extends StatefulWidget {
  final Widget child;
  final VoidCallback onAnimationEnd;

  const PulsingHighlightRing({
    Key? key,
    required this.child,
    required this.onAnimationEnd,
  }) : super(key: key);

  @override
  State<PulsingHighlightRing> createState() => _PulsingHighlightRingState();
}

class _PulsingHighlightRingState extends State<PulsingHighlightRing> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  int _cycles = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _opacity = Tween<double>(begin: 1.0, end: 0.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _cycles++;
        if (_cycles < 3) {
          _controller.forward();
        } else {
          widget.onAnimationEnd();
        }
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            if (_cycles < 3)
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(_opacity.value),
                    width: 2.0,
                  ),
                ),
              ),
            widget.child,
          ],
        );
      },
    );
  }
}
