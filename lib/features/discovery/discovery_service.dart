// lib/features/discovery/discovery_service.dart

import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/local_db/app_database.dart';
import '../../core/local_db/database_provider.dart';
import '../constellation/constellation_notifier.dart';

import 'discovery_result.dart';

part 'discovery_service.g.dart';

@riverpod
DiscoveryService discoveryService(DiscoveryServiceRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return DiscoveryService(db, ref);
}

/// Service handling the evaluation of discovery unlocks when a user reads an Ayah.
class DiscoveryService {
  final AppDatabase _db;
  final DiscoveryServiceRef _ref;

  DiscoveryService(this._db, this._ref);

  /// Evaluates triggers when an Ayah is marked as read.
  /// 
  /// Concurrency Rules:
  /// - Rule 1: All operations are wrapped in exactly ONE drift database transaction.
  /// - Rule 2: The [DiscoveryResult] is constructed strictly from committed database states,
  ///   never returned optimistically.
  /// 
  /// [surah] The Surah index (1 to 114)
  /// [ayah] The Ayah index inside the Surah
  Future<DiscoveryResult> processAyahRead(int surah, int ayah) async {
    final result = await _db.transaction(() async {
      // 1. Log the verse itself as read in the database
      final match = await (_db.select(_db.verses)
            ..where((t) => t.surahNum.equals(surah) & t.ayahNum.equals(ayah)))
          .getSingleOrNull();

      // Safeguard: If already read, return empty events immediately to prevent duplicate increments
      if (match != null && match.isRead) {
        return DiscoveryResult(
          unlocks: [],
          xpEvents: [],
          storyEvents: [],
          setCompletions: [],
        );
      }

      if (match == null) {
        await _db.into(_db.verses).insert(
          VersesCompanion.insert(
            surahNum: surah,
            ayahNum: ayah,
            textArabic: '',
            textTranslation: '',
            isRead: const Value(true),
          ),
        );
      } else {
        await (_db.update(_db.verses)
              ..where((t) => t.surahNum.equals(surah) & t.ayahNum.equals(ayah)))
            .write(const VersesCompanion(isRead: Value(true)));
      }

      // 2. Unlock entities matching triggers
      final unlocks = await _unlockEntities(surah, ayah);

      // 3. Award theme XP and calculate level progressions
      final xpEvents = await _awardThemeXp(surah, ayah);

      // 4. Update stories progress via range checks
      final storyEvents = await _updateStoryProgress(surah, ayah);

      // 5. Check and update collection completions
      await _updateCollectionsCompletion();

      // 6. Check and unlock custom sets atomically
      final setEvents = await _checkSetCompletion(unlocks);

      // 7. Update dynamic co-occurrence constellation edges
      await _updateConstellationEdges(unlocks, surah);

      // 7.5. Update reading routes (expeditions) progress
      await _updateExpeditionProgress(surah, ayah);

      // 8. Increment user read count in singleton Progress table
      await _updateUserProgress();

      return DiscoveryResult(
        unlocks: unlocks,
        xpEvents: xpEvents,
        storyEvents: storyEvents,
        setCompletions: setEvents,
      );
    });

    // 9. Coordinate with the Constellation state manager (only if it is already initialized/active)
    if (_ref.exists(constellationNotifierProvider)) {
      _ref.read(constellationNotifierProvider.notifier).scheduleRefresh();
    }

    return result;
  }

  /// Private transaction helper to unlock entities associated with triggers on this verse.
  Future<List<Entity>> _unlockEntities(int surah, int ayah) async {
    final triggered = await (_db.select(_db.entityTriggers)
          ..where((t) => t.surahNum.equals(surah) & t.ayahNum.equals(ayah)))
        .get();

    final unlockedEntities = <Entity>[];

    for (final trigger in triggered) {
      final entity = await (_db.select(_db.entities)
            ..where((t) => t.id.equals(trigger.entityId)))
          .getSingleOrNull();

      if (entity != null && !entity.isDiscovered) {
        await (_db.update(_db.entities)..where((t) => t.id.equals(entity.id))).write(
          const EntitiesCompanion(isDiscovered: Value(true)),
        );
        // Add updated object with isDiscovered = true
        unlockedEntities.add(entity.copyWith(isDiscovered: true));
      }
    }

    return unlockedEntities;
  }

  /// Private transaction helper to award theme XP and verify level upgrades.
  Future<List<ThemeXpEvent>> _awardThemeXp(int surah, int ayah) async {
    final triggers = await (_db.select(_db.themeTriggers)
          ..where((t) => t.surahNum.equals(surah) & t.ayahNum.equals(ayah)))
        .get();

    final xpEvents = <ThemeXpEvent>[];

    for (final trigger in triggers) {
      final themeObj = await (_db.select(_db.themes)
            ..where((t) => t.id.equals(trigger.themeId)))
          .getSingleOrNull();

      if (themeObj != null) {
        final levels = await (_db.select(_db.themeLevels)
              ..where((t) => t.themeId.equals(themeObj.id))
              ..orderBy([(t) => OrderingTerm(expression: t.xpRequired)]))
            .get();

        final currentXp = themeObj.currentXp;
        final newXp = currentXp + trigger.xpReward;

        // Calculate old and new derived levels based on thresholds
        int oldLevel = 0;
        int newLevel = 0;
        int currentMaxXp = themeObj.maxXp;

        for (final lvl in levels) {
          if (currentXp >= lvl.xpRequired) oldLevel = lvl.level;
          if (newXp >= lvl.xpRequired) newLevel = lvl.level;
        }

        final levelUp = newLevel > oldLevel;
        
        // Mapped to next level boundary
        if (newLevel < levels.length) {
          currentMaxXp = levels[newLevel].xpRequired;
        }

        await (_db.update(_db.themes)..where((t) => t.id.equals(themeObj.id))).write(
          ThemesCompanion(
            currentXp: Value(newXp),
            maxXp: Value(currentMaxXp),
          ),
        );

        xpEvents.add(
          ThemeXpEvent(
            themeId: themeObj.id,
            xpAwarded: trigger.xpReward,
            currentXp: newXp,
            maxXp: currentMaxXp,
            levelUp: levelUp,
            newLevel: newLevel,
          ),
        );
      }
    }

    return xpEvents;
  }

  /// Private transaction helper to update story metrics via range evaluations.
  Future<List<StoryEvent>> _updateStoryProgress(int surah, int ayah) async {
    final allStories = await _db.select(_db.stories).get();
    final storyEvents = <StoryEvent>[];

    for (final story in allStories) {
      final ranges = await (_db.select(_db.storyVerseRanges)
            ..where((t) => t.storyId.equals(story.id)))
          .get();

      bool affected = false;
      for (final r in ranges) {
        if (_ayahInRange(surah, ayah, r)) {
          affected = true;
          break;
        }
      }

      if (affected) {
        // Recalculate complete reading fraction within all ranges of this story
        int totalRead = 0;
        int totalVersesInRanges = 0;

        for (final r in ranges) {
          final totalInRange = (r.ayahEnd - r.ayahStart) + 1;
          totalVersesInRanges += totalInRange;

          final readCount = await (_db.select(_db.verses)
                ..where((t) =>
                    t.surahNum.equals(r.surahNum) &
                    t.ayahNum.isBiggerOrEqualValue(r.ayahStart) &
                    t.ayahNum.isSmallerOrEqualValue(r.ayahEnd) &
                    t.isRead.equals(true)))
              .get();

          totalRead += readCount.length;
        }

        final progress = totalVersesInRanges > 0 ? totalRead / totalVersesInRanges : 0.0;

        await (_db.update(_db.stories)..where((t) => t.id.equals(story.id))).write(
          StoriesCompanion(progressValue: Value(progress)),
        );

        storyEvents.add(
          StoryEvent(
            storyId: story.id,
            progress: progress,
            isCompleted: progress >= 1.0,
          ),
        );
      }
    }

    return storyEvents;
  }

  /// Check all global collections and mark them as completed if all constituent elements are unlocked.
  Future<void> _updateCollectionsCompletion() async {
    final incomplete = await (_db.select(_db.collections)
          ..where((t) => t.isCompleted.equals(false)))
        .get();

    for (final coll in incomplete) {
      // Find associated entities that are still undiscovered
      final query = _db.select(_db.collectionEntities).join([
        innerJoin(_db.entities, _db.entities.id.equalsExp(_db.collectionEntities.entityId)),
      ])
        ..where(_db.collectionEntities.collectionId.equals(coll.id) & _db.entities.isDiscovered.equals(false));

      final undiscovered = await query.get();

      if (undiscovered.isEmpty) {
        await (_db.update(_db.collections)..where((t) => t.id.equals(coll.id))).write(
          const CollectionsCompanion(isCompleted: Value(true)),
        );
      }
    }
  }

  /// Evaluates and unlocks custom sets atomically inside the transaction.
  Future<List<SetsData>> _checkSetCompletion(List<Entity> newlyUnlocked) async {
    final completedSets = <SetsData>[];

    for (final entity in newlyUnlocked) {
      // Find all sets requiring this entity
      final requirements = await (_db.select(_db.setRequirements)
            ..where((t) => t.requiredEntityId.equals(entity.id)))
          .get();

      for (final req in requirements) {
        final setItem = await (_db.select(_db.sets)
              ..where((t) => t.id.equals(req.setId)))
            .getSingleOrNull();

        // Evaluate if already complete
        if (setItem != null && !setItem.isCompleted) {
          // Check for any remaining undiscovered required entities for this set
          final query = _db.select(_db.setRequirements).join([
            innerJoin(_db.entities, _db.entities.id.equalsExp(_db.setRequirements.requiredEntityId)),
          ])
            ..where(_db.setRequirements.setId.equals(setItem.id) & _db.entities.isDiscovered.equals(false));

          final undiscovered = await query.get();

          if (undiscovered.isEmpty) {
            // Write set updates atomically
            await (_db.update(_db.sets)..where((t) => t.id.equals(setItem.id))).write(
              const SetsCompanion(
                isCompleted: Value(true),
                isVisible: Value(true),
              ),
            );

            completedSets.add(setItem.copyWith(isCompleted: true, isVisible: true));
          }
        }
      }
    }

    return completedSets;
  }

  /// Create and update co-occurrence edges between unlocked entities in the same verse.
  Future<void> _updateConstellationEdges(List<Entity> unlocks, int surah) async {
    if (unlocks.length >= 2) {
      for (int i = 0; i < unlocks.length; i++) {
        for (int j = i + 1; j < unlocks.length; j++) {
          final idA = unlocks[i].id;
          final idB = unlocks[j].id;

          // Standardize ordering lexicographically to keep single undirected edge representation
          final first = idA.compareTo(idB) < 0 ? idA : idB;
          final second = first == idA ? idB : idA;

          await _db.entityDao.recordCoOccurrence(first, second, surah);
        }
      }
    }
  }

  /// Update the global progress table count.
  Future<void> _updateUserProgress() async {
    await _db.customStatement(
      'UPDATE user_progress SET total_verses_read = total_verses_read + 1 WHERE id = 1;',
    );
  }

  /// Helper to check if a specific verse falls inside a story range.
  bool _ayahInRange(int surah, int ayah, StoryVerseRange range) {
    return surah == range.surahNum &&
        ayah >= range.ayahStart &&
        ayah <= range.ayahEnd;
  }

  /// Private transaction helper to recalculate progress for all expeditions affected by the read verse.
  Future<void> _updateExpeditionProgress(int surah, int ayah) async {
    final Map<String, List<List<int>>> routes = {
      'exp_exodus': [[28, 3, 46], [20, 9, 98]],
      'exp_wisdom_luqman': [[31, 12, 19]],
      'exp_covenant_abraham': [[6, 74, 83], [2, 124, 128], [37, 99, 113]],
      'exp_patience_triumph': [[12, 4, 101]],
      'exp_sleepers_signs': [[18, 9, 26], [18, 60, 82], [18, 83, 98]],
      'exp_creation_garden': [[2, 30, 39], [7, 11, 25]],
      'exp_ark_salvation': [[11, 25, 49], [71, 1, 28]],
      'exp_kingdom_grace': [[27, 15, 44], [38, 17, 40]],
      'exp_pure_birth': [[19, 1, 36], [3, 33, 47]],
      'exp_call_monotheism': [[96, 1, 5], [73, 1, 10], [68, 1, 4]],
    };

    for (final entry in routes.entries) {
      final expId = entry.key;
      final ranges = entry.value;

      bool affected = false;
      for (final r in ranges) {
        if (surah == r[0] && ayah >= r[1] && ayah <= r[2]) {
          affected = true;
          break;
        }
      }

      if (affected) {
        int totalRead = 0;
        int totalVersesInRanges = 0;

        for (final r in ranges) {
          final sNum = r[0];
          final aStart = r[1];
          final aEnd = r[2];
          final totalInRange = (aEnd - aStart) + 1;
          totalVersesInRanges += totalInRange;

          final readCount = await (_db.select(_db.verses)
                ..where((t) =>
                    t.surahNum.equals(sNum) &
                    t.ayahNum.isBiggerOrEqualValue(aStart) &
                    t.ayahNum.isSmallerOrEqualValue(aEnd) &
                    t.isRead.equals(true)))
              .get();

          totalRead += readCount.length;
        }

        final progress = totalVersesInRanges > 0 ? totalRead / totalVersesInRanges : 0.0;
        final isCompleted = progress >= 1.0;

        await (_db.update(_db.expeditions)..where((t) => t.id.equals(expId))).write(
          ExpeditionsCompanion(
            progress: Value(progress),
            isCompleted: Value(isCompleted),
          ),
        );
      }
    }
  }
}
