// lib/core/local_db/tables/entities_table.dart

import 'package:drift/drift.dart';

class Entities extends Table {
  TextColumn get id => text()(); // e.g. "prophet_ibrahim"
  TextColumn get name => text()(); // e.g. "Abraham"
  TextColumn get type => text()(); // e.g. "prophet", "location", "nature", "theme", "matriarch"
  BoolColumn get isRare => boolean().withDefault(const Constant(false))();
  TextColumn get region => text().nullable()(); // e.g. "North Africa", "Hejaz"
  TextColumn get description => text().withDefault(const Constant('// TODO: Tafsir — content team to supply'))();
  BoolColumn get isDiscovered => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
