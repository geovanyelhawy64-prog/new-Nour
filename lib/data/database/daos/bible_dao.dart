import 'package:drift/drift.dart';
import '../../../core/services/logger_service.dart';
import '../../../core/utils/search_normalizer.dart';
import '../app_database.dart';
import '../tables/bible_tables.dart';

part 'bible_dao.g.dart';

@DriftAccessor(tables: [BibleBooks, BibleVerses])
class BibleDao extends DatabaseAccessor<AppDatabase> with _$BibleDaoMixin {
  BibleDao(super.db);

  /// جلب كل الأسفار حسب العهد
  Future<List<BibleBook>> getBooksByTestament(String testament) {
    return (select(bibleBooks)
          ..where((b) => b.testament.equals(testament))
          ..orderBy([(b) => OrderingTerm.asc(b.bookOrder)]))
        .get();
  }

  /// جلب كل أسفار الكتاب المقدس
  Future<List<BibleBook>> getAllBooks() {
    return (select(bibleBooks)..orderBy([(b) => OrderingTerm.asc(b.bookOrder)])).get();
  }

  /// جلب سفر بالمعرف
  Future<BibleBook> getBook(int bookId) {
    return (select(bibleBooks)..where((b) => b.id.equals(bookId))).getSingle();
  }

  /// جلب آيات إصحاح كامل
  Future<List<BibleVerse>> getChapterVerses(int bookId, int chapter) {
    return (select(bibleVerses)
          ..where((v) => v.bookId.equals(bookId) & v.chapter.equals(chapter))
          ..orderBy([(v) => OrderingTerm.asc(v.verseNumber)]))
        .get();
  }

  /// جلب آية معينة
  Future<BibleVerse> getVerse(int bookId, int chapter, int verseNumber) {
    return (select(bibleVerses)
          ..where((v) =>
              v.bookId.equals(bookId) &
              v.chapter.equals(chapter) &
              v.verseNumber.equals(verseNumber)))
        .getSingle();
  }

  /// عدد الإصحاحات في سفر
  Future<int> getChapterCount(int bookId) async {
    final book = await getBook(bookId);
    return book.chapterCount;
  }

  /// بحث في آيات الكتاب المقدس مع تطبيع الحركات والهمزات
  Future<List<BibleVerse>> searchVerses(
    String query, {
    int? bookId,
    int limit = 50,
  }) {
    final normalized = SearchNormalizer.normalize(query);
    var q = select(bibleVerses)
      ..where((v) => v.content.contains(normalized) | v.content.contains(query))
      ..limit(limit);

    if (bookId != null) {
      q = q..where((v) => v.bookId.equals(bookId));
    }

    return q.get();
  }

  /// جلب تظليلات آيات الإصحاح
  Future<Map<int, String>> getChapterHighlights(int bookId, int chapter) async {
    try {
      final rows = await customSelect(
        'SELECT verse_number, color FROM verse_highlights WHERE book_id = ? AND chapter = ?',
        variables: [Variable<int>(bookId), Variable<int>(chapter)],
      ).get();
      return {
        for (final r in rows) r.read<int>('verse_number'): r.read<String>('color'),
      };
    } catch (e) {
      LoggerService.error('getChapterHighlights failed', 'BIBLE_DAO', e);
      return {};
    }
  }

  /// حفظ أو تحديث تظليل آية
  Future<void> setVerseHighlight(int bookId, int chapter, int verseNumber, String color) async {
    final id = '$bookId:$chapter:$verseNumber';
    final now = DateTime.now().toIso8601String();
    await customStatement(
      '''
      INSERT INTO verse_highlights (id, book_id, chapter, verse_number, color, created_at)
      VALUES (?, ?, ?, ?, ?, ?)
      ON CONFLICT(id) DO UPDATE SET color = excluded.color
      ''',
      [id, bookId, chapter, verseNumber, color, now],
    );
  }

  /// حذف تظليل آية
  Future<void> removeVerseHighlight(int bookId, int chapter, int verseNumber) async {
    final id = '$bookId:$chapter:$verseNumber';
    await customStatement(
      'DELETE FROM verse_highlights WHERE id = ?',
      [id],
    );
  }
}
