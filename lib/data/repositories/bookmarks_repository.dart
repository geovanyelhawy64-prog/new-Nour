import '../database/app_database.dart';
import '../../core/services/database_service.dart';

class BookmarksRepository {
  final AppDatabase _db;

  BookmarksRepository([AppDatabase? db]) : _db = db ?? DatabaseService.instance;

  Future<List<Bookmark>> getAll() {
    return _db.bookmarksDao.getAllBookmarks();
  }

  Future<void> add({
    required String contentType,
    required String contentId,
    required String displayTitle,
    String? note,
  }) {
    return _db.bookmarksDao.addBookmark(
      contentType: contentType,
      contentId: contentId,
      displayTitle: displayTitle,
      note: note,
    );
  }

  Future<void> remove(int id) {
    return _db.bookmarksDao.removeBookmark(id);
  }

  Future<bool> isBookmarked(
    String contentType,
    String contentId,
  ) {
    return _db.bookmarksDao.isBookmarked(contentType, contentId);
  }
}
