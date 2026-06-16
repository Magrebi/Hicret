// lib/core/repositories/gamification_repository.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../local_db/app_database.dart';
import '../local_db/database_provider.dart';

part 'gamification_repository.g.dart';

abstract class GamificationRepository {
  // Stories
  Future<List<Story>> getAllStories();
  Future<List<StoryVerseRange>> getVerseRangesForStory(String storyId);
  Future<void> updateStoryProgress(String storyId, double progress);

  // Themes
  Future<List<Theme>> getAllThemes();
  Future<void> addThemeXp(String themeId, int xpAmount);
  Future<List<ThemeTrigger>> getThemeTriggers(String themeId);

  // Sets & Collections
  Future<List<SetsData>> getVisibleSets();
  Future<void> evaluateHiddenSets();
  Future<List<Collection>> getAllCollections();
  Future<void> evaluateCollectionsCompletion();
  Future<List<Expedition>> getAllExpeditions();
  Future<void> updateExpeditionProgress(String expeditionId, double progress);
}

class GamificationRepositoryImpl implements GamificationRepository {
  final AppDatabase _db;

  GamificationRepositoryImpl(this._db);

  @override
  Future<List<Story>> getAllStories() => _db.storyThemeDao.getAllStories();

  @override
  Future<List<StoryVerseRange>> getVerseRangesForStory(String storyId) =>
      _db.storyThemeDao.getVerseRangesForStory(storyId);

  @override
  Future<void> updateStoryProgress(String storyId, double progress) =>
      _db.storyThemeDao.updateStoryProgress(storyId, progress);

  @override
  Future<List<Theme>> getAllThemes() => _db.storyThemeDao.getAllThemes();

  @override
  Future<void> addThemeXp(String themeId, int xpAmount) =>
      _db.storyThemeDao.addThemeXp(themeId, xpAmount);

  @override
  Future<List<ThemeTrigger>> getThemeTriggers(String themeId) =>
      _db.storyThemeDao.getThemeTriggers(themeId);

  @override
  Future<List<SetsData>> getVisibleSets() => _db.setCollectionDao.getVisibleSets();

  @override
  Future<void> evaluateHiddenSets() => _db.setCollectionDao.evaluateHiddenSets();

  @override
  Future<List<Collection>> getAllCollections() => _db.setCollectionDao.getAllCollections();

  @override
  Future<void> evaluateCollectionsCompletion() =>
      _db.setCollectionDao.evaluateCollectionsCompletion();

  @override
  Future<List<Expedition>> getAllExpeditions() => _db.setCollectionDao.getAllExpeditions();

  @override
  Future<void> updateExpeditionProgress(String expeditionId, double progress) =>
      _db.setCollectionDao.updateExpeditionProgress(expeditionId, progress);
}

@riverpod
GamificationRepository gamificationRepository(GamificationRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return GamificationRepositoryImpl(db);
}
