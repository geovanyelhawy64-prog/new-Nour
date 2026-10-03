import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/feasts_tables.dart';

part 'feasts_dao.g.dart';

@DriftAccessor(tables: [FeastsAndFasts])
class FeastsDao extends DatabaseAccessor<AppDatabase> with _$FeastsDaoMixin {
  FeastsDao(super.db);

  /// جلب كافة الأعياد والأصوام
  Future<List<FeastsAndFast>> getAllFeastsAndFasts() {
    return select(feastsAndFasts).get();
  }

  /// جلب حسب النوع (major_feast, minor_feast, fast)
  Future<List<FeastsAndFast>> getByType(String type) {
    return (select(feastsAndFasts)..where((f) => f.type.equals(type))).get();
  }

  /// جلب الأعياد السيدية الكبرى
  Future<List<FeastsAndFast>> getMajorFeasts() {
    return getByType('major_feast');
  }

  /// جلب الأعياد السيدية الصغرى
  Future<List<FeastsAndFast>> getMinorFeasts() {
    return getByType('minor_feast');
  }

  /// جلب الأصوام الكنسية
  Future<List<FeastsAndFast>> getFasts() {
    return getByType('fast');
  }

  /// جلب الأعياد المرتبطة بشهر قبطي محدد
  Future<List<FeastsAndFast>> getForMonth(int month) {
    return (select(feastsAndFasts)
          ..where((f) => f.copticMonth.equals(month))
          ..orderBy([(f) => OrderingTerm.asc(f.copticDay)]))
        .get();
  }

  /// جلب الأعياد والأصوام المتنقلة (تحسب بحساب الإبقطي وفصح القيامة)
  Future<List<FeastsAndFast>> getMovable() {
    return (select(feastsAndFasts)..where((f) => f.isMovable.equals(true))).get();
  }

  /// جلب تفاصيل عيد أو صوم بالمعرف
  Future<FeastsAndFast?> getById(String id) {
    return (select(feastsAndFasts)..where((f) => f.id.equals(id))).getSingleOrNull();
  }
}
