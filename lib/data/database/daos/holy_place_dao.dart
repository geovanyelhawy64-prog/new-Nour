import 'package:drift/drift.dart';
import '../app_database.dart';
import '../required_database_value.dart';
import '../tables/holy_place_tables.dart';

part 'holy_place_dao.g.dart';

@DriftAccessor(tables: [HolyPlaces])
class HolyPlaceDao extends DatabaseAccessor<AppDatabase> with _$HolyPlaceDaoMixin {
  HolyPlaceDao(super.db);

  Future<List<HolyPlace>> getAll() =>
      (select(holyPlaces)..orderBy([(h) => OrderingTerm.asc(h.sortOrder)])).get();

  Future<List<HolyPlace>> getByType(String type) =>
      (select(holyPlaces)
            ..where((h) => h.type.equals(type))
            ..orderBy([(h) => OrderingTerm.asc(h.sortOrder)]))
          .get();

  Future<List<HolyPlace>> getByGovernorate(String governorate) =>
      (select(holyPlaces)
            ..where((h) => h.governorate.equals(governorate))
            ..orderBy([(h) => OrderingTerm.asc(h.sortOrder)]))
          .get();

  Future<List<HolyPlace>> search(String query) {
    final clean = '%$query%';
    return (select(holyPlaces)
          ..where((h) =>
              h.nameAr.like(clean) |
              h.governorate.like(clean) |
              h.history.like(clean) |
              h.patronSaint.like(clean))
          ..orderBy([(h) => OrderingTerm.asc(h.sortOrder)]))
        .get();
  }

  Future<HolyPlace?> getById(int id) =>
      (select(holyPlaces)..where((h) => h.id.equals(id))).getSingleOrNull();

  Future<List<String>> getGovernorates() =>
      (selectOnly(holyPlaces, distinct: true)
            ..addColumns([holyPlaces.governorate])
            ..orderBy([OrderingTerm.asc(holyPlaces.governorate)]))
          .map((row) => requireDatabaseValue(row.read(holyPlaces.governorate), 'holy_places.governorate'))
          .get();

  Future<int> getCount() {
    final countExp = holyPlaces.id.count();
    return (selectOnly(holyPlaces)..addColumns([countExp]))
        .map((row) => row.read(countExp) ?? 0)
        .getSingle();
  }
}
