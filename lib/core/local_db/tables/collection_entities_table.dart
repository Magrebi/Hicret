// lib/core/local_db/tables/collection_entities_table.dart

import 'package:drift/drift.dart';
import 'collections_table.dart';
import 'entities_table.dart';

class CollectionEntities extends Table {
  TextColumn get collectionId => text().references(Collections, #id, onDelete: KeyAction.cascade)();
  TextColumn get entityId => text().references(Entities, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {collectionId, entityId};
}
