import '../database/app_database.dart';
import '../../core/services/database_service.dart';

class LiturgyRepository {
  final _db = DatabaseService.instance;

  Future<List<Liturgy>> getAllLiturgies() {
    return _db.liturgyDao.getAllLiturgies();
  }

  Future<List<LiturgySection>> getSections(String liturgyId) {
    return _db.liturgyDao.getSectionsForLiturgy(liturgyId);
  }

  Future<List<LiturgyPart>> getParts(String sectionId) {
    return _db.liturgyDao.getPartsForSection(sectionId);
  }
}
