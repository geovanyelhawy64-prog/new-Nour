import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/agpeya_tables.dart';

part 'agpeya_dao.g.dart';

@DriftAccessor(tables: [AgpeyaHours, AgpeyaSections])
class AgpeyaDao extends DatabaseAccessor<AppDatabase> with _$AgpeyaDaoMixin {
  AgpeyaDao(super.db);

  /// جلب كل الساعات مرتبة
  Future<List<AgpeyaHour>> getAllHours() {
    return (select(agpeyaHours)..orderBy([(h) => OrderingTerm.asc(h.hourOrder)])).get();
  }

  /// جلب ساعة معينة بالمعرف
  Future<AgpeyaHour> getHour(String hourId) {
    return (select(agpeyaHours)..where((h) => h.id.equals(hourId))).getSingle();
  }

  /// جلب كل أقسام ساعة معينة مرتبة
  Future<List<AgpeyaSection>> getSectionsForHour(String hourId) {
    return (select(agpeyaSections)
          ..where((s) => s.hourId.equals(hourId))
          ..orderBy([(s) => OrderingTerm.asc(s.sectionOrder)]))
        .get();
  }
}
