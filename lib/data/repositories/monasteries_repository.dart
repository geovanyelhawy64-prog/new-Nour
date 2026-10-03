import '../../core/services/database_service.dart';
import '../models/monastery.dart';

class MonasteriesRepository {
  const MonasteriesRepository();

  /// جلب كافة الأديرة والمزارات من قاعدة البيانات
  Future<List<Monastery>> getAllSites() async {
    final rows = await DatabaseService.instance.monasteriesDao.getAllSites();
    return rows.map(Monastery.fromDb).toList();
  }

  /// جلب الأديرة الرهبانية فقط
  Future<List<Monastery>> getMonasteries() async {
    final rows = await DatabaseService.instance.monasteriesDao.getMonasteries();
    return rows.map(Monastery.fromDb).toList();
  }

  /// جلب الكنائس والمزارات الأثرية فقط
  Future<List<Monastery>> getChurches() async {
    final rows = await DatabaseService.instance.monasteriesDao.getChurches();
    return rows.map(Monastery.fromDb).toList();
  }

  /// جلب دير أو مزار بواسطة المعرف الفريد
  Future<Monastery?> getSiteById(String id) async {
    final row = await DatabaseService.instance.monasteriesDao.getSiteById(id);
    if (row == null) return null;
    return Monastery.fromDb(row);
  }

  /// بحث في الأديرة والكنائس
  Future<List<Monastery>> searchSites(String query) async {
    final rows = await DatabaseService.instance.monasteriesDao.searchSites(query);
    return rows.map(Monastery.fromDb).toList();
  }
}
