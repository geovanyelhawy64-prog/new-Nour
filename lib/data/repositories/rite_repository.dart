import '../database/daos/rite_dao.dart';
import '../database/app_database.dart';
import '../models/rite.dart' as model;
import '../../core/services/database_service.dart';

class RiteRepository {
  final RiteDao _dao;
  RiteRepository([RiteDao? dao]) : _dao = dao ?? DatabaseService.instance.riteDao;

  Future<List<model.Rite>> getAllRites() async {
    final rows = await _dao.getAll();
    return rows.map(_toModel).toList();
  }

  Future<List<model.Rite>> getByCategory(String cat) async {
    final rows = await _dao.getByCategory(cat);
    return rows.map(_toModel).toList();
  }

  Future<model.Rite?> getById(int id) async {
    final row = await _dao.getById(id);
    return row != null ? _toModel(row) : null;
  }

  Future<List<model.RiteSection>> getSections(int riteId) async {
    final rows = await _dao.getSections(riteId);
    return rows.map((s) => model.RiteSection(
      id: s.id,
      riteId: s.riteId,
      titleAr: s.titleAr,
      textAr: s.textAr,
      copticText: s.copticText,
      copticArabicText: s.copticArabicText,
      rubric: s.rubric,
      response: s.response,
      sortOrder: s.sortOrder,
    )).toList();
  }

  Future<int> getCount() => _dao.getCount();
  Future<int> getSectionsCount() => _dao.getSectionsCount();
  Future<List<String>> getCategories() => _dao.getCategories();

  static model.Rite _toModel(Rite r) => model.Rite(
    id: r.id,
    nameAr: r.nameAr,
    nameEn: r.nameEn,
    nameCoptic: r.nameCoptic,
    category: model.RiteCategory.fromString(r.category),
    description: r.description,
    sortOrder: r.sortOrder,
    icon: r.icon,
  );
}
