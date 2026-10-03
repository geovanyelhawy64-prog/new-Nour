import '../database/daos/emotion_prayer_dao.dart';
import '../database/app_database.dart';
import '../models/emotion_prayer.dart' as model;

class EmotionPrayerRepository {
  final EmotionPrayerDao _dao;
  EmotionPrayerRepository(this._dao);

  Future<List<model.EmotionPrayer>> getAll() async {
    final rows = await _dao.getAll();
    return rows.map(_toModel).toList();
  }

  Future<List<model.EmotionPrayer>> getByCategory(String cat) async {
    final rows = await _dao.getByCategory(cat);
    return rows.map(_toModel).toList();
  }

  Future<model.EmotionPrayer?> getById(int id) async {
    final row = await _dao.getById(id);
    return row != null ? _toModel(row) : null;
  }

  Future<List<String>> getCategories() => _dao.getCategories();
  Future<int> getCount() => _dao.getCount();

  static model.EmotionPrayer _toModel(EmotionPrayer e) => model.EmotionPrayer(
    id: e.id,
    category: e.category,
    title: e.title,
    verseText: e.verseText,
    verseReference: e.verseReference,
    psalmText: e.psalmText,
    psalmReference: e.psalmReference,
    agpeyaPrayer: e.agpeyaPrayer,
    agpeyaReference: e.agpeyaReference,
    meditation: e.meditation,
    sortOrder: e.sortOrder,
  );
}
