import 'package:drift/drift.dart';
import '../app_database.dart';
import '../required_database_value.dart';
import '../tables/emotion_prayer_tables.dart';

part 'emotion_prayer_dao.g.dart';

@DriftAccessor(tables: [EmotionPrayers])
class EmotionPrayerDao extends DatabaseAccessor<AppDatabase> with _$EmotionPrayerDaoMixin {
  EmotionPrayerDao(super.db);

  Future<List<EmotionPrayer>> getAll() =>
      (select(emotionPrayers)..orderBy([(e) => OrderingTerm.asc(e.sortOrder)])).get();

  Future<List<EmotionPrayer>> getByCategory(String category) =>
      (select(emotionPrayers)
            ..where((e) => e.category.equals(category))
            ..orderBy([(e) => OrderingTerm.asc(e.sortOrder)]))
          .get();

  Future<EmotionPrayer?> getById(int id) =>
      (select(emotionPrayers)..where((e) => e.id.equals(id))).getSingleOrNull();

  Future<List<String>> getCategories() =>
      (selectOnly(emotionPrayers, distinct: true)
            ..addColumns([emotionPrayers.category])
            ..orderBy([OrderingTerm.asc(emotionPrayers.sortOrder)]))
          .map((row) => requireDatabaseValue(row.read(emotionPrayers.category), 'emotion_prayers.category'))
          .get();

  Future<int> getCount() {
    final countExp = emotionPrayers.id.count();
    return (selectOnly(emotionPrayers)..addColumns([countExp]))
        .map((row) => row.read(countExp) ?? 0)
        .getSingle();
  }
}
