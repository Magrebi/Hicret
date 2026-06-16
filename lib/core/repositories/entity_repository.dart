// lib/core/repositories/entity_repository.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../local_db/app_database.dart';
import '../local_db/database_provider.dart';

part 'entity_repository.g.dart';

abstract class EntityRepository {
  Future<List<Entity>> getDiscoveredEntities();
  Future<List<Entity>> getUndiscoveredEntities();
  Future<List<Entity>> getEntitiesByType(String type);
  Future<List<Entity>> getUnlockedEntitiesForSurah(int surahNum);
  Future<void> discoverEntity(String entityId);
  Future<List<RelationEdge>> getStaticRelationEdges();
  Future<List<ConstellationEdge>> getDynamicConstellationEdges();
  Future<void> recordCoOccurrence(String entityA, String entityB, int surah);
}

class EntityRepositoryImpl implements EntityRepository {
  final AppDatabase _db;

  EntityRepositoryImpl(this._db);

  @override
  Future<List<Entity>> getDiscoveredEntities() => _db.entityDao.getDiscoveredEntities();

  @override
  Future<List<Entity>> getUndiscoveredEntities() => _db.entityDao.getUndiscoveredEntities();

  @override
  Future<List<Entity>> getEntitiesByType(String type) => _db.entityDao.getEntitiesByType(type);

  @override
  Future<List<Entity>> getUnlockedEntitiesForSurah(int surahNum) =>
      _db.entityDao.getUnlockedEntitiesForSurah(surahNum);

  @override
  Future<void> discoverEntity(String entityId) => _db.entityDao.discoverEntity(entityId);

  @override
  Future<List<RelationEdge>> getStaticRelationEdges() => _db.entityDao.getStaticRelationEdges();

  @override
  Future<List<ConstellationEdge>> getDynamicConstellationEdges() =>
      _db.entityDao.getDynamicConstellationEdges();

  @override
  Future<void> recordCoOccurrence(String entityA, String entityB, int surah) =>
      _db.entityDao.recordCoOccurrence(entityA, entityB, surah);
}

@riverpod
EntityRepository entityRepository(EntityRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return EntityRepositoryImpl(db);
}
