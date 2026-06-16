// lib/core/local_db/tables/story_verse_ranges_table.dart

import 'package:drift/drift.dart';
import 'stories_table.dart';

class StoryVerseRanges extends Table {
  TextColumn get storyId => text().references(Stories, #id, onDelete: KeyAction.cascade)();
  IntColumn get surahNum => integer()();
  IntColumn get ayahStart => integer()();
  IntColumn get ayahEnd => integer()();

  @override
  Set<Column> get primaryKey => {storyId, surahNum, ayahStart, ayahEnd};
}
