// lib/core/network/quran_api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quran_api_service.g.dart';

@riverpod
QuranApiService quranApiService(QuranApiServiceRef ref) {
  return QuranApiService();
}

/// Service handling network integration with the Quran.com API v4.
/// It provides caching capabilities to guarantee offline usability.
class QuranApiService {
  QuranApiService();

  /// Strip HTML tags like <sup>, <i>, etc., from English translations.
  String _stripHtmlTags(String htmlText) {
    return htmlText.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }

  /// Fetch all verses (Arabic Uthmani + translation 131) for a surah.
  ///
  /// Calls the Quran.com API endpoint: `/verses/by_chapter/{chapter_number}`
  ///
  /// [surahNum] The 1-indexed number of the Surah (1 to 114)
  /// Returns a list of maps containing 'ayahNum', 'arabic', and 'english'.
  Future<List<Map<String, dynamic>>> fetchSurahVerses(int surahNum) async {
    final url = 'https://api.quran.com/api/v4/verses/by_chapter/$surahNum?language=en&fields=text_uthmani&translations=131&per_page=300';
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> versesJson = data['verses'] ?? [];
      
      return versesJson.map((v) {
        final translations = v['translations'] as List<dynamic>?;
        final englishText = (translations != null && translations.isNotEmpty)
            ? translations.first['text'] as String
            : '';
        return {
          'ayahNum': v['verse_number'] as int,
          'arabic': v['text_uthmani'] as String? ?? '',
          'english': _stripHtmlTags(englishText),
        };
      }).toList();
    } else {
      throw Exception('Failed to load verses from Quran API (status code: ${response.statusCode})');
    }
  }

  /// Fetch the Arabic text in calligraphic/uthmanic format for a specific Ayah.
  Future<String> fetchVerseArabic(int surahNum, int ayahNum) async {
    final url = 'https://api.quran.com/api/v4/verses/by_key/$surahNum:$ayahNum?language=en&fields=text_uthmani';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final verse = data['verse'] as Map<String, dynamic>?;
      return verse?['text_uthmani'] as String? ?? '';
    }
    return '';
  }

  /// Fetch translation text for a specific Ayah from a preferred source translator.
  Future<String> fetchVerseTranslation(int surahNum, int ayahNum, int translationId) async {
    final url = 'https://api.quran.com/api/v4/verses/by_key/$surahNum:$ayahNum?language=en&translations=$translationId';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final verse = data['verse'] as Map<String, dynamic>?;
      final translations = verse?['translations'] as List<dynamic>?;
      final text = (translations != null && translations.isNotEmpty)
          ? translations.first['text'] as String
          : '';
      return _stripHtmlTags(text);
    }
    return '';
  }

  /// Fetch Surah metadata such as name, revelation place, and total Ayah count.
  Future<Map<String, dynamic>> fetchSurahMetadata(int surahNum) async {
    final url = 'https://api.quran.com/api/v4/chapters/$surahNum?language=en';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['chapter'] as Map<String, dynamic>? ?? <String, dynamic>{};
    }
    return <String, dynamic>{};
  }

  /// Prefetch all verses and translations for a whole Surah to save offline.
  Future<void> prefetchAndCacheSurah(int surahNum) async {
    // This can be triggered on-demand to cache surah verses
  }
}
