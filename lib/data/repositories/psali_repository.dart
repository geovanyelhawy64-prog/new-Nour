import '../database/app_database.dart';
import '../models/psali.dart' as model;
import '../../core/services/database_service.dart';

class PsaliRepository {
  final AppDatabase _db;

  PsaliRepository([AppDatabase? db]) : _db = db ?? DatabaseService.instance;

  Future<List<model.Psali>> getHos() async {
    final rows = await _db.psaliDao.getHos();
    return rows.map(_mapPsali).toList();
  }

  Future<List<model.Psali>> getTheotokiaByDay(String dayOfWeek) async {
    final rows = await _db.psaliDao.getTheotokiaByDay(dayOfWeek);
    return rows.map(_mapPsali).toList();
  }

  Future<List<model.Psali>> getKiahkiMadihat() async {
    final rows = await _db.psaliDao.getKiahkiMadihat();
    return rows.map(_mapPsali).toList();
  }

  Future<List<model.Psali>> getPsalmody() async {
    final rows = await _db.psaliDao.getPsalmody();
    return rows.map(_mapPsali).toList();
  }

  Future<List<model.Psali>> getByType(String type) async {
    final rows = await _db.psaliDao.getByType(type);
    return rows.map(_mapPsali).toList();
  }

  Future<List<model.Psali>> getAll() async {
    final rows = await _db.psaliDao.getAll();
    return rows.map(_mapPsali).toList();
  }

  Future<List<model.PsaliSection>> getSections(String psaliId) async {
    final rows = await _db.psaliDao.getSections(psaliId);
    return rows.map((r) => model.PsaliSection(
          id: r.id,
          psaliId: r.psaliId,
          sectionOrder: r.sectionOrder,
          textCoptic: r.textCoptic,
          textPhonetic: r.textPhonetic,
          textArabic: r.textArabic,
          rubric: r.rubric,
          response: r.response,
        )).toList();
  }

  Future<int> getCount() => _db.psaliDao.getCount();

  model.Psali _mapPsali(Psali row) {
    return model.Psali(
      id: row.id,
      psaliId: row.psaliId,
      type: model.PsaliType.values.firstWhere(
        (t) => t.name == row.type,
        orElse: () => model.PsaliType.psali,
      ),
      nameAr: row.nameAr,
      nameCoptic: row.nameCoptic,
      namePhonetic: row.namePhonetic,
      occasion: row.occasion,
      dayOfWeek: row.dayOfWeek,
      season: row.season,
      order: row.order,
    );
  }
}
