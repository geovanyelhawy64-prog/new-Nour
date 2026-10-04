import '../../core/services/database_service.dart';
import '../database/bookmark_model.dart';

class BookmarksRepository {
  Future<List<Bookmark>> getAll() {
    return DatabaseService.userStore.getAllBookmarks();
  }

  Future<void> add({
    required String contentType,
    required String contentId,
    required String displayTitle,
    String? note,
  }) {
    return DatabaseService.userStore.addBookmark(
      contentType: contentType,
      contentId: contentId,
      displayTitle: displayTitle,
      note: note,
    );
  }

  Future<void> remove(int id) {
    return DatabaseService.userStore.removeBookmark(id);
  }

  Future<bool> isBookmarked(
    String contentType,
    String contentId,
  ) {
    return DatabaseService.userStore.isBookmarked(contentType, contentId);
  }
}
