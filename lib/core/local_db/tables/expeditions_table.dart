// lib/core/local_db/tables/expeditions_table.dart

import 'package:drift/drift.dart';

class Expeditions extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant('// TODO: Tafsir — content team to supply'))();
  RealColumn get progress => real().withDefault(const Constant(0.0))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
