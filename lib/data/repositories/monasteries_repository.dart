import '../../core/services/database_service.dart';
import '../database/app_database.dart';
import '../models/monastery.dart';

class MonasteriesRepository {
  final AppDatabase _db;

  MonasteriesRepository([AppDatabase? db]) : _db = db ?? DatabaseService.instance;

  /// جلب كافة الأديرة والمزارات من قاعدة البيانات
  Future<List<Monastery>> getAllSites() async {
    final rows = await _db.monasteriesDao.getAllSites();
    return rows.map(Monastery.fromDb).toList();
  }

  /// جلب الأديرة الرهبانية فقط
  Future<List<Monastery>> getMonasteries() async {
    final rows = await _db.monasteriesDao.getMonasteries();
    return rows.map(Monastery.fromDb).toList();
  }

  /// جلب الكنائس والمزارات الأثرية فقط
  Future<List<Monastery>> getChurches() async {
    final rows = await _db.monasteriesDao.getChurches();
    return rows.map(Monastery.fromDb).toList();
  }

  /// جلب دير أو مزار بواسطة المعرف الفريد
  Future<Monastery?> getSiteById(String id) async {
    final row = await _db.monasteriesDao.getSiteById(id);
    if (row == null) return null;
    return Monastery.fromDb(row);
  }

  /// بحث في الأديرة والكنائس
  Future<List<Monastery>> searchSites(String query) async {
    final rows = await _db.monasteriesDao.searchSites(query);
    return rows.map(Monastery.fromDb).toList();
  }
}
