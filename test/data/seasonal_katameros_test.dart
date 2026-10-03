import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/coptic_calendar/coptic_date.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;

  setUpAll(() {
    final assetDbFile = File('assets/databases/noor.db');
    expect(assetDbFile.existsSync(), isTrue, reason: 'assets/databases/noor.db must exist');

    final rawDb = sqlite3.open(assetDbFile.path);
    db = AppDatabase(NativeDatabase.opened(rawDb));
  });

  tearDownAll(() async {
    await db.close();
  });

  group('Seasonal Katameros Database & DAO Tests', () {
    test('Database contains Great Lent seasonal readings (55 days)', () async {
      final lentReadingsDay1 = await db.katamerosDao.getGreatLentReadings(1);
      expect(lentReadingsDay1, isNotEmpty);
      expect(lentReadingsDay1.any((r) => r.readingType == 'gospel'), isTrue);

      final lentReadingsDay55 = await db.katamerosDao.getGreatLentReadings(55);
      expect(lentReadingsDay55, isNotEmpty);
    });

    test('Database contains Pentecost seasonal readings (50 days)', () async {
      final pentReadingsDay1 = await db.katamerosDao.getPentecostReadings(1);
      expect(pentReadingsDay1, isNotEmpty);
      expect(pentReadingsDay1.any((r) => r.readingType == 'gospel'), isTrue);

      final pentReadingsDay50 = await db.katamerosDao.getPentecostReadings(50);
      expect(pentReadingsDay50, isNotEmpty);
    });

    test('Database contains Jonah fast readings (4 days)', () async {
      final jonahReadings = await db.katamerosDao.getJonahReadings(1);
      expect(jonahReadings, isNotEmpty);
      expect(jonahReadings.any((r) => r.serviceType == 'liturgy'), isTrue);
    });

    test('Database contains Sunday readings for Coptic months', () async {
      final sundayReadings = await db.katamerosDao.getSundayReadings(1, 1);
      expect(sundayReadings, isNotEmpty);
      expect(sundayReadings.any((r) => r.readingType == 'pauline'), isTrue);
    });

    test('getLiturgicalReadingsForDate returns authentic readings for annual and Sunday dates', () async {
      // Annual date: 1 Tout (Nayrouz)
      final nayrouzDate = DateTime(2026, 9, 11);
      final copticDate = CopticDate(year: 1743, month: 1, day: 1);
      final readings = await db.katamerosDao.getLiturgicalReadingsForDate(nayrouzDate, copticDate);
      expect(readings, isNotEmpty);
      expect(readings.any((r) => r.readingType == 'gospel'), isTrue);
    });
  });
}
