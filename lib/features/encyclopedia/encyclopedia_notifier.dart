// lib/features/encyclopedia/encyclopedia_notifier.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart' hide Column;
import '../../core/local_db/app_database.dart' hide Theme;
import '../../core/local_db/database_provider.dart';

part 'encyclopedia_notifier.g.dart';

/// UI state model for a single Collection or Set with its calculated progress.
class CollectionSetItem {
  final String id;
  final String name;
  final int discoveredCount;
  final int totalCount;
  final bool isSet;
  final bool isComplete;
  final String? rewardTitle;

  CollectionSetItem({
    required this.id,
    required this.name,
    required this.discoveredCount,
    required this.totalCount,
    required this.isSet,
    required this.isComplete,
    this.rewardTitle,
  });
}

/// UI state model containing all categorized entities for Level 1.
class EncyclopediaState {
  final List<Entity> figures;
  final List<Entity> places;
  final List<CollectionSetItem> collectionsAndSets;

  EncyclopediaState({
    required this.figures,
    required this.places,
    required this.collectionsAndSets,
  });
}

/// Helper stream provider for reactive database updates on the Entities table.
@riverpod
Stream<List<Entity>> watchEntities(WatchEntitiesRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.select(db.entities).watch();
}

/// Helper stream provider for reactive database updates on the Collections table.
@riverpod
Stream<List<Collection>> watchCollections(WatchCollectionsRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.select(db.collections).watch();
}

/// Helper stream provider for reactive database updates on the Sets table.
@riverpod
Stream<List<SetsData>> watchSets(WatchSetsRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.select(db.sets).watch();
}

/// Main notifier providing all Level 1 state reactively.
@riverpod
class Encyclopedia extends _$Encyclopedia {
  @override
  FutureOr<EncyclopediaState> build() async {
    final db = ref.watch(appDatabaseProvider);

    // Watch entities, collections, and sets reactively
    final allEntities = await ref.watch(watchEntitiesProvider.future);
    final allCollections = await ref.watch(watchCollectionsProvider.future);
    final allSets = await ref.watch(watchSetsProvider.future);

    // Group entities
    final figures = allEntities.where((e) {
      final type = e.type.toLowerCase();
      return type == 'prophet' || type == 'historical_figure' || type == 'matriarch';
    }).toList();

    // Sort figures: discovered first, then undiscovered
    figures.sort((a, b) {
      if (a.isDiscovered && !b.isDiscovered) return -1;
      if (!a.isDiscovered && b.isDiscovered) return 1;
      return a.name.compareTo(b.name);
    });

    final places = allEntities.where((e) => e.type.toLowerCase() == 'location').toList();

    // Fetch relations for progress counting
    final allCollectionEntities = await db.select(db.collectionEntities).get();
    final allSetRequirements = await db.select(db.setRequirements).get();

    final discoveredMap = {for (final e in allEntities) e.id: e.isDiscovered};

    final List<CollectionSetItem> items = [];

    // 1. Process Collections (always visible)
    for (final col in allCollections) {
      final memberIds = allCollectionEntities
          .where((ce) => ce.collectionId == col.id)
          .map((ce) => ce.entityId)
          .toList();
      final total = memberIds.length;
      final discovered = memberIds.where((id) => discoveredMap[id] ?? false).length;

      items.add(
        CollectionSetItem(
          id: col.id,
          name: col.name,
          discoveredCount: discovered,
          totalCount: total,
          isSet: false,
          isComplete: col.isCompleted,
        ),
      );
    }

    // 2. Process Sets (visible sets only: isVisible == true)
    final visibleSets = allSets.where((s) => s.isVisible).toList();
    for (final s in visibleSets) {
      final reqIds = allSetRequirements
          .where((r) => r.setId == s.id)
          .map((r) => r.requiredEntityId)
          .toList();
      final total = reqIds.length;
      final discovered = reqIds.where((id) => discoveredMap[id] ?? false).length;

      items.add(
        CollectionSetItem(
          id: s.id,
          name: s.name,
          discoveredCount: discovered,
          totalCount: total,
          isSet: true,
          isComplete: s.isCompleted,
          rewardTitle: s.description != '// TODO: Tafsir — content team to supply' ? s.description : 'Unlock Reward',
        ),
      );
    }

    return EncyclopediaState(
      figures: figures,
      places: places,
      collectionsAndSets: items,
    );
  }
}

/// Holds entity triggers joined with verse data for the appears-in display.
class EntityTriggerEvent {
  final EntityTrigger trigger;
  final Verse verse;

  EntityTriggerEvent({required this.trigger, required this.verse});
}

/// UI state model containing all necessary details for Level 2.
class EntityDetailData {
  final Entity entity;
  final List<EntityTriggerEvent> triggers;
  final List<Entity> connectedEntities;

  EntityDetailData({
    required this.entity,
    required this.triggers,
    required this.connectedEntities,
  });
}

/// Family provider yielding entity details, trigger references, and relations.
@riverpod
FutureOr<EntityDetailData> entityDetail(EntityDetailRef ref, String entityId) async {
  final db = ref.watch(appDatabaseProvider);

  // 1. Fetch the main entity
  final entity = await (db.select(db.entities)..where((t) => t.id.equals(entityId))).getSingle();

  // 2. Fetch trigger events (joined with verses)
  final triggersQuery = db.select(db.entityTriggers).join([
    innerJoin(
      db.verses,
      db.verses.surahNum.equalsExp(db.entityTriggers.surahNum) &
          db.verses.ayahNum.equalsExp(db.entityTriggers.ayahNum),
    ),
  ])..where(db.entityTriggers.entityId.equals(entityId));

  final triggerRows = await triggersQuery.get();
  final triggers = triggerRows.map((row) {
    return EntityTriggerEvent(
      trigger: row.readTable(db.entityTriggers),
      verse: row.readTable(db.verses),
    );
  }).toList();

  // 3. Fetch static relation neighbors
  final edges = await (db.select(db.relationEdges)
        ..where((t) => t.entityAId.equals(entityId) | t.entityBId.equals(entityId)))
      .get();

  final neighborIds = edges.map((e) => e.entityAId == entityId ? e.entityBId : e.entityAId).toList();

  List<Entity> neighbors = [];
  if (neighborIds.isNotEmpty) {
    neighbors = await (db.select(db.entities)..where((t) => t.id.isIn(neighborIds))).get();
  }

  return EntityDetailData(
    entity: entity,
    triggers: triggers,
    connectedEntities: neighbors,
  );
}

/// Controls whether to show the encyclopedia (true) or constellation map (false) in the Explore tab.
@riverpod
class ShowEncyclopedia extends _$ShowEncyclopedia {
  @override
  bool build() => false;

  set state(bool value) {
    super.state = value;
  }
}


/// Holds the ID of the entity currently highlighted in the constellation map.
@riverpod
class HighlightedEntityId extends _$HighlightedEntityId {
  @override
  String? build() => null;

  void highlight(String? id) {
    state = id;
  }
}

/// Fetches the member entities of a Collection or Set.
@riverpod
FutureOr<List<Entity>> collectionEntities(CollectionEntitiesRef ref, String collectionId, bool isSet) async {
  final db = ref.watch(appDatabaseProvider);
  
  if (isSet) {
    final query = db.select(db.entities).join([
      innerJoin(db.setRequirements, db.setRequirements.requiredEntityId.equalsExp(db.entities.id)),
    ])..where(db.setRequirements.setId.equals(collectionId));
    
    final rows = await query.get();
    return rows.map((row) => row.readTable(db.entities)).toList();
  } else {
    final query = db.select(db.entities).join([
      innerJoin(db.collectionEntities, db.collectionEntities.entityId.equalsExp(db.entities.id)),
    ])..where(db.collectionEntities.collectionId.equals(collectionId));
    
    final rows = await query.get();
    return rows.map((row) => row.readTable(db.entities)).toList();
  }
}


