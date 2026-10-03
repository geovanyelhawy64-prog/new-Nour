import 'package:drift/drift.dart';
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

  /// بحث في الآيات عبر فهرس FTS5 المبني بنفس دالة التطبيع.
  ///
  /// الرجوع إلى LIKE مخصص فقط لقواعد الاختبار أو ترقية قديمة لا تحتوي
  /// على الفهرس؛ قاعدة الإصدار تتحقق من FTS5 قبل تثبيتها.
  Future<List<BibleVerse>> searchVerses(
    String query, {
    int? bookId,
    int limit = 50,
  }) async {
    final normalized = SearchNormalizer.normalize(query);
    final matchQuery = SearchNormalizer.toFts5Query(query);
    if (matchQuery.isEmpty) return [];

    final hasFts = await customSelect(
      "SELECT 1 FROM sqlite_master "
      "WHERE type = 'table' AND name = 'bible_verses_fts' LIMIT 1",
    ).getSingleOrNull();
    if (hasFts == null) {
      var fallback = select(bibleVerses)
        ..where(
          (verse) =>
              verse.content.contains(normalized) |
              verse.content.contains(query),
        )
        ..limit(limit);
      if (bookId != null) {
        fallback = fallback
          ..where((verse) => verse.bookId.equals(bookId));
      }
      return fallback.get();
    }

    final filter = bookId == null ? '' : 'AND v.book_id = ?';
    final variables = <Variable>[
      Variable<String>(matchQuery),
      if (bookId != null) Variable<int>(bookId),
      Variable<int>(limit),
    ];
    final rows = await customSelect(
      '''
      SELECT v.*
      FROM bible_verses_fts
      JOIN bible_verses v ON v.id = bible_verses_fts.verse_id
      WHERE bible_verses_fts MATCH ?
      $filter
      ORDER BY bm25(bible_verses_fts), v.id
      LIMIT ?
      ''',
      variables: variables,
      readsFrom: {bibleVerses},
    ).get();
    return rows.map((row) => bibleVerses.map(row.data)).toList();
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
    } catch (_) {
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
