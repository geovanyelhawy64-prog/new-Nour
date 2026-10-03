import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/commentary_tables.dart';

part 'commentary_dao.g.dart';

@DriftAccessor(tables: [BibleCommentaries])
class CommentaryDao extends DatabaseAccessor<AppDatabase>
    with _$CommentaryDaoMixin {
  CommentaryDao(super.db);

  Future<List<BibleCommentary>> getChapterCommentary(
    int bookId,
    int chapter,
  ) {
    return (select(bibleCommentaries)
          ..where((c) =>
              c.bookId.equals(bookId) &
              c.chapter.equals(chapter) &
              c.verseStart.isNull())
          ..orderBy([(c) => OrderingTerm.asc(c.id)]))
        .get();
  }

  Future<List<BibleCommentary>> getVerseCommentary(
    int bookId,
    int chapter,
    int verse,
  ) {
    return (select(bibleCommentaries)
          ..where((c) =>
              c.bookId.equals(bookId) &
              c.chapter.equals(chapter) &
              c.verseStart.isNotNull() &
              c.verseStart.isSmallerOrEqualValue(verse) &
              c.verseEnd.isBiggerOrEqualValue(verse))
          ..orderBy([(c) => OrderingTerm.asc(c.verseStart)]))
        .get();
  }

  Future<List<BibleCommentary>> getCommentaryByBook(int bookId) {
    return (select(bibleCommentaries)
          ..where((c) => c.bookId.equals(bookId))
          ..orderBy([
            (c) => OrderingTerm.asc(c.chapter),
            (c) => OrderingTerm.asc(c.verseStart),
          ]))
        .get();
  }

  Future<int> getCommentaryCount() {
    final countExp = bibleCommentaries.id.count();
    return (selectOnly(bibleCommentaries)..addColumns([countExp]))
        .map((row) => row.read(countExp) ?? 0)
        .getSingle();
  }

  Future<int> insertCommentary(BibleCommentariesCompanion commentary) {
    return into(bibleCommentaries).insert(commentary);
  }

  Future<int> insertAll(List<BibleCommentariesCompanion> commentaries) {
    return batch((batch) {
      batch.insertAll(bibleCommentaries, commentaries);
    }).then((_) => commentaries.length);
  }
}
