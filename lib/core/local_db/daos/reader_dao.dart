// lib/core/local_db/daos/reader_dao.dart

import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/verses_table.dart';
import '../tables/bookmarks_table.dart';
import '../tables/user_progress_table.dart';

part 'reader_dao.g.dart';

@DriftAccessor(tables: [Verses, Bookmarks, UserProgress])
class ReaderDao extends DatabaseAccessor<AppDatabase> with _$ReaderDaoMixin {
  ReaderDao(AppDatabase db) : super(db);

  /// Get all verses for a given Surah ordered by Ayah number
  Future<List<Verse>> getVersesForSurah(int surahNum) {
    return (select(verses)
          ..where((t) => t.surahNum.equals(surahNum))
          ..orderBy([(t) => OrderingTerm(expression: t.ayahNum)]))
        .get();
  }

  /// Mark a verse as read quietly and increment progress counters
  Future<void> markVerseAsRead(int surahNum, int ayahNum) async {
    await transaction(() async {
      // 1. Mark verse as read
      await (update(verses)
            ..where((t) => t.surahNum.equals(surahNum) & t.ayahNum.equals(ayahNum)))
          .write(const VersesCompanion(isRead: Value(true)));

      // 2. Increment the total read count in the UserProgress singleton
      await customStatement(
        'UPDATE user_progress SET total_verses_read = total_verses_read + 1 WHERE id = 1;',
      );
    });
  }

  /// Bookmark a specific verse
  Future<void> addBookmark(int surahNum, int ayahNum) {
    return into(bookmarks).insert(
      BookmarksCompanion.insert(
        surahNum: surahNum,
        ayahNum: ayahNum,
        bookmarkedAt: DateTime.now().toIso8601String(),
      ),
    );
  }

  /// Remove a bookmark from a specific verse
  Future<void> removeBookmark(int surahNum, int ayahNum) {
    return (delete(bookmarks)
          ..where((t) => t.surahNum.equals(surahNum) & t.ayahNum.equals(ayahNum)))
        .go();
  }

  /// Check if a verse is bookmarked
  Future<bool> isBookmarked(int surahNum, int ayahNum) async {
    final query = select(bookmarks)
      ..where((t) => t.surahNum.equals(surahNum) & t.ayahNum.equals(ayahNum));
    final match = await query.getSingleOrNull();
    return match != null;
  }

  /// Stream list of bookmarked verses to update UI reactively
  Stream<List<Bookmark>> watchBookmarks() {
    return select(bookmarks).watch();
  }

  /// Retrieve the singleton user progress metrics
  Future<UserProgressData> getUserProgress() {
    return (select(userProgress)..where((t) => t.id.equals(1))).getSingle();
  }

  /// Update the daily reading streak and date indicators
  Future<void> updateUserStreak(int newStreak, String lastReadDate) {
    return (update(userProgress)..where((t) => t.id.equals(1))).write(
      UserProgressCompanion(
        streakDays: Value(newStreak),
        lastReadDate: Value(lastReadDate),
      ),
    );
  }
}
