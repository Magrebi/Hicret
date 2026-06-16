// lib/core/repositories/quran_repository.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../local_db/app_database.dart';
import '../local_db/database_provider.dart';

part 'quran_repository.g.dart';

abstract class QuranRepository {
  Future<List<Verse>> getVersesForSurah(int surahNum);
  Future<void> markVerseAsRead(int surahNum, int ayahNum);
  Future<void> addBookmark(int surahNum, int ayahNum);
  Future<void> removeBookmark(int surahNum, int ayahNum);
  Future<bool> isBookmarked(int surahNum, int ayahNum);
  Stream<List<Bookmark>> watchBookmarks();
}

class QuranRepositoryImpl implements QuranRepository {
  final AppDatabase _db;

  QuranRepositoryImpl(this._db);

  @override
  Future<List<Verse>> getVersesForSurah(int surahNum) {
    return _db.readerDao.getVersesForSurah(surahNum);
  }

  @override
  Future<void> markVerseAsRead(int surahNum, int ayahNum) {
    return _db.readerDao.markVerseAsRead(surahNum, ayahNum);
  }

  @override
  Future<void> addBookmark(int surahNum, int ayahNum) {
    return _db.readerDao.addBookmark(surahNum, ayahNum);
  }

  @override
  Future<void> removeBookmark(int surahNum, int ayahNum) {
    return _db.readerDao.removeBookmark(surahNum, ayahNum);
  }

  @override
  Future<bool> isBookmarked(int surahNum, int ayahNum) {
    return _db.readerDao.isBookmarked(surahNum, ayahNum);
  }

  @override
  Stream<List<Bookmark>> watchBookmarks() {
    return _db.readerDao.watchBookmarks();
  }
}

@riverpod
QuranRepository quranRepository(QuranRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return QuranRepositoryImpl(db);
}
