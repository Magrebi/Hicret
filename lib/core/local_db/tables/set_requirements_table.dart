// lib/core/local_db/tables/set_requirements_table.dart

import 'package:drift/drift.dart';
import 'sets_table.dart';
import 'entities_table.dart';

class SetRequirements extends Table {
  TextColumn get setId => text().references(Sets, #id, onDelete: KeyAction.cascade)();
  TextColumn get requiredEntityId => text().references(Entities, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {setId, requiredEntityId};
}
