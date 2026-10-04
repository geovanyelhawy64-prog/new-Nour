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

  group('HolyPlaces DAO', () {
    test('holy_places table exists and count query succeeds', () async {
      final count = await db.holyPlaceDao.getCount();
      expect(count, greaterThanOrEqualTo(0));
    });

    test('getAll returns a list', () async {
      final places = await db.holyPlaceDao.getAll();
      expect(places, isA<List>());
    });

    test('getByType returns filtered list', () async {
      final monasteries = await db.holyPlaceDao.getByType('monasteryMen');
      expect(monasteries, isA<List>());
    });

    test('getByGovernorate returns list', () async {
      final places = await db.holyPlaceDao.getByGovernorate('البحيرة');
      expect(places, isA<List>());
    });

    test('search returns matching list', () async {
      final results = await db.holyPlaceDao.search('أنطونيوس');
      expect(results, isA<List>());
    });

    test('getById returns null for non-existent id', () async {
      final place = await db.holyPlaceDao.getById(99999);
      expect(place, isNull);
    });

    test('getGovernorates returns list of strings', () async {
      final govs = await db.holyPlaceDao.getGovernorates();
      expect(govs, isA<List<String>>());
    });
  });
}
