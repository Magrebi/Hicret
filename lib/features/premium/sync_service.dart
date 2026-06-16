// lib/features/premium/sync_service.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/repositories/user_progress_repository.dart';
import '../../core/repositories/entity_repository.dart';
import '../../core/repositories/gamification_repository.dart';

part 'sync_service.g.dart';

@riverpod
SyncService syncService(SyncServiceRef ref) {
  final progressRepo = ref.watch(userProgressRepositoryProvider);
  final entityRepo = ref.watch(entityRepositoryProvider);
  final gamificationRepo = ref.watch(gamificationRepositoryProvider);
  return SyncService(progressRepo, entityRepo, gamificationRepo);
}

/// Service handling cloud backup and recovery of reading progress.
/// Integrates with Cloud Firestore for secure, premium-tier data synchronization.
class SyncService {
  final UserProgressRepository _progressRepo;
  final EntityRepository _entityRepo;
  final GamificationRepository _gamificationRepo;

  SyncService(this._progressRepo, this._entityRepo, this._gamificationRepo);

  /// Back up the local database state to Cloud Firestore.
  ///
  /// CRITICAL RULES:
  /// - **Always call this post-result.** This method executes network requests to Firebase
  ///   and MUST NOT be called within any active database transactions (e.g. inside `DiscoveryService`
  ///   or `drift` transaction blocks) to prevent database thread lock-ups.
  ///
  /// Backs up:
  /// - User progress metrics (total verses, current streak, premium status)
  /// - Lists of discovered entity IDs
  /// - Bookmarked verses list
  /// - Theme XP progress metrics
  Future<void> backupLocalProgressToCloud() async {
    // TODO: Verify premium status, retrieve local data via repositories, and perform Firestore write
  }

  /// Recover user state from Cloud Firestore and write it to the local SQLite database.
  ///
  /// CRITICAL RULES:
  /// - **Always call this post-result.** This method downloads remote data
  ///   and MUST NOT run within local transaction locks.
  ///
  /// Restores and overwrites the local DB tables:
  /// - `UserProgress` (singleton)
  /// - `Bookmarks` list
  /// - `Entities` (discovery states)
  /// - `Themes` (current XP values)
  Future<void> restoreProgressFromCloud() async {
    // TODO: Pull data from Firestore and safely overwrite local databases tables
  }
}
