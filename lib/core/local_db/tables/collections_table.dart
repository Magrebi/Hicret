// lib/core/local_db/tables/collections_table.dart

import 'package:drift/drift.dart';

class Collections extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant('// TODO: Tafsir — content team to supply'))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
