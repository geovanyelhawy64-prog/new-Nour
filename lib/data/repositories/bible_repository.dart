import '../database/app_database.dart';
import '../../core/services/database_service.dart';

class BibleRepository {
  final AppDatabase _db;

  BibleRepository([AppDatabase? db]) : _db = db ?? DatabaseService.instance;

  Future<List<BibleBook>> getBooksByTestament(String testament) {
    return _db.bibleDao.getBooksByTestament(testament);
  }

  Future<List<BibleVerse>> getChapterVerses(int bookId, int chapter) {
    return _db.bibleDao.getChapterVerses(bookId, chapter);
  }

  Future<BibleBook> getBook(int bookId) {
    return _db.bibleDao.getBook(bookId);
  }

  Future<List<BibleVerse>> search(String query, {int? bookId}) {
    return _db.bibleDao.searchVerses(query, bookId: bookId);
  }

  Future<Map<int, String>> getChapterHighlights(int bookId, int chapter) {
    return DatabaseService.userStore.getChapterHighlights(bookId, chapter);
  }

  Future<void> setVerseHighlight(int bookId, int chapter, int verseNumber, String color) {
    return DatabaseService.userStore.setVerseHighlight(bookId, chapter, verseNumber, color);
  }

  Future<void> removeVerseHighlight(int bookId, int chapter, int verseNumber) {
    return DatabaseService.userStore.removeVerseHighlight(bookId, chapter, verseNumber);
  }
}
