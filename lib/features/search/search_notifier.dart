// lib/features/search/search_notifier.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/local_db/app_database.dart' hide Theme;
import '../../core/local_db/database_provider.dart';
import '../home/surah_data.dart';

part 'search_notifier.g.dart';

class SearchResultSurah {
  final SurahData surah;
  const SearchResultSurah(this.surah);
}

class SearchResultEntity {
  final Entity entity;
  const SearchResultEntity(this.entity);
}

class SearchResultCollection {
  final String id;
  final String name;
  final bool isSet;
  const SearchResultCollection({
    required this.id,
    required this.name,
    required this.isSet,
  });
}

class SearchResults {
  final List<SearchResultSurah> surahs;
  final List<SearchResultEntity> entities;
  final List<SearchResultCollection> collections;
  final bool isEmpty;

  SearchResults({
    required this.surahs,
    required this.entities,
    required this.collections,
  }) : isEmpty = surahs.isEmpty && entities.isEmpty && collections.isEmpty;

  static SearchResults empty() => SearchResults(
        surahs: [],
        entities: [],
        collections: [],
      );
}

@riverpod
Future<SearchResults> searchQuery(SearchQueryRef ref, String query) async {
  final trimmed = query.trim();
  if (trimmed.isEmpty) return SearchResults.empty();

  final lower = trimmed.toLowerCase();
  final db = ref.watch(appDatabaseProvider);

  // 1. Surah search (static data, no DB)
  final surahs = allSurahsStaticData.where((s) {
    return s.transliteration.toLowerCase().contains(lower) ||
        s.englishMeaning.toLowerCase().contains(lower) ||
        s.arabicName.contains(trimmed) ||
        s.number.toString() == trimmed;
  }).map((s) => SearchResultSurah(s)).toList();

  // 2. Entity search (all types)
  final entityRows = await (db.select(db.entities)
        ..where((t) => t.name.like('%$lower%')))
      .get();
  final entities = entityRows.map((e) => SearchResultEntity(e)).toList();

  // 3. Collections search
  final collRows = await (db.select(db.collections)
        ..where((t) => t.name.like('%$lower%')))
      .get();
  final setRows = await (db.select(db.sets)
        ..where((t) => t.name.like('%$lower%') & t.isVisible.equals(true)))
      .get();

  final collections = [
    ...collRows.map((c) => SearchResultCollection(id: c.id, name: c.name, isSet: false)),
    ...setRows.map((s) => SearchResultCollection(id: s.id, name: s.name, isSet: true)),
  ];

  return SearchResults(surahs: surahs, entities: entities, collections: collections);
}
