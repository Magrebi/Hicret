// lib/core/local_db/daos/set_collection_dao.dart

import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/sets_table.dart';
import '../tables/set_requirements_table.dart';
import '../tables/collections_table.dart';
import '../tables/collection_entities_table.dart';
import '../tables/expeditions_table.dart';
import '../tables/entities_table.dart';

part 'set_collection_dao.g.dart';

@DriftAccessor(tables: [Sets, SetRequirements, Collections, CollectionEntities, Expeditions, Entities])
class SetCollectionDao extends DatabaseAccessor<AppDatabase> with _$SetCollectionDaoMixin {
  SetCollectionDao(AppDatabase db) : super(db);

  /// Fetch all sets visible to the UI.
  /// Hidden sets (isHidden=true) are EXCLUDED unless they have been unlocked (isVisible=true).
  Future<List<SetsData>> getVisibleSets() {
    return (select(sets)..where((t) => t.isHidden.equals(false) | t.isVisible.equals(true))).get();
  }

  /// Evaluate hidden locked sets and unlock them (isVisible=true) 
  /// if all required entities are discovered.
  Future<void> evaluateHiddenSets() async {
    await transaction(() async {
      // 1. Query all hidden sets that are currently invisible
      final lockedSets = await (select(sets)
            ..where((t) => t.isHidden.equals(true) & t.isVisible.equals(false)))
          .get();

      for (final setItem in lockedSets) {
        // 2. Query required entities for this set that remain undiscovered
        final query = select(setRequirements).join([
          innerJoin(entities, entities.id.equalsExp(setRequirements.requiredEntityId)),
        ])
          ..where(setRequirements.setId.equals(setItem.id) & entities.isDiscovered.equals(false));

        final undiscoveredCount = await query.get();

        // 3. If no required entities are undiscovered, unlock the set!
        if (undiscoveredCount.isEmpty) {
          await (update(sets)..where((t) => t.id.equals(setItem.id))).write(
            const SetsCompanion(isVisible: Value(true)),
          );
        }
      }
    });
  }

  /// Get all collections (archetypes/badges)
  Future<List<Collection>> getAllCollections() {
    return select(collections).get();
  }

  /// Check all collections and mark them completed if all member entities are discovered
  Future<void> evaluateCollectionsCompletion() async {
    await transaction(() async {
      final incompleteCollections = await (select(collections)
            ..where((t) => t.isCompleted.equals(false)))
          .get();

      for (final coll in incompleteCollections) {
        // Check if there are any undiscovered entities in this collection
        final query = select(collectionEntities).join([
          innerJoin(entities, entities.id.equalsExp(collectionEntities.entityId)),
        ])
          ..where(collectionEntities.collectionId.equals(coll.id) & entities.isDiscovered.equals(false));

        final undiscoveredCount = await query.get();

        if (undiscoveredCount.isEmpty) {
          await (update(collections)..where((t) => t.id.equals(coll.id))).write(
            const CollectionsCompanion(isCompleted: Value(true)),
          );
        }
      }
    });
  }

  /// Fetch all Expeditions
  Future<List<Expedition>> getAllExpeditions() {
    return select(expeditions).get();
  }

  /// Update expedition progress parameters
  Future<void> updateExpeditionProgress(String expeditionId, double progress) {
    final isCompleted = progress >= 1.0;
    return (update(expeditions)..where((t) => t.id.equals(expeditionId))).write(
      ExpeditionsCompanion(
        progress: Value(progress),
        isCompleted: Value(isCompleted),
      ),
    );
  }
}
