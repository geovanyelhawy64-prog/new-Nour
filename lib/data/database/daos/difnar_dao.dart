import 'package:drift/drift.dart';
import '../../../core/utils/search_normalizer.dart';
import '../app_database.dart';
import '../tables/difnar_tables.dart';

part 'difnar_dao.g.dart';

@DriftAccessor(tables: [DifnarEntries])
class DifnarDao extends DatabaseAccessor<AppDatabase> with _$DifnarDaoMixin {
  DifnarDao(super.db);

  /// جلب كافة نصوص الدفنار
  Future<List<DifnarEntry>> getAllDifnar() {
    return select(difnarEntries).get();
  }

  /// جلب دفنار يوم قبطي محدد
  Future<List<DifnarEntry>> getEntriesForDay(int month, int day) {
    return (select(difnarEntries)
          ..where((d) => d.copticMonth.equals(month) & d.copticDay.equals(day)))
        .get();
  }

  /// جلب دفنار بالمعرف
  Future<DifnarEntry?> getEntryById(String id) {
    return (select(difnarEntries)..where((d) => d.id.equals(id))).getSingleOrNull();
  }

  /// جلب دفنار شهر قبطي كامل
  Future<List<DifnarEntry>> getEntriesForMonth(int month) {
    return (select(difnarEntries)
          ..where((d) => d.copticMonth.equals(month))
          ..orderBy([(d) => OrderingTerm.asc(d.copticDay)]))
        .get();
  }

  /// بحث في نصوص الدفنار والمدائح
  Future<List<DifnarEntry>> searchDifnar(String query) async {
    final all = await getAllDifnar();
    if (query.trim().isEmpty) return all;

    return all.where((d) {
      return SearchNormalizer.matches(d.textAr, query) ||
          SearchNormalizer.matches(d.textPhonetic, query) ||
          SearchNormalizer.matches(d.textCoptic, query);
    }).toList();
  }
}
