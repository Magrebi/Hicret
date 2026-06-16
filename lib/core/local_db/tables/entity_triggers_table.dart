// lib/core/local_db/tables/entity_triggers_table.dart

import 'package:drift/drift.dart';
import 'entities_table.dart';

class EntityTriggers extends Table {
  TextColumn get entityId => text().references(Entities, #id, onDelete: KeyAction.cascade)();
  IntColumn get surahNum => integer()();
  IntColumn get ayahNum => integer()();

  @override
  Set<Column> get primaryKey => {entityId, surahNum, ayahNum};
}
