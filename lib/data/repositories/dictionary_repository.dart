import '../database/app_database.dart';
import '../models/coptic_dictionary_entry.dart' as model;
import '../../core/services/database_service.dart';

class DictionaryRepository {
  final _db = DatabaseService.instance;

  Future<List<model.CopticDictionaryEntry>> search(String query) async {
    final rows = await _db.dictionaryDao.search(query);
    return rows.map(_mapToModel).toList();
  }

  Future<List<model.CopticDictionaryEntry>> getByLetter(String letter) async {
    final rows = await _db.dictionaryDao.getByLetter(letter);
    return rows.map(_mapToModel).toList();
  }

  Future<List<model.CopticDictionaryEntry>> getAll({
    int limit = 100,
    int offset = 0,
  }) async {
    final rows = await _db.dictionaryDao.getAll(
      limit: limit,
      offset: offset,
    );
    return rows.map(_mapToModel).toList();
  }

  Future<int> getCount() async {
    return _db.dictionaryDao.getCount();
  }

  Future<List<String>> getDistinctLetters() async {
    return _db.dictionaryDao.getDistinctLetters();
  }

  model.CopticDictionaryEntry _mapToModel(CopticDictionaryEntry row) {
    return model.CopticDictionaryEntry(
      id: row.id,
      coptic: row.coptic,
      phonetic: row.phonetic,
      arabic: row.arabic,
      english: row.english,
      partOfSpeech: row.partOfSpeech,
      usage: row.usage,
      hymnReference: row.hymnReference,
    );
  }
}
