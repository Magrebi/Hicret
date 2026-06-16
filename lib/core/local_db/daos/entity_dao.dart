// lib/core/local_db/daos/entity_dao.dart

import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/entities_table.dart';
import '../tables/entity_triggers_table.dart';
import '../tables/relation_edges_table.dart';
import '../tables/constellation_edges_table.dart';
import '../tables/verses_table.dart';

part 'entity_dao.g.dart';

@DriftAccessor(tables: [Entities, EntityTriggers, RelationEdges, ConstellationEdges, Verses])
class EntityDao extends DatabaseAccessor<AppDatabase> with _$EntityDaoMixin {
  EntityDao(AppDatabase db) : super(db);

  /// Retrieve all discovered entities.
  /// `isRare` is natively exposed on all returned Entity objects.
  Future<List<Entity>> getDiscoveredEntities() {
    return (select(entities)..where((t) => t.isDiscovered.equals(true))).get();
  }

  /// Retrieve all undiscovered entities (for grid blurring).
  Future<List<Entity>> getUndiscoveredEntities() {
    return (select(entities)..where((t) => t.isDiscovered.equals(false))).get();
  }

  /// Retrieve all entities matching a specific category type.
  Future<List<Entity>> getEntitiesByType(String type) {
    return (select(entities)..where((t) => t.type.equals(type))).get();
  }

  /// Single-query join to fetch all discovered/unlocked entities for a specific Surah.
  /// Prevents N+1 query problem by doing a single join database-side.
  Future<List<Entity>> getUnlockedEntitiesForSurah(int surahNum) async {
    final query = select(entities).join([
      innerJoin(entityTriggers, entityTriggers.entityId.equalsExp(entities.id)),
      innerJoin(
        verses,
        verses.surahNum.equalsExp(entityTriggers.surahNum) &
            verses.ayahNum.equalsExp(entityTriggers.ayahNum),
      ),
    ])
      ..where(entityTriggers.surahNum.equals(surahNum) & verses.isRead.equals(true));

    final rows = await query.get();
    return rows.map((row) => row.readTable(entities)).toList();
  }

  /// Unlock/discover a specific entity.
  Future<void> discoverEntity(String entityId) {
    return (update(entities)..where((t) => t.id.equals(entityId))).write(
      const EntitiesCompanion(isDiscovered: Value(true)),
    );
  }

  /// Retrieve static relation edges (RelationEdges table).
  Future<List<RelationEdge>> getStaticRelationEdges() {
    return select(relationEdges).get();
  }

  /// Retrieve dynamic co-occurrence edges (ConstellationEdges table).
  Future<List<ConstellationEdge>> getDynamicConstellationEdges() {
    return select(constellationEdges).get();
  }

  /// Increment or insert dynamic co-occurrence edge weight between two entities.
  Future<void> recordCoOccurrence(String entityA, String entityB, int surah) async {
    // Standardize canonical ordering to prevent duplicate reciprocal edges (A->B and B->A)
    final first = entityA.compareTo(entityB) < 0 ? entityA : entityB;
    final second = first == entityA ? entityB : entityA;

    await customStatement(
      '''
      INSERT INTO constellation_edges (entity_a_id, entity_b_id, shared_surah, weight)
      VALUES (?, ?, ?, 1)
      ON CONFLICT(entity_a_id, entity_b_id, shared_surah)
      DO UPDATE SET weight = weight + 1;
      ''',
      [first, second, surah],
    );
  }
}
