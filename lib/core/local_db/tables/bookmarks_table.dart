// lib/core/local_db/tables/bookmarks_table.dart

import 'package:drift/drift.dart';

class Bookmarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahNum => integer()();
  IntColumn get ayahNum => integer()();
  TextColumn get bookmarkedAt => text()();
}
