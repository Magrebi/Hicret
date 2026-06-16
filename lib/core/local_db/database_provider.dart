// lib/core/local_db/database_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'app_database.dart';

part 'database_provider.g.dart';

@riverpod
AppDatabase appDatabase(AppDatabaseRef ref) {
  final db = AppDatabase();
  ref.onDispose(() async {
    await db.close();
  });
  return db;
}
