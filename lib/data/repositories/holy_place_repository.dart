import '../database/daos/holy_place_dao.dart';
import '../database/app_database.dart';
import '../models/holy_place.dart' as model;

class HolyPlaceRepository {
  final HolyPlaceDao _dao;
  HolyPlaceRepository(this._dao);

  Future<List<model.HolyPlace>> getAll() async {
    final rows = await _dao.getAll();
    return rows.map(_toModel).toList();
  }

  Future<List<model.HolyPlace>> getByType(String type) async {
    final rows = await _dao.getByType(type);
    return rows.map(_toModel).toList();
  }

  Future<List<model.HolyPlace>> getByGovernorate(String gov) async {
    final rows = await _dao.getByGovernorate(gov);
    return rows.map(_toModel).toList();
  }

  Future<List<model.HolyPlace>> search(String query) async {
    final rows = await _dao.search(query);
    return rows.map(_toModel).toList();
  }

  Future<model.HolyPlace?> getById(int id) async {
    final row = await _dao.getById(id);
    return row != null ? _toModel(row) : null;
  }

  Future<List<String>> getGovernorates() => _dao.getGovernorates();
  Future<int> getCount() => _dao.getCount();

  static model.HolyPlace _toModel(HolyPlace h) => model.HolyPlace(
    id: h.id,
    nameAr: h.nameAr,
    nameCoptic: h.nameCoptic,
    type: model.HolyPlaceType.fromString(h.type),
    governorate: h.governorate,
    locationDescription: h.locationDescription,
    latitude: h.latitude,
    longitude: h.longitude,
    century: h.century,
    patronSaint: h.patronSaint,
    history: h.history,
    feastDay: h.feastDay,
    visitingRules: h.visitingRules,
    sortOrder: h.sortOrder,
  );
}
