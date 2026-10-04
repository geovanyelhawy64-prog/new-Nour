import '../database/app_database.dart';
import '../models/bible_commentary.dart' as model;
import '../../core/services/database_service.dart';

class CommentaryRepository {
  final AppDatabase _db;

  CommentaryRepository([AppDatabase? db]) : _db = db ?? DatabaseService.instance;

  Future<List<model.BibleCommentary>> getChapterCommentary(
    int bookId,
    int chapter,
  ) async {
    final rows = await _db.commentaryDao.getChapterCommentary(
      bookId,
      chapter,
    );
    return rows.map(_mapToModel).toList();
  }

  Future<List<model.BibleCommentary>> getVerseCommentary(
    int bookId,
    int chapter,
    int verse,
  ) async {
    final rows = await _db.commentaryDao.getVerseCommentary(
      bookId,
      chapter,
      verse,
    );
    return rows.map(_mapToModel).toList();
  }

  Future<bool> hasCommentary(int bookId, int chapter) async {
    final rows = await _db.commentaryDao.getChapterCommentary(
      bookId,
      chapter,
    );
    return rows.isNotEmpty;
  }

  model.BibleCommentary _mapToModel(BibleCommentary row) {
    return model.BibleCommentary(
      id: row.id,
      bookId: row.bookId,
      chapter: row.chapter,
      verseStart: row.verseStart,
      verseEnd: row.verseEnd,
      source: row.source,
      author: row.author,
      text: row.text,
      summary: row.summary,
    );
  }
}
