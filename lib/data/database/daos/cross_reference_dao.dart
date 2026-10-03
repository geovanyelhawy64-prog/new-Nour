import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/cross_reference_tables.dart';
import '../tables/bible_tables.dart';

part 'cross_reference_dao.g.dart';

@DriftAccessor(tables: [BibleCrossReferences, BibleVerses, BibleBooks])
class CrossReferenceDao extends DatabaseAccessor<AppDatabase>
    with _$CrossReferenceDaoMixin {
  CrossReferenceDao(super.db);

  Future<List<({int bookId, int chapter, int verse, String text, String bookName})>>
      getCrossReferences(int bookId, int chapter, int verse) async {
    final query = select(bibleCrossReferences).join([
      innerJoin(
        bibleVerses,
        bibleVerses.bookId.equalsExp(bibleCrossReferences.targetBookId) &
            bibleVerses.chapter.equalsExp(bibleCrossReferences.targetChapter) &
            bibleVerses.verseNumber.equalsExp(bibleCrossReferences.targetVerse),
      ),
      innerJoin(
        bibleBooks,
        bibleBooks.id.equalsExp(bibleCrossReferences.targetBookId),
      ),
    ])
      ..where(
        bibleCrossReferences.sourceBookId.equals(bookId) &
            bibleCrossReferences.sourceChapter.equals(chapter) &
            bibleCrossReferences.sourceVerse.equals(verse),
      )
      ..limit(10);

    final rows = await query.get();
    return rows.map((row) {
      final verseObj = row.readTable(bibleVerses);
      final book = row.readTable(bibleBooks);
      return (
        bookId: verseObj.bookId,
        chapter: verseObj.chapter,
        verse: verseObj.verseNumber,
        text: verseObj.text,
        bookName: book.nameAr,
      );
    }).toList();
  }

  Future<bool> hasCrossReferences(int bookId, int chapter, int verse) async {
    final count = await (select(bibleCrossReferences)
          ..where((r) =>
              r.sourceBookId.equals(bookId) &
              r.sourceChapter.equals(chapter) &
              r.sourceVerse.equals(verse)))
        .get();
    return count.isNotEmpty;
  }
}
