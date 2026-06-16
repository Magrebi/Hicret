// lib/core/local_db/tables/theme_triggers_table.dart

import 'package:drift/drift.dart';
import 'themes_table.dart';

class ThemeTriggers extends Table {
  TextColumn get themeId => text().references(Themes, #id, onDelete: KeyAction.cascade)();
  IntColumn get surahNum => integer()();
  IntColumn get ayahNum => integer()();
  IntColumn get xpReward => integer().withDefault(const Constant(10))();

  @override
  Set<Column> get primaryKey => {themeId, surahNum, ayahNum};
}
