// lib/features/reader/user_progress_service.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/repositories/user_progress_repository.dart';

part 'user_progress_service.g.dart';

@riverpod
UserProgressService userProgressService(UserProgressServiceRef ref) {
  final repo = ref.watch(userProgressRepositoryProvider);
  return UserProgressService(repo);
}

/// Service handling the verification and tracking of user progress stats.
/// Directs reading streak updates and premium state checks.
class UserProgressService {
  final UserProgressRepository _progressRepo;

  UserProgressService(this._progressRepo);

  /// Invoked immediately upon marking a verse as read to check streak updates.
  ///
  /// Evaluates the difference in days between today and [UserProgressData.lastReadDate].
  /// - If read on the consecutive calendar day, increments streak count.
  /// - If read on the same day, preserves streak count.
  /// - If gap is greater than 1 day, resets streak count to 1.
  /// Also updates [UserProgressData.lastReadDate] to the current date.
  ///
  /// [surahNum] The Surah read
  /// [ayahNum] The Ayah read
  Future<void> recordReadingActivity(int surahNum, int ayahNum) async {
    // TODO: Fetch current progress, calculate days difference, and update streak via _progressRepo
  }

  /// Check streak continuity at app startup or home screen focus.
  ///
  /// Resets streak to 0 if the user missed reading for more than 24 hours
  /// since the last read date.
  /// Returns true if the streak is active, false if it was reset.
  Future<bool> verifyStreakContinuity() async {
    // TODO: Perform streak expiration checks
    return false;
  }

  /// Syncs user subscription status with RevenueCat SDK.
  ///
  /// Checks active customer entitlements. If active, updates the
  /// singleton user progress record's `premiumUnlocked` value to true.
  /// Returns the current entitlement status.
  Future<bool> checkPremiumStatus() async {
    // TODO: Resolve RevenueCat active entitlement status and write to DB
    return false;
  }
}
