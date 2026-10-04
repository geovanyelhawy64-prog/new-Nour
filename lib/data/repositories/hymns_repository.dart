import '../database/app_database.dart';
import '../../core/services/database_service.dart';

class HymnsRepository {
  final AppDatabase _db;

  HymnsRepository([AppDatabase? db]) : _db = db ?? DatabaseService.instance;

  Future<List<HymnBook>> getAllBooks() {
    return _db.hymnsDao.getAllBooks();
  }

  Future<List<Hymn>> getHymnsByBook(String bookId) {
    return _db.hymnsDao.getHymnsForBook(bookId);
  }

  Future<List<Hymn>> getHymnsByCategory(String catId) {
    return _db.hymnsDao.getHymnsForCategory(catId);
  }

  Future<List<Hymn>> getHymnsByIds(List<String> ids) {
    return _db.hymnsDao.getHymnsByIds(ids);
  }

  Future<Hymn> getHymn(String hymnId) {
    return _db.hymnsDao.getHymn(hymnId);
  }

  Future<List<HymnSegment>> getHymnSegments(String hymnId) {
    return _db.hymnsDao.getSegmentsForHymn(hymnId);
  }
}
