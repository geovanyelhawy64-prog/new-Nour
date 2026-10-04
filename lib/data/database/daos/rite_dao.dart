import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/rite_tables.dart';

part 'rite_dao.g.dart';

@DriftAccessor(tables: [Rites, RiteSections])
class RiteDao extends DatabaseAccessor<AppDatabase> with _$RiteDaoMixin {
  RiteDao(super.db);

  Future<List<Rite>> getAll() =>
      (select(rites)..orderBy([(r) => OrderingTerm.asc(r.sortOrder)])).get();

  Future<List<Rite>> getByCategory(String category) =>
      (select(rites)
            ..where((r) => r.category.equals(category))
            ..orderBy([(r) => OrderingTerm.asc(r.sortOrder)]))
          .get();

  Future<Rite?> getById(int id) =>
      (select(rites)..where((r) => r.id.equals(id))).getSingleOrNull();

  Future<List<RiteSection>> getSections(int riteId) =>
      (select(riteSections)
            ..where((s) => s.riteId.equals(riteId))
            ..orderBy([(s) => OrderingTerm.asc(s.sortOrder)]))
          .get();

  Future<int> getCount() {
    final countExp = rites.id.count();
    return (selectOnly(rites)..addColumns([countExp]))
        .map((row) => row.read(countExp) ?? 0)
        .getSingle();
  }

  Future<int> getSectionsCount() {
    final countExp = riteSections.id.count();
    return (selectOnly(riteSections)..addColumns([countExp]))
        .map((row) => row.read(countExp) ?? 0)
        .getSingle();
  }

  Future<List<String>> getCategories() =>
      (selectOnly(rites, distinct: true)
            ..addColumns([rites.category])
            ..orderBy([OrderingTerm.asc(rites.sortOrder)]))
          .map((row) => row.read(rites.category)!)
          .get();
}
