import '../../core/services/database_service.dart';

class CrossReferenceRepository {
  final _db = DatabaseService.instance;

  Future<List<({int bookId, int chapter, int verse, String text, String bookName})>>
      getCrossReferences(int bookId, int chapter, int verse) async {
    return _db.crossReferenceDao.getCrossReferences(
      bookId,
      chapter,
      verse,
    );
  }

  Future<bool> hasCrossReferences(int bookId, int chapter, int verse) async {
    return _db.crossReferenceDao.hasCrossReferences(
      bookId,
      chapter,
      verse,
    );
  }
}
