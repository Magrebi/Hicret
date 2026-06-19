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

  /// Fetch all Expeditions, seeding them first if empty.
  Future<List<Expedition>> getAllExpeditions() async {
    final existing = await select(expeditions).get();
    if (existing.isEmpty) {
      await _seedExpeditions();
      return select(expeditions).get();
    }
    return existing;
  }

  /// Watch all Expeditions (for real-time updates)
  Stream<List<Expedition>> watchAllExpeditions() async* {
    await getAllExpeditions(); // Ensure expeditions are seeded before watching
    yield* select(expeditions).watch();
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

  Future<void> _seedExpeditions() async {
    final list = [
      {
        'id': 'exp_exodus',
        'name': 'The Exodus Expedition',
        'description': 'Follow the journey of Musa (AS) from his infancy to the confrontation with Pharaoh and the parting of the sea.',
      },
      {
        'id': 'exp_wisdom_luqman',
        'name': 'Wisdom of Luqman',
        'description': 'Study the core moral and spiritual advice given by Luqman the Wise to his son.',
      },
      {
        'id': 'exp_covenant_abraham',
        'name': 'The Covenant of Abraham',
        'description': 'Trace Ibrahim\'s (AS) search for truth, his challenges with his people, and the building of the Kaaba.',
      },
      {
        'id': 'exp_patience_triumph',
        'name': 'Patience and Triumph',
        'description': 'Read the complete story of Yusuf (AS), exemplifying the transition from deep adversity to high authority.',
      },
      {
        'id': 'exp_sleepers_signs',
        'name': 'The Sleepers and the Signs',
        'description': 'Explore the story of the Companions of the Cave, Al-Khidr, and Dhul-Qarnayn.',
      },
      {
        'id': 'exp_creation_garden',
        'name': 'The Creation and the Garden',
        'description': 'Ponder the creation of Adam (AS), the prostration of the angels, and the descent to Earth.',
      },
      {
        'id': 'exp_ark_salvation',
        'name': 'The Ark of Salvation',
        'description': 'Follow Nuh\'s (AS) persistent calling, the construction of the Ark, and the division between disbelief and salvation.',
      },
      {
        'id': 'exp_kingdom_grace',
        'name': 'The Kingdom of Grace',
        'description': 'Examine the unique kingdoms granted to Dawud (AS) and Sulaiman (AS) and their gratitude to Allah.',
      },
      {
        'id': 'exp_pure_birth',
        'name': 'The Pure Birth',
        'description': 'Ponder the miraculous births of Yahya (AS) and Isa (AS) to Maryam (AS).',
      },
      {
        'id': 'exp_call_monotheism',
        'name': 'The Call of Monotheism',
        'description': 'Study the instructions and character traits commanded to the Prophet Muhammad ﷺ.',
      },
    ];

    for (final item in list) {
      await into(expeditions).insert(
        ExpeditionsCompanion.insert(
          id: item['id']!,
          name: item['name']!,
          description: Value(item['description']!),
          progress: const Value(0.0),
          isCompleted: const Value(false),
        ),
      );
    }
  }
}
