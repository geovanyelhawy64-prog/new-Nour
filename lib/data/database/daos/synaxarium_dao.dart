import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/synaxarium_tables.dart';

part 'synaxarium_dao.g.dart';

@DriftAccessor(tables: [SynaxariumEntries])
class SynaxariumDao extends DatabaseAccessor<AppDatabase> with _$SynaxariumDaoMixin {
  SynaxariumDao(super.db);

  /// جلب سير وتذكارات يوم قبطي محدد
  Future<List<SynaxariumEntry>> getEntriesForDay(int month, int day) {
    return (select(synaxariumEntries)
          ..where((e) => e.copticMonth.equals(month) & e.copticDay.equals(day))
          ..orderBy([(e) => OrderingTerm.asc(e.entryOrder)]))
        .get();
  }

  /// جلب تذكار بالمعرف
  Future<SynaxariumEntry> getEntryById(String id) {
    return (select(synaxariumEntries)..where((e) => e.id.equals(id))).getSingle();
  }

  /// بحث في السنكسار
  Future<List<SynaxariumEntry>> searchEntries(String query) {
    return (select(synaxariumEntries)
          ..where((e) => e.title.contains(query) | e.fullText.contains(query))
          ..orderBy([(e) => OrderingTerm.asc(e.copticMonth), (e) => OrderingTerm.asc(e.copticDay)]))
        .get();
  }

  /// جلب تذكارات شهر قبطي كامل
  Future<List<SynaxariumEntry>> getEntriesForMonth(int month) {
    return (select(synaxariumEntries)
          ..where((e) => e.copticMonth.equals(month))
          ..orderBy([(e) => OrderingTerm.asc(e.copticDay), (e) => OrderingTerm.asc(e.entryOrder)]))
        .get();
  }
}
