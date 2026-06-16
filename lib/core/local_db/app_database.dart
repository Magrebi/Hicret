// lib/core/local_db/app_database.dart

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// Import all Drift tables
import 'tables/verses_table.dart';
import 'tables/entities_table.dart';
import 'tables/entity_triggers_table.dart';
import 'tables/relation_edges_table.dart';
import 'tables/constellation_edges_table.dart';
import 'tables/stories_table.dart';
import 'tables/story_verse_ranges_table.dart';
import 'tables/themes_table.dart';
import 'tables/theme_levels_table.dart';
import 'tables/theme_triggers_table.dart';
import 'tables/sets_table.dart';
import 'tables/set_requirements_table.dart';
import 'tables/collections_table.dart';
import 'tables/collection_entities_table.dart';
import 'tables/expeditions_table.dart';
import 'tables/user_progress_table.dart';
import 'tables/bookmarks_table.dart';

// Import all DAOs
import 'daos/reader_dao.dart';
import 'daos/entity_dao.dart';
import 'daos/story_theme_dao.dart';
import 'daos/set_collection_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Verses,
    Entities,
    EntityTriggers,
    RelationEdges,
    ConstellationEdges,
    Stories,
    StoryVerseRanges,
    Themes,
    ThemeLevels,
    ThemeTriggers,
    Sets,
    SetRequirements,
    Collections,
    CollectionEntities,
    Expeditions,
    UserProgress,
    Bookmarks,
  ],
  daos: [
    ReaderDao,
    EntityDao,
    StoryThemeDao,
    SetCollectionDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      
      // Initialize the UserProgress singleton row with default values
      await into(userProgress).insert(
        UserProgressCompanion.insert(
          id: const Value(1),
          totalVersesRead: const Value(0),
          streakDays: const Value(0),
          premiumUnlocked: const Value(false),
        ),
      );
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        // Migration logic for schema v1 -> v2
        // Scenario: Appending `isRare` to Entities table and creating `ConstellationEdges` 
        // to separate dynamic co-occurrences from staticRelation edges (split edges requirement).
        
        await transaction(() async {
          // 1. Add `isRare` column to the `Entities` table
          await m.addColumn(entities, entities.isRare);
          
          // 2. Add `region` column to the `Entities` table
          await m.addColumn(entities, entities.region);

          // 3. Create the new dynamic `ConstellationEdges` table to separate static and dynamic relationships
          await m.create(constellationEdges);
        });
      }
    },
    beforeOpen: (details) async {
      // Enforce SQLite Foreign Key constraints at runtime
      await customStatement('PRAGMA foreign_keys = ON;');
    },
  );
}

/// Helper method to create a LazyDatabase connection to SQLite.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // Locate the documents directory on Android/iOS
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'qka_local_database.sqlite'));
    
    // Use NativeDatabase in-background execution to avoid UI thread blocking
    return NativeDatabase.createInBackground(file);
  });
}
