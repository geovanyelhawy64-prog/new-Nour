import '../database/app_database.dart';
import '../../core/services/database_service.dart';

class BookmarksRepository {
  final _store = DatabaseService.userData;

  Future<List<Bookmark>> getAll() {
    return _store.getAllBookmarks();
  }

  Future<void> add({
    required String contentType,
    required String contentId,
    required String displayTitle,
    String? note,
  }) async {
    await _store.addBookmark(
      contentType: contentType,
      contentId: contentId,
      displayTitle: displayTitle,
      note: note,
    );
  }

  Future<void> remove(int id) async {
    await _store.removeBookmark(id);
  }

  Future<bool> isBookmarked(
    String contentType,
    String contentId,
  ) {
    return _store.isBookmarked(contentType, contentId);
  }
}
