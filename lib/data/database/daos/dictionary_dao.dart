import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/dictionary_tables.dart';

part 'dictionary_dao.g.dart';

@DriftAccessor(tables: [CopticDictionary])
class DictionaryDao extends DatabaseAccessor<AppDatabase>
    with _$DictionaryDaoMixin {
  DictionaryDao(super.db);

  Future<List<CopticDictionaryEntry>> search(String query) {
    final normalized = query.trim();
    if (normalized.isEmpty) return Future.value([]);

    return (select(copticDictionary)
          ..where((d) =>
              d.coptic.contains(normalized) |
              d.phonetic.contains(normalized) |
              d.arabic.contains(normalized) |
              d.english.contains(normalized))
          ..orderBy([(d) => OrderingTerm.asc(d.coptic)])
          ..limit(50))
        .get();
  }

  Future<List<CopticDictionaryEntry>> getByLetter(String letter) {
    return (select(copticDictionary)
          ..where((d) => d.coptic.like('$letter%'))
          ..orderBy([(d) => OrderingTerm.asc(d.coptic)])
          ..limit(100))
        .get();
  }

  Future<List<CopticDictionaryEntry>> getAll({int limit = 100, int offset = 0}) {
    return (select(copticDictionary)
          ..orderBy([(d) => OrderingTerm.asc(d.coptic)])
          ..limit(limit, offset: offset))
        .get();
  }

  Future<int> getCount() {
    final countExp = copticDictionary.id.count();
    return (selectOnly(copticDictionary)..addColumns([countExp]))
        .map((row) => row.read(countExp) ?? 0)
        .getSingle();
  }

  Future<List<String>> getDistinctLetters() async {
    final rows = await customSelect(
      'SELECT DISTINCT SUBSTR(coptic, 1, 1) as letter FROM coptic_dictionary ORDER BY letter',
      readsFrom: {copticDictionary},
    ).get();
    return rows.map((r) => r.read<String>('letter')).toList();
  }
}
