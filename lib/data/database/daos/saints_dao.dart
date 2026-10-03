import 'package:drift/drift.dart';
import '../../../core/utils/search_normalizer.dart';
import '../app_database.dart';
import '../tables/saints_tables.dart';

part 'saints_dao.g.dart';

@DriftAccessor(tables: [Saints])
class SaintsDao extends DatabaseAccessor<AppDatabase> with _$SaintsDaoMixin {
  SaintsDao(super.db);

  /// جلب كافة سير القديسين مرتبة
  Future<List<Saint>> getAllSaints() {
    return (select(saints)..orderBy([(s) => OrderingTerm.asc(s.feastMonth), (s) => OrderingTerm.asc(s.feastDay)])).get();
  }

  /// جلب القديسين حسب الفئة (martyrs, monks, patriarchs, modern, women)
  Future<List<Saint>> getSaintsByType(String type) {
    return (select(saints)
          ..where((s) => s.type.equals(type))
          ..orderBy([(s) => OrderingTerm.asc(s.feastMonth), (s) => OrderingTerm.asc(s.feastDay)]))
        .get();
  }

  /// جلب قديس بالمعرف
  Future<Saint?> getSaintById(String id) {
    return (select(saints)..where((s) => s.id.equals(id))).getSingleOrNull();
  }

  /// جلب قديسي شهر قبطي محدد
  Future<List<Saint>> getSaintsForMonth(int month) {
    return (select(saints)
          ..where((s) => s.feastMonth.equals(month))
          ..orderBy([(s) => OrderingTerm.asc(s.feastDay)]))
        .get();
  }

  /// جلب قديسي يوم وعيد محدد
  Future<List<Saint>> getSaintsByFeast(int month, int day) {
    return (select(saints)
          ..where((s) => s.feastMonth.equals(month) & s.feastDay.equals(day)))
        .get();
  }

  /// بحث في سير القديسين مع إزالة التشكيل
  Future<List<Saint>> searchSaints(String query) async {
    final all = await getAllSaints();
    if (query.trim().isEmpty) return all;

    return all.where((s) {
      return SearchNormalizer.matches(s.nameAr, query) ||
          SearchNormalizer.matches(s.shortBio, query) ||
          SearchNormalizer.matches(s.biography, query);
    }).toList();
  }
}
