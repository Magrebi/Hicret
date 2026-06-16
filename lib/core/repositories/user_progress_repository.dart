// lib/core/repositories/user_progress_repository.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../local_db/app_database.dart';
import '../local_db/database_provider.dart';

part 'user_progress_repository.g.dart';

abstract class UserProgressRepository {
  Future<UserProgressData> getUserProgress();
  Future<void> updateUserStreak(int streakDays, String lastReadDate);
}

class UserProgressRepositoryImpl implements UserProgressRepository {
  final AppDatabase _db;

  UserProgressRepositoryImpl(this._db);

  @override
  Future<UserProgressData> getUserProgress() {
    return _db.readerDao.getUserProgress();
  }

  @override
  Future<void> updateUserStreak(int streakDays, String lastReadDate) {
    return _db.readerDao.updateUserStreak(streakDays, lastReadDate);
  }
}

@riverpod
UserProgressRepository userProgressRepository(UserProgressRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return UserProgressRepositoryImpl(db);
}
