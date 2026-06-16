// lib/features/constellation/constellation_notifier.dart

import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/repositories/entity_repository.dart';
import '../../core/local_db/app_database.dart';
import 'constellation_graph_controller.dart';

part 'constellation_notifier.g.dart';

/// Data model representing the active node and edge state of the star map graph.
class ConstellationState {
  final List<Entity> nodes;
  final List<RelationEdge> staticEdges;
  final List<ConstellationEdge> dynamicEdges;
  final bool isUpdatePending; // Shows update badge if true

  ConstellationState({
    required this.nodes,
    required this.staticEdges,
    required this.dynamicEdges,
    this.isUpdatePending = false,
  });

  ConstellationState copyWith({
    List<Entity>? nodes,
    List<RelationEdge>? staticEdges,
    List<ConstellationEdge>? dynamicEdges,
    bool? isUpdatePending,
  }) {
    return ConstellationState(
      nodes: nodes ?? this.nodes,
      staticEdges: staticEdges ?? this.staticEdges,
      dynamicEdges: dynamicEdges ?? this.dynamicEdges,
      isUpdatePending: isUpdatePending ?? this.isUpdatePending,
    );
  }
}

/// Always-alive state notifier that manages graph coordinates and elements.
/// It implements a lazy fetch, running queries only on the first subscription (screen load).
@Riverpod(keepAlive: true)
class ConstellationNotifier extends _$ConstellationNotifier {
  Timer? _debounce;
  bool _isForeground = false;
  
  // Instance of position preserving controller
  final ConstellationGraphController _graphController = ConstellationGraphController();

  @override
  FutureOr<ConstellationState> build() async {
    ref.onDispose(() {
      _debounce?.cancel();
    });
    return _fetchGraphData();
  }

  /// Sets foreground status.
  /// Typically called setForeground(true) in screen's initState and setForeground(false) in dispose.
  void setForeground(bool v) {
    _isForeground = v;
  }

  /// Exposes the coordinate controller positions to the UI.
  ConstellationGraphController get controller => _graphController;

  /// Private helper to fetch nodes and edge lists from the local DB.
  Future<ConstellationState> _fetchGraphData() async {
    final repo = ref.read(entityRepositoryProvider);
    
    final nodes = await repo.getDiscoveredEntities();
    final staticEdges = await repo.getStaticRelationEdges();
    final dynamicEdges = await repo.getDynamicConstellationEdges();

    // Perform centroid coordinate seeding for newly discovered nodes
    _graphController.updateGraphPositions(
      nodes: nodes,
      staticEdges: staticEdges,
      dynamicEdges: dynamicEdges,
    );

    return ConstellationState(
      nodes: nodes,
      staticEdges: staticEdges,
      dynamicEdges: dynamicEdges,
      isUpdatePending: false,
    );
  }

  /// Exposes a deferred reload request.
  ///
  /// - Under Foreground suppression: sets [ConstellationState.isUpdatePending] to true
  ///   without invalidating the layout (shows the "Tap to update" badge in the UI).
  /// - Under Background reading: cancels active debounce and sets a 600ms timer
  ///   before executing the re-layout.
  void scheduleRefresh() {
    if (_isForeground) {
      // Suppress re-layout, set update badge pending flag to true
      state.whenData((current) {
        state = AsyncValue.data(current.copyWith(isUpdatePending: true));
      });
      return;
    }

    // Debounce 600ms to collapse rapid reads
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () async {
      state = const AsyncLoading();
      state = await AsyncValue.guard(() => _fetchGraphData());
    });
  }

  /// Apply updates immediately, clearing the pending badge status.
  /// Typically invoked when tapping the Floating Update Badge.
  Future<void> applyPendingUpdate() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchGraphData());
  }

  /// Public flag indicating whether a deferred update is pending.
  bool get hasPendingUpdate {
    return state.value?.isUpdatePending ?? false;
  }

  /// Apply updates immediately (alias/forwarder for applyPendingUpdate).
  Future<void> applyDeferredRefresh() => applyPendingUpdate();
}

