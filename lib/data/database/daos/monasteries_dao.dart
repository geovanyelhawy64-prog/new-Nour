import 'package:drift/drift.dart';
import '../../../core/utils/search_normalizer.dart';
import '../app_database.dart';
import '../tables/monasteries_tables.dart';

part 'monasteries_dao.g.dart';

@DriftAccessor(tables: [Monasteries])
class MonasteriesDao extends DatabaseAccessor<AppDatabase> with _$MonasteriesDaoMixin {
  MonasteriesDao(super.db);

  /// جلب كافة الأديرة والمزارات
  Future<List<MonasteryEntry>> getAllSites() {
    return select(monasteries).get();
  }

  /// جلب الأديرة الرهبانية فقط
  Future<List<MonasteryEntry>> getMonasteries() {
    return (select(monasteries)..where((m) => m.type.equals('monastery'))).get();
  }

  /// جلب الكنائس والمزارات الأثرية فقط
  Future<List<MonasteryEntry>> getChurches() {
    return (select(monasteries)..where((m) => m.type.equals('church'))).get();
  }

  /// جلب دير أو مزار بواسطة المعرف الفريد
  Future<MonasteryEntry?> getSiteById(String id) {
    return (select(monasteries)..where((m) => m.id.equals(id))).getSingleOrNull();
  }

  /// بحث في الأديرة والكنائس بالاسم أو الموقع أو المؤسس أو الشفيع
  Future<List<MonasteryEntry>> searchSites(String query) {
    if (query.trim().isEmpty) return getAllSites();
    final norm = SearchNormalizer.normalize(query);
    return (select(monasteries)
          ..where((m) =>
              m.nameAr.contains(norm) |
              m.nameAr.contains(query) |
              m.location.contains(norm) |
              m.location.contains(query) |
              m.founder.contains(norm) |
              m.founder.contains(query) |
              m.description.contains(norm) |
              m.description.contains(query)))
        .get();
  }

  /// جلب المعالم حسب الشهر القبطي للعيد
  Future<List<MonasteryEntry>> getSitesByFeastMonth(int copticMonth) {
    return (select(monasteries)..where((m) => m.copticMonth.equals(copticMonth))).get();
  }
}
