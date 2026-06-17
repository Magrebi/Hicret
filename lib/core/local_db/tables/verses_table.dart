// lib/core/local_db/tables/verses_table.dart

import 'package:drift/drift.dart';

class Verses extends Table {
  IntColumn get surahNum => integer()();
  IntColumn get ayahNum => integer()();
  TextColumn get textArabic => text()();
  TextColumn get textTranslation => text()();
  TextColumn get textTranslationTr => text().nullable()();
  TextColumn get textTranslationDe => text().nullable()();
  TextColumn get textTranslationFr => text().nullable()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {surahNum, ayahNum};
}
