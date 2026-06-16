// lib/features/home/home_notifier.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart';
import '../../core/local_db/app_database.dart';
import '../../core/local_db/database_provider.dart';
import 'surah_data.dart';

part 'home_notifier.g.dart';

/// State model for the user reading progress.
class UserProgressState {
  final int totalAyahsRead;
  final int streakDays;
  final int lastReadSurah;
  final int lastReadAyah;
  final int nextUnreadSurah;
  final int nextUnreadAyah;
  final String nextUnreadSnippet;

  UserProgressState({
    required this.totalAyahsRead,
    required this.streakDays,
    required this.lastReadSurah,
    required this.lastReadAyah,
    required this.nextUnreadSurah,
    required this.nextUnreadAyah,
    required this.nextUnreadSnippet,
  });
}

/// Model for the surah list rows with individual read progress.
class SurahListItem {
  final int number;
  final String transliteration;
  final String englishMeaning;
  final String arabicName;
  final int totalAyahs;
  final int ayahsRead;

  SurahListItem({
    required this.number,
    required this.transliteration,
    required this.englishMeaning,
    required this.arabicName,
    required this.totalAyahs,
    required this.ayahsRead,
  });
}

/// StreamProvider reactively watching user progress and read verses.
@riverpod
Stream<UserProgressState> userProgress(UserProgressRef ref) {
  final db = ref.watch(appDatabaseProvider);

  // Watch the user_progress table updates
  return db.select(db.userProgress).watchSingle().asyncMap((progress) async {
    final readVerses = await (db.select(db.verses)..where((t) => t.isRead.equals(true))).get();
    
    int lastReadSurah = 1;
    int lastReadAyah = 0;
    int nextUnreadSurah = 1;
    int nextUnreadAyah = 1;
    String nextUnreadSnippet = '';

    if (readVerses.isNotEmpty) {
      // Sort read verses to find the last read one
      final sorted = List<Verse>.from(readVerses)
        ..sort((a, b) {
          final cmp = a.surahNum.compareTo(b.surahNum);
          if (cmp != 0) return cmp;
          return a.ayahNum.compareTo(b.ayahNum);
        });

      final last = sorted.last;
      lastReadSurah = last.surahNum;
      lastReadAyah = last.ayahNum;

      // Determine next unread surah and ayah
      final currentSurahData = allSurahsStaticData.firstWhere(
        (s) => s.number == lastReadSurah,
        orElse: () => allSurahsStaticData[0],
      );

      if (lastReadAyah < currentSurahData.totalAyahs) {
        nextUnreadSurah = lastReadSurah;
        nextUnreadAyah = lastReadAyah + 1;
      } else if (lastReadSurah < 114) {
        nextUnreadSurah = lastReadSurah + 1;
        nextUnreadAyah = 1;
      } else {
        // Complete state fallback
        nextUnreadSurah = 114;
        nextUnreadAyah = currentSurahData.totalAyahs;
      }
    }

    // Fetch next unread snippet from the database if available
    final nextVerse = await (db.select(db.verses)
          ..where((t) => t.surahNum.equals(nextUnreadSurah) & t.ayahNum.equals(nextUnreadAyah)))
        .getSingleOrNull();

    if (nextVerse != null) {
      nextUnreadSnippet = nextVerse.textArabic;
    } else {
      // Seed fallback for preview in Continue Reading card if db is unseeded
      if (nextUnreadSurah == 1 && nextUnreadAyah == 1) {
        nextUnreadSnippet = 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ';
      } else if (nextUnreadSurah == 2 && nextUnreadAyah == 1) {
        nextUnreadSnippet = 'الم';
      } else {
        nextUnreadSnippet = 'ذَٰلِكَ ٱلْكِتَـٰبُ لَا رَيْبَ ۛ فِيهِ ۛ هُدًى لِّلْمُتَّقِينَ';
      }
    }

    return UserProgressState(
      totalAyahsRead: progress.totalVersesRead,
      streakDays: progress.streakDays,
      lastReadSurah: lastReadSurah,
      lastReadAyah: lastReadAyah,
      nextUnreadSurah: nextUnreadSurah,
      nextUnreadAyah: nextUnreadAyah,
      nextUnreadSnippet: nextUnreadSnippet,
    );
  });
}

/// StreamProvider exposing the list of all 114 surahs with read counts.
@riverpod
Stream<List<SurahListItem>> surahList(SurahListRef ref) {
  final db = ref.watch(appDatabaseProvider);

  // Re-trigger when user progress changes
  return db.select(db.userProgress).watchSingle().asyncMap((_) async {
    final readVerses = await (db.select(db.verses)..where((t) => t.isRead.equals(true))).get();

    final readCounts = <int, int>{};
    for (final v in readVerses) {
      readCounts[v.surahNum] = (readCounts[v.surahNum] ?? 0) + 1;
    }

    final list = <SurahListItem>[];
    for (final surah in allSurahsStaticData) {
      final read = readCounts[surah.number] ?? 0;
      list.add(
        SurahListItem(
          number: surah.number,
          transliteration: surah.transliteration,
          englishMeaning: surah.englishMeaning,
          arabicName: surah.arabicName,
          totalAyahs: surah.totalAyahs,
          ayahsRead: read,
        ),
      );
    }
    return list;
  });
}
