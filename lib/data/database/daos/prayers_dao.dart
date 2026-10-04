import 'package:drift/drift.dart';
import '../../../core/utils/search_normalizer.dart';
import '../app_database.dart';
import '../tables/prayers_tables.dart';

part 'prayers_dao.g.dart';

@DriftAccessor(tables: [OccasionalPrayers])
class PrayersDao extends DatabaseAccessor<AppDatabase> with _$PrayersDaoMixin {
  PrayersDao(super.db);

  /// جلب كافة صلوات المناسبات
  Future<List<OccasionalPrayer>> getAllPrayers() {
    return (select(occasionalPrayers)..orderBy([(p) => OrderingTerm.asc(p.prayerOrder)])).get();
  }

  /// جلب الصلوات حسب التصنيف
  Future<List<OccasionalPrayer>> getPrayersByCategory(String category) {
    final effectiveCategory = category == 'meals' ? 'daily' : category;
    return (select(occasionalPrayers)
          ..where((p) => p.category.equals(effectiveCategory))
          ..orderBy([(p) => OrderingTerm.asc(p.prayerOrder)]))
        .get();
  }

  /// جلب صلاة بالمعرف
  Future<OccasionalPrayer?> getPrayerById(String id) {
    return (select(occasionalPrayers)..where((p) => p.id.equals(id))).getSingleOrNull();
  }

  /// بحث في الصلوات مع إزالة التشكيل وتوحيد الحروف العربية
  Future<List<OccasionalPrayer>> searchPrayers(String query) async {
    final all = await getAllPrayers();
    if (query.trim().isEmpty) return all;

    return all.where((p) {
      return SearchNormalizer.matches(p.title, query) ||
          SearchNormalizer.matches(p.content, query) ||
          SearchNormalizer.matches(p.categoryAr, query);
    }).toList();
  }

  /// جلب قائمة الفئات المتوفرة
  Future<List<String>> getAvailableCategories() async {
    final query = selectOnly(occasionalPrayers, distinct: true)..addColumns([occasionalPrayers.category]);
    final rows = await query.get();
    return rows.map((r) => r.read(occasionalPrayers.category)!).toList();
  }
}
