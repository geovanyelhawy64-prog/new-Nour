import '../database/app_database.dart';
import '../../core/services/database_service.dart';

class CrossReferenceRepository {
  final AppDatabase _db;

  CrossReferenceRepository([AppDatabase? db]) : _db = db ?? DatabaseService.instance;

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
