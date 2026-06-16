// lib/core/local_db/tables/stories_table.dart

import 'package:drift/drift.dart';

class Stories extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().withDefault(const Constant('// TODO: Tafsir — content team to supply'))();
  RealColumn get progressValue => real().withDefault(const Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}
