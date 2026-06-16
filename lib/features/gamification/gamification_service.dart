// lib/features/gamification/gamification_service.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/repositories/gamification_repository.dart';
import '../../core/repositories/entity_repository.dart';

part 'gamification_service.g.dart';

@riverpod
GamificationService gamificationService(GamificationServiceRef ref) {
  final gamificationRepo = ref.watch(gamificationRepositoryProvider);
  final entityRepo = ref.watch(entityRepositoryProvider);
  return GamificationService(gamificationRepo, entityRepo);
}

/// Service handling theme XP allocation, level progression, and
/// validating card collection sets.
class GamificationService {
  final GamificationRepository _gamificationRepo;
  final EntityRepository _entityRepo;

  GamificationService(this._gamificationRepo, this._entityRepo);

  /// Triggered after reading a verse to award XP to the relevant themes.
  ///
  /// Mapped to database `ThemeTriggers` triggers. If a match is found,
  /// awards `xpReward` to the target theme and checks for levels upgrade.
  ///
  /// [surahNum] The Surah read
  /// [ayahNum] The Ayah read
  Future<void> evaluateThemeXpTriggers(int surahNum, int ayahNum) async {
    final triggers = await _gamificationRepo.getThemeTriggers(''); // Query triggers
    for (final trigger in triggers) {
      if (trigger.surahNum == surahNum && trigger.ayahNum == ayahNum) {
        await _gamificationRepo.addThemeXp(trigger.themeId, trigger.xpReward);
      }
    }
  }

  /// Transaction-safe evaluation of set completion states.
  /// Called inside the database transaction context of `DiscoveryService`.
  ///
  /// Workflow:
  /// 1. Runs the check that iterates requirements for sets containing [entityId].
  /// 2. If all required entities are unlocked (`isDiscovered = true`),
  ///    updates the Set row: sets `isCompleted = true` AND `isVisible = true` atomically.
  ///
  /// [entityId] The ID of the entity that was recently discovered
  Future<void> checkSetCompletion(String entityId) async {
    // Evaluates hidden locked sets and completes them if all requirements are met
    await _gamificationRepo.evaluateHiddenSets();
  }

  /// Check all standard collection badges and mark completed if all entities are unlocked.
  Future<void> evaluateCollections() async {
    await _gamificationRepo.evaluateCollectionsCompletion();
  }
}
