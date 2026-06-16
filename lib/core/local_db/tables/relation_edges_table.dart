// lib/core/local_db/tables/relation_edges_table.dart

import 'package:drift/drift.dart';
import 'entities_table.dart';

class RelationEdges extends Table {
  TextColumn get entityAId => text().references(Entities, #id, onDelete: KeyAction.cascade)();
  TextColumn get entityBId => text().references(Entities, #id, onDelete: KeyAction.cascade)();
  TextColumn get relationType => text()(); // e.g., "father", "son", "spouse", "messenger_to"

  @override
  Set<Column> get primaryKey => {entityAId, entityBId, relationType};
}
