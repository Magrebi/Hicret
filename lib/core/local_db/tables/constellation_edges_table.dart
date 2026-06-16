// lib/core/local_db/tables/constellation_edges_table.dart

import 'package:drift/drift.dart';
import 'entities_table.dart';

class ConstellationEdges extends Table {
  TextColumn get entityAId => text().references(Entities, #id, onDelete: KeyAction.cascade)();
  TextColumn get entityBId => text().references(Entities, #id, onDelete: KeyAction.cascade)();
  IntColumn get sharedSurah => integer()();
  IntColumn get weight => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {entityAId, entityBId, sharedSurah};
}
