// lib/core/local_db/tables/user_progress_table.dart

import 'package:drift/drift.dart';

@DataClassName('UserProgressData')
class UserProgress extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  IntColumn get totalVersesRead => integer().withDefault(const Constant(0))();
  IntColumn get streakDays => integer().withDefault(const Constant(0))();
  TextColumn get lastReadDate => text().nullable()();
  BoolColumn get premiumUnlocked => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
