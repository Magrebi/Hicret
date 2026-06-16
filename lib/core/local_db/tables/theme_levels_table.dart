// lib/core/local_db/tables/theme_levels_table.dart

import 'package:drift/drift.dart';
import 'themes_table.dart';

class ThemeLevels extends Table {
  TextColumn get themeId => text().references(Themes, #id, onDelete: KeyAction.cascade)();
  IntColumn get level => integer()();
  IntColumn get xpRequired => integer()();

  @override
  Set<Column> get primaryKey => {themeId, level};
}
