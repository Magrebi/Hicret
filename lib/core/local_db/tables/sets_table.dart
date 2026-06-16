// lib/core/local_db/tables/sets_table.dart

import 'package:drift/drift.dart';

@DataClassName('SetsData')
class Sets extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant('// TODO: Tafsir — content team to supply'))();
  BoolColumn get isHidden => boolean().withDefault(const Constant(false))();
  BoolColumn get isVisible => boolean().withDefault(const Constant(false))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
