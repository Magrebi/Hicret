// lib/features/constellation/constellation_graph_controller.dart

import 'dart:ui';
import '../../core/local_db/app_database.dart' hide Theme;

/// Controller handling node coordinates within the force-directed Constellation star map.
/// It implements position preservation (Centroid Seeding) to prevent full graph re-layouts
/// and minimize rendering stutter.
class ConstellationGraphController {
  // Store node positions dynamically to preserve coordinate integrity on update
  final Map<String, Offset> _nodePositions = {};

  ConstellationGraphController();

  /// Exposes read access to node offsets.
  Map<String, Offset> get nodePositions => Map.unmodifiable(_nodePositions);

  /// Seeds coordinates for new nodes based on the positions of their neighbors.
  ///
  /// [nodes] Complete list of discovered entities (nodes) currently in the graph
  /// [staticEdges] Static Relation edges
  /// [dynamicEdges] Dynamic co-occurrence Constellation edges
  void updateGraphPositions({
    required List<Entity> nodes,
    required List<RelationEdge> staticEdges,
    required List<ConstellationEdge> dynamicEdges,
  }) {
    final existingIds = _nodePositions.keys.toSet();

    for (final node in nodes) {
      if (existingIds.contains(node.id)) {
        // Position already preserved, continue
        continue;
      }

      // Identify neighbors that already have designated coordinates
      final neighbors = _findPositionedNeighbors(
        nodeId: node.id,
        staticEdges: staticEdges,
        dynamicEdges: dynamicEdges,
      );

      if (neighbors.isEmpty) {
        // Default seed to central coordinate origin
        _nodePositions[node.id] = Offset.zero;
      } else {
        // Calculate the average (centroid) coordinates of all positioned neighbors
        double sumX = 0;
        double sumY = 0;
        int count = 0;

        for (final neighborId in neighbors) {
          final pos = _nodePositions[neighborId];
          if (pos != null) {
            sumX += pos.dx;
            sumY += pos.dy;
            count++;
          }
        }

        _nodePositions[node.id] = count > 0 
            ? Offset(sumX / count, sumY / count) 
            : Offset.zero;
      }
    }
  }

  /// Locate IDs of connected nodes that already have valid coordinate placements.
  Set<String> _findPositionedNeighbors({
    required String nodeId,
    required List<RelationEdge> staticEdges,
    required List<ConstellationEdge> dynamicEdges,
  }) {
    final neighbors = <String>{};

    // 1. Check static relation edges
    for (final edge in staticEdges) {
      if (edge.entityAId == nodeId && _nodePositions.containsKey(edge.entityBId)) {
        neighbors.add(edge.entityBId);
      } else if (edge.entityBId == nodeId && _nodePositions.containsKey(edge.entityAId)) {
        neighbors.add(edge.entityAId);
      }
    }

    // 2. Check dynamic co-occurrence edges
    for (final edge in dynamicEdges) {
      if (edge.entityAId == nodeId && _nodePositions.containsKey(edge.entityBId)) {
        neighbors.add(edge.entityBId);
      } else if (edge.entityBId == nodeId && _nodePositions.containsKey(edge.entityAId)) {
        neighbors.add(edge.entityAId);
      }
    }

    return neighbors;
  }

  /// Manually update or record a specific node's position (e.g. on user drag).
  void setNodePosition(String nodeId, Offset position) {
    _nodePositions[nodeId] = position;
  }

  /// Clear position history (for reset/re-align actions).
  void clear() {
    _nodePositions.clear();
  }
}
