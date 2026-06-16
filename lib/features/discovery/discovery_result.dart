// lib/features/discovery/discovery_result.dart

import '../../core/local_db/app_database.dart';

/// Models representing theme XP awarded after a verse read.
class ThemeXpEvent {
  final String themeId;
  final int xpAwarded;
  final int currentXp;
  final int maxXp;
  final bool levelUp;
  final int newLevel;

  ThemeXpEvent({
    required this.themeId,
    required this.xpAwarded,
    required this.currentXp,
    required this.maxXp,
    required this.levelUp,
    required this.newLevel,
  });
}

/// Models representing story progression milestones.
class StoryEvent {
  final String storyId;
  final double progress;
  final bool isCompleted;

  StoryEvent({
    required this.storyId,
    required this.progress,
    required this.isCompleted,
  });
}

/// Consolidated transaction outcome containing unlocked entities and earned achievements.
class DiscoveryResult {
  final List<Entity> unlocks;
  final List<ThemeXpEvent> xpEvents;
  final List<StoryEvent> storyEvents;
  final List<SetsData> setCompletions;

  DiscoveryResult({
    required this.unlocks,
    required this.xpEvents,
    required this.storyEvents,
    required this.setCompletions,
  });

  /// Helper getter determining if a rare bottom sheet layout is triggered.
  bool get hasRareUnlock => unlocks.any((e) => e.isRare);
}
