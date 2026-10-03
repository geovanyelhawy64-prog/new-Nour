import '../database/app_database.dart';
import '../../core/services/database_service.dart';

class AgpeyaRepository {
  final _db = DatabaseService.instance;

  Future<List<AgpeyaHour>> getAllHours() {
    return _db.agpeyaDao.getAllHours();
  }

  Future<List<AgpeyaSection>> getHourSections(String hourId) {
    return _db.agpeyaDao.getSectionsForHour(hourId);
  }
}
