import 'package:drift/drift.dart';
import '../../../core/utils/search_normalizer.dart';
import '../app_database.dart';
import '../tables/sacraments_tables.dart';

part 'sacraments_dao.g.dart';

@DriftAccessor(tables: [Sacraments, SacramentSections])
class SacramentsDao extends DatabaseAccessor<AppDatabase> with _$SacramentsDaoMixin {
  SacramentsDao(super.db);

  /// جلب كافة الأسرار الكنسية السبعة مرتبة طقسياً
  Future<List<Sacrament>> getAllSacraments() {
    return (select(sacraments)..orderBy([(s) => OrderingTerm.asc(s.sacramentOrder)])).get();
  }

  /// جلب سر بالمعرف
  Future<Sacrament?> getSacramentById(String id) {
    return (select(sacraments)..where((s) => s.id.equals(id))).getSingleOrNull();
  }

  /// جلب أقسام وشروحات سر محدد مرتبة
  Future<List<SacramentSection>> getSectionsForSacrament(String sacramentId) {
    return (select(sacramentSections)
          ..where((sec) => sec.sacramentId.equals(sacramentId))
          ..orderBy([(sec) => OrderingTerm.asc(sec.sectionOrder)]))
        .get();
  }

  /// بحث في شروحات ونصوص الأسرار المقدسة
  Future<List<SacramentSection>> searchSections(String query) async {
    final all = await select(sacramentSections).get();
    if (query.trim().isEmpty) return all;

    return all.where((sec) {
      return SearchNormalizer.matches(sec.title, query) ||
          SearchNormalizer.matches(sec.content, query) ||
          (sec.scriptures != null && SearchNormalizer.matches(sec.scriptures!, query));
    }).toList();
  }
}
