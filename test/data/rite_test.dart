import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:noor_app/data/models/rite.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.test();
  });

  tearDown(() async {
    await db.close();
  });

  group('Rites', () {
    test('rites table exists and is queryable', () async {
      final count = await db.riteDao.getCount();
      expect(count, greaterThanOrEqualTo(0));
    });

    test('rite_sections table exists and is queryable', () async {
      final count = await db.riteDao.getSectionsCount();
      expect(count, greaterThanOrEqualTo(0));
    });

    test('getAll returns list', () async {
      final rites = await db.riteDao.getAll();
      expect(rites, isA<List>());
    });

    test('getByCategory returns filtered list', () async {
      final rites = await db.riteDao.getByCategory('sacrament');
      expect(rites, isA<List>());
    });

    test('getSections returns list for valid riteId', () async {
      final sections = await db.riteDao.getSections(1);
      expect(sections, isA<List>());
    });

    test('getById returns null for non-existent id', () async {
      final rite = await db.riteDao.getById(9999);
      expect(rite, isNull);
    });

    test('getCategories returns list of strings', () async {
      final cats = await db.riteDao.getCategories();
      expect(cats, isA<List<String>>());
    });

    test('RiteCategory model enum parses correctly', () {
      expect(RiteCategory.fromString('sacrament'), RiteCategory.sacrament);
      expect(RiteCategory.fromString('ordination'), RiteCategory.ordination);
      expect(RiteCategory.fromString('funeral'), RiteCategory.funeral);
      expect(RiteCategory.fromString('laqan'), RiteCategory.laqan);
      expect(RiteCategory.fromString('consecration'), RiteCategory.consecration);
      expect(RiteCategory.fromString('unknown'), RiteCategory.sacrament);
    });
  });
}
