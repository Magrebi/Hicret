// lib/core/local_db/database_seeder.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:drift/drift.dart';
import 'app_database.dart' hide Theme;

/// Dynamically populates the database from assets/data/entities.json.
Future<void> seedDatabaseFromJson(AppDatabase db) async {
  final jsonString = await rootBundle.loadString('assets/data/entities.json');
  final Map<String, dynamic> data = json.decode(jsonString);

  await db.transaction(() async {
    // 1. Seed Collections
    await db.into(db.collections).insert(
      const CollectionsCompanion(
        id: Value('col_animals'),
        name: Value('Animals of the Quran'),
        description: Value('All major animal species mentioned in the Quranic narrative.'),
      ),
    );
    await db.into(db.collections).insert(
      const CollectionsCompanion(
        id: Value('col_plants'),
        name: Value('Plants of the Quran'),
        description: Value('Blessed trees and plants highlighted as signs of divine creation.'),
      ),
    );
    await db.into(db.collections).insert(
      const CollectionsCompanion(
        id: Value('col_foods'),
        name: Value('Foods of the Quran'),
        description: Value('Nourishing foods and provisions blessed by divine revelation.'),
      ),
    );

    // Helper to strip tags: e.g. "9:30 [VERIFY]" -> "9:30"
    String stripTag(String val) {
      return val.replaceAll(RegExp(r'\s*\[(VERIFY[^\]]*|TRADITIONAL[^\]]*|CONFIRM ID EXISTS[^\]]*)\]'), '').trim();
    }

    // Helper to parse verse ref like "12:4" -> (surahNum, ayahNum)
    (int, int) parseVerse(String ref) {
      final clean = stripTag(ref);
      final parts = clean.split(':');
      return (int.parse(parts[0]), int.parse(parts[1]));
    }

    // Helper to parse verse range like "12:4-102" or "12:4" -> (surahNum, start, end)
    (int, int, int) parseVerseRange(String ref) {
      final clean = stripTag(ref);
      final parts = clean.split(':');
      final surahNum = int.parse(parts[0]);
      if (parts[1].contains('-')) {
        final rangeParts = parts[1].split('-');
        return (surahNum, int.parse(rangeParts[0]), int.parse(rangeParts[1]));
      } else {
        final ayah = int.parse(parts[1]);
        return (surahNum, ayah, ayah);
      }
    }

    // 2. Seed Characters
    final List<dynamic> characters = data['characters'] ?? [];
    for (final char in characters) {
      final id = char['id'] as String;
      final name = char['name'] as String;
      final type = char['type'] as String;
      final isRare = char['is_rare'] as bool? ?? false;
      final description = char['description'] as String? ?? '';

      await db.into(db.entities).insert(
        EntitiesCompanion.insert(
          id: id,
          name: name,
          type: type,
          isRare: Value(isRare),
          region: const Value(null),
          description: Value(description),
        ),
      );

      final List<dynamic> triggerVerses = char['trigger_verses'] ?? [];
      for (final ref in triggerVerses) {
        final (surah, ayah) = parseVerse(ref as String);
        await db.into(db.entityTriggers).insert(
          EntityTriggersCompanion.insert(
            entityId: id,
            surahNum: surah,
            ayahNum: ayah,
          ),
        );
      }
    }

    // We'll insert relation edges *after* all entities are inserted, to satisfy foreign keys
    final List<(String, String)> relationPairs = [];
    for (final char in characters) {
      final id = char['id'] as String;
      final List<dynamic> relations = char['relations'] ?? [];
      for (final rel in relations) {
        relationPairs.add((id, stripTag(rel as String)));
      }
    }

    // 3. Seed Locations
    final List<dynamic> locations = data['locations'] ?? [];
    for (final loc in locations) {
      final id = loc['id'] as String;
      final name = loc['name'] as String;
      final coordinatesHint = loc['coordinates_hint'] as String? ?? '';
      final description = loc['description'] as String? ?? '';

      await db.into(db.entities).insert(
        EntitiesCompanion.insert(
          id: id,
          name: name,
          type: 'location',
          isRare: const Value(false),
          region: Value(coordinatesHint),
          description: Value(description),
        ),
      );

      final List<dynamic> triggerVerses = loc['trigger_verses'] ?? [];
      for (final ref in triggerVerses) {
        final (surah, ayah) = parseVerse(ref as String);
        await db.into(db.entityTriggers).insert(
          EntityTriggersCompanion.insert(
            entityId: id,
            surahNum: surah,
            ayahNum: ayah,
          ),
        );
      }
    }

    // 4. Seed Collections: animals, plants, foods
    final collectionsData = data['collections'] ?? {};

    // Animals
    final List<dynamic> animals = collectionsData['animals'] ?? [];
    for (final anim in animals) {
      final id = anim['id'] as String;
      final name = anim['name'] as String;
      final description = anim['description'] as String? ?? '';

      await db.into(db.entities).insert(
        EntitiesCompanion.insert(
          id: id,
          name: name,
          type: 'animal',
          isRare: const Value(false),
          region: const Value(null),
          description: Value(description),
        ),
      );

      await db.into(db.collectionEntities).insert(
        CollectionEntitiesCompanion.insert(
          collectionId: 'col_animals',
          entityId: id,
        ),
      );

      final List<dynamic> triggerVerses = anim['trigger_verses'] ?? [];
      for (final ref in triggerVerses) {
        final (surah, ayah) = parseVerse(ref as String);
        await db.into(db.entityTriggers).insert(
          EntityTriggersCompanion.insert(
            entityId: id,
            surahNum: surah,
            ayahNum: ayah,
          ),
        );
      }
    }

    // Plants
    final List<dynamic> plants = collectionsData['plants'] ?? [];
    for (final plant in plants) {
      final id = plant['id'] as String;
      final name = plant['name'] as String;
      final description = plant['description'] as String? ?? '';

      await db.into(db.entities).insert(
        EntitiesCompanion.insert(
          id: id,
          name: name,
          type: 'plant',
          isRare: const Value(false),
          region: const Value(null),
          description: Value(description),
        ),
      );

      await db.into(db.collectionEntities).insert(
        CollectionEntitiesCompanion.insert(
          collectionId: 'col_plants',
          entityId: id,
        ),
      );

      final List<dynamic> triggerVerses = plant['trigger_verses'] ?? [];
      for (final ref in triggerVerses) {
        final (surah, ayah) = parseVerse(ref as String);
        await db.into(db.entityTriggers).insert(
          EntityTriggersCompanion.insert(
            entityId: id,
            surahNum: surah,
            ayahNum: ayah,
          ),
        );
      }
    }

    // Foods
    final List<dynamic> foods = collectionsData['foods'] ?? [];
    for (final food in foods) {
      final id = food['id'] as String;
      final name = food['name'] as String;
      final description = food['description'] as String? ?? '';

      await db.into(db.entities).insert(
        EntitiesCompanion.insert(
          id: id,
          name: name,
          type: 'food',
          isRare: const Value(false),
          region: const Value(null),
          description: Value(description),
        ),
      );

      await db.into(db.collectionEntities).insert(
        CollectionEntitiesCompanion.insert(
          collectionId: 'col_foods',
          entityId: id,
        ),
      );

      final List<dynamic> triggerVerses = food['trigger_verses'] ?? [];
      for (final ref in triggerVerses) {
        final (surah, ayah) = parseVerse(ref as String);
        await db.into(db.entityTriggers).insert(
          EntityTriggersCompanion.insert(
            entityId: id,
            surahNum: surah,
            ayahNum: ayah,
          ),
        );
      }
    }

    // Insert relation edges now that all entities (characters, locations, etc.) are in the database
    for (final pair in relationPairs) {
      await db.into(db.relationEdges).insert(
        RelationEdgesCompanion.insert(
          entityAId: pair.$1,
          entityBId: pair.$2,
          relationType: 'related',
        ),
      );
    }

    // 5. Seed Stories
    final List<dynamic> stories = data['stories'] ?? [];
    for (final story in stories) {
      final id = story['id'] as String;
      final name = story['name'] as String;

      // Stories are also registered in Entities to allow reference tracking in Sets & Discovery
      await db.into(db.entities).insert(
        EntitiesCompanion.insert(
          id: id,
          name: name,
          type: 'story',
          isRare: const Value(false),
          region: const Value(null),
          description: Value(name),
        ),
      );

      await db.into(db.stories).insert(
        StoriesCompanion.insert(
          id: id,
          title: name,
          description: Value(name),
        ),
      );

      final List<dynamic> completionVerses = story['completion_verses'] ?? [];
      for (final ref in completionVerses) {
        final (surah, start, end) = parseVerseRange(ref as String);
        await db.into(db.storyVerseRanges).insert(
          StoryVerseRangesCompanion.insert(
            storyId: id,
            surahNum: surah,
            ayahStart: start,
            ayahEnd: end,
          ),
        );
      }
    }

    // 6. Seed Themes
    final List<dynamic> themes = data['themes'] ?? [];
    for (final theme in themes) {
      final id = theme['id'] as String;
      final name = theme['name'] as String;
      final iconMap = {
        'theme_patience': 'sabr_plant',
        'theme_gratitude': 'shukr_plant',
        'theme_justice': 'justice_scale',
        'theme_mercy': 'mercy_heart',
        'theme_tawakkul': 'trust_shield',
        'theme_repentance': 'tawbah_gate',
        'theme_charity': 'charity_hand',
        'theme_humility': 'humility_leaf',
      };
      final icon = iconMap[id] ?? 'theme_default';

      await db.into(db.themes).insert(
        ThemesCompanion.insert(
          id: id,
          name: name,
          icon: icon,
          currentXp: const Value(0),
          maxXp: const Value(100),
        ),
      );

      final List<dynamic> levels = theme['levels'] ?? [];
      for (final lvl in levels) {
        final levelNum = lvl['level'] as int;
        final xpRequired = lvl['xp_required'] as int;

        await db.into(db.themeLevels).insert(
          ThemeLevelsCompanion.insert(
            themeId: id,
            level: levelNum,
            xpRequired: xpRequired,
          ),
        );
      }

      final List<dynamic> xpTriggers = theme['xp_triggers'] ?? [];
      for (final trg in xpTriggers) {
        final verseRef = trg['verse'] as String;
        final xpReward = trg['xp_reward'] as int;
        final (surah, ayah) = parseVerse(verseRef);

        await db.into(db.themeTriggers).insert(
          ThemeTriggersCompanion.insert(
            themeId: id,
            surahNum: surah,
            ayahNum: ayah,
            xpReward: Value(xpReward),
          ),
        );
      }
    }

    // 7. Seed Sets & Combos
    final List<dynamic> sets = data['sets_and_combos'] ?? [];
    for (final s in sets) {
      final id = s['id'] as String;
      final name = s['name'] as String;
      final rewardTitle = s['reward_title'] as String;
      final isHidden = s['is_hidden'] as bool? ?? false;

      await db.into(db.sets).insert(
        SetsCompanion.insert(
          id: id,
          name: name,
          description: Value(rewardTitle),
          isHidden: Value(isHidden),
          isVisible: Value(!isHidden),
        ),
      );

      final List<dynamic> requiredDiscoveries = s['required_discoveries'] ?? [];
      for (final req in requiredDiscoveries) {
        await db.into(db.setRequirements).insert(
          SetRequirementsCompanion.insert(
            setId: id,
            requiredEntityId: stripTag(req as String),
          ),
        );
      }
    }
  });
}
