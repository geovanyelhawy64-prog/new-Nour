import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/psali_tables.dart';

part 'psali_dao.g.dart';

@DriftAccessor(tables: [Psalis, PsaliSections])
class PsaliDao extends DatabaseAccessor<AppDatabase>
    with _$PsaliDaoMixin {
  PsaliDao(super.db);

  // كل التسابيح حسب النوع
  Future<List<Psali>> getByType(String type) {
    return (select(psalis)
          ..where((p) => p.type.equals(type))
          ..orderBy([(p) => OrderingTerm.asc(p.order)]))
        .get();
  }

  // تئوطوكيات اليوم (حسب يوم الأسبوع)
  Future<List<Psali>> getTheotokiaByDay(String dayOfWeek) {
    return (select(psalis)
          ..where((p) =>
              p.type.equals('theotokia') &
              p.dayOfWeek.equals(dayOfWeek))
          ..orderBy([(p) => OrderingTerm.asc(p.order)]))
        .get();
  }

  // هوسات
  Future<List<Psali>> getHos() {
    return (select(psalis)
          ..where((p) => p.type.equals('hos'))
          ..orderBy([(p) => OrderingTerm.asc(p.order)]))
        .get();
  }

  // مديحات كيهك
  Future<List<Psali>> getKiahkiMadihat() {
    return (select(psalis)
          ..where((p) =>
              p.type.equals('madih') &
              p.season.equals('kiahki'))
          ..orderBy([(p) => OrderingTerm.asc(p.order)]))
        .get();
  }

  // إبصلمودية (مزامير قبطية)
  Future<List<Psali>> getPsalmody() {
    return (select(psalis)
          ..where((p) => p.type.equals('psali'))
          ..orderBy([(p) => OrderingTerm.asc(p.order)]))
        .get();
  }

  // كل التسابيح
  Future<List<Psali>> getAll() {
    return (select(psalis)
          ..orderBy([
            (p) => OrderingTerm.asc(p.type),
            (p) => OrderingTerm.asc(p.order),
          ]))
        .get();
  }

  // أقسام التسبيحة
  Future<List<PsaliSection>> getSections(String psaliId) {
    return (select(psaliSections)
          ..where((s) => s.psaliId.equals(psaliId))
          ..orderBy([(s) => OrderingTerm.asc(s.sectionOrder)]))
        .get();
  }

  // إحصاء
  Future<int> getCount() {
    final countExp = psalis.id.count();
    return (selectOnly(psalis)..addColumns([countExp]))
        .map((row) => row.read(countExp) ?? 0)
        .getSingle();
  }

  Future<int> getSectionsCount(String psaliId) {
    return (select(psaliSections)
          ..where((s) => s.psaliId.equals(psaliId)))
        .get()
        .then((list) => list.length);
  }
}
