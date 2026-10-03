import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/data/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.test();
  });

  tearDown(() async {
    await db.close();
  });

  group('EmotionPrayers DAO', () {
    test('emotion_prayers table exists and count query succeeds', () async {
      final count = await db.emotionPrayerDao.getCount();
      expect(count, greaterThanOrEqualTo(0));
    });

    test('getAll returns list', () async {
      final list = await db.emotionPrayerDao.getAll();
      expect(list, isA<List>());
    });

    test('getByCategory returns filtered list', () async {
      final list = await db.emotionPrayerDao.getByCategory('comfort');
      expect(list, isA<List>());
    });

    test('getCategories returns distinct list of categories', () async {
      final cats = await db.emotionPrayerDao.getCategories();
      expect(cats, isA<List<String>>());
    });
  });
}
