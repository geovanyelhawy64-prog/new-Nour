import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/bookmarks_tables.dart';

part 'bookmarks_dao.g.dart';

@DriftAccessor(tables: [Bookmarks])
class BookmarksDao extends DatabaseAccessor<AppDatabase> with _$BookmarksDaoMixin {
  BookmarksDao(super.db);

  /// جلب كل المحفوظات مرتبة من الأحدث إلى الأقدم
  Future<List<Bookmark>> getAllBookmarks() {
    return (select(bookmarks)..orderBy([(b) => OrderingTerm.desc(b.createdAt)])).get();
  }

  /// جلب المحفوظات حسب نوع المحتوى
  Future<List<Bookmark>> getBookmarksByType(String contentType) {
    return (select(bookmarks)
          ..where((b) => b.contentType.equals(contentType))
          ..orderBy([(b) => OrderingTerm.desc(b.createdAt)]))
        .get();
  }

  /// إضافة عنصر للمفضلة
  Future<int> addBookmark({
    required String contentType,
    required String contentId,
    required String displayTitle,
    String? note,
  }) {
    return into(bookmarks).insert(BookmarksCompanion.insert(
      contentType: contentType,
      contentId: contentId,
      displayTitle: displayTitle,
      note: Value(note),
    ));
  }

  /// حذف عنصر من المفضلة
  Future<int> removeBookmark(int id) {
    return (delete(bookmarks)..where((b) => b.id.equals(id))).go();
  }

  /// هل العنصر محفوظ في المفضلة
  Future<bool> isBookmarked(String contentType, String contentId) async {
    final record = await (select(bookmarks)
          ..where((b) =>
              b.contentType.equals(contentType) & b.contentId.equals(contentId)))
        .getSingleOrNull();
    return record != null;
  }
}
