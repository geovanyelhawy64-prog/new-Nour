import '../database/app_database.dart';
import '../../core/services/database_service.dart';

class AgpeyaRepository {
  final AppDatabase _db;

  AgpeyaRepository([AppDatabase? db]) : _db = db ?? DatabaseService.instance;

  Future<List<AgpeyaHour>> getAllHours() {
    return _db.agpeyaDao.getAllHours();
  }

  Future<List<AgpeyaSection>> getHourSections(String hourId) {
    return _db.agpeyaDao.getSectionsForHour(hourId);
  }
}
