// lib/core/local_db/daos/story_theme_dao.dart

import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/stories_table.dart';
import '../tables/story_verse_ranges_table.dart';
import '../tables/themes_table.dart';
import '../tables/theme_levels_table.dart';
import '../tables/theme_triggers_table.dart';

part 'story_theme_dao.g.dart';

@DriftAccessor(tables: [Stories, StoryVerseRanges, Themes, ThemeLevels, ThemeTriggers])
class StoryThemeDao extends DatabaseAccessor<AppDatabase> with _$StoryThemeDaoMixin {
  StoryThemeDao(AppDatabase db) : super(db);

  /// Get all story arcs and their reading progress values
  Future<List<Story>> getAllStories() {
    return select(stories).get();
  }

  /// Get verse range triggers associated with a narrative story
  Future<List<StoryVerseRange>> getVerseRangesForStory(String storyId) {
    return (select(storyVerseRanges)..where((t) => t.storyId.equals(storyId))).get();
  }

  /// Update the progress fraction (0.0 to 1.0) of a story arc
  Future<void> updateStoryProgress(String storyId, double progress) {
    return (update(stories)..where((t) => t.id.equals(storyId))).write(
      StoriesCompanion(progressValue: Value(progress)),
    );
  }

  /// Get all gamified themes (sabr, shukr, etc.)
  Future<List<Theme>> getAllThemes() {
    return select(themes).get();
  }

  /// Award XP to a theme and handle level-up progressions
  Future<void> addThemeXp(String themeId, int xpAmount) async {
    await transaction(() async {
      // 1. Get the current theme status
      final currentTheme = await (select(themes)..where((t) => t.id.equals(themeId))).getSingle();
      
      int newXp = currentTheme.currentXp + xpAmount;
      int newMaxXp = currentTheme.maxXp;
      
      // 2. Query target level boundaries
      final levels = await (select(themeLevels)
            ..where((t) => t.themeId.equals(themeId))
            ..orderBy([(t) => OrderingTerm(expression: t.level)]))
          .get();
          
      // Check if XP threshold causes a level up
      for (final lvl in levels) {
        if (newXp >= lvl.xpRequired && lvl.xpRequired > currentTheme.currentXp) {
          // Soft ceiling trigger: adjust max scale dynamically if needed
          newMaxXp = lvl.xpRequired; 
        }
      }

      // 3. Write updated values
      await (update(themes)..where((t) => t.id.equals(themeId))).write(
        ThemesCompanion(
          currentXp: Value(newXp),
          maxXp: Value(newMaxXp),
        ),
      );
    });
  }

  /// Get triggers that award XP for a theme
  Future<List<ThemeTrigger>> getThemeTriggers(String themeId) {
    return (select(themeTriggers)..where((t) => t.themeId.equals(themeId))).get();
  }
}
