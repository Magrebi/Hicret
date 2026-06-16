// lib/core/local_db/tables/themes_table.dart

import 'package:drift/drift.dart';

class Themes extends Table {
  TextColumn get id => text()(); // e.g., "patience"
  TextColumn get name => text()(); // e.g., "Patience (Sabr)"
  TextColumn get icon => text()(); // e.g., "patience_plant"
  IntColumn get currentXp => integer().withDefault(const Constant(0))();
  IntColumn get maxXp => integer().withDefault(const Constant(100))();

  @override
  Set<Column> get primaryKey => {id};
}
