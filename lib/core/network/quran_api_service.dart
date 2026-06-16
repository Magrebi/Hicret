// lib/core/network/quran_api_service.dart

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

  /// Fetch the Arabic text in calligraphic/uthmanic format for a specific Ayah.
  ///
  /// Calls the Quran.com API endpoint: `/quran/verses/uthmani`
  ///
  /// [surahNum] The 1-indexed number of the Surah (1 to 114)
  /// [ayahNum] The 1-indexed number of the Ayah in the Surah
  /// Returns the raw Arabic Unicode text string.
  Future<String> fetchVerseArabic(int surahNum, int ayahNum) async {
    // TODO: Implement actual HTTP call with cache check
    return '';
  }

  /// Fetch translation text for a specific Ayah from a preferred source translator.
  ///
  /// Calls the Quran.com API endpoint: `/quran/translations/{translationId}`
  ///
  /// [surahNum] The 1-indexed number of the Surah (1 to 114)
  /// [ayahNum] The 1-indexed number of the Ayah in the Surah
  /// [translationId] The translation key ID (e.g. 131 for Sahih International)
  /// Returns the translated text string.
  Future<String> fetchVerseTranslation(int surahNum, int ayahNum, int translationId) async {
    // TODO: Implement actual HTTP call with cache check
    return '';
  }

  /// Fetch Surah metadata such as name, revelation place, and total Ayah count.
  ///
  /// Calls the Quran.com API endpoint: `/chapters/{chapterId}`
  ///
  /// [surahNum] The chapter index (1 to 114)
  /// Returns chapter details in a map wrapper.
  Future<Map<String, dynamic>> fetchSurahMetadata(int surahNum) async {
    // TODO: Implement API call
    return <String, dynamic>{};
  }

  /// Prefetch all verses and translations for a whole Surah to save offline.
  ///
  /// [surahNum] The chapter index (1 to 114)
  Future<void> prefetchAndCacheSurah(int surahNum) async {
    // TODO: Iterate verses, fetch and cache locally in Drift DB
  }
}
