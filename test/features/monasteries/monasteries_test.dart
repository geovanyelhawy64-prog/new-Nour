import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:noor_app/data/repositories/monasteries_repository.dart';

void main() {
  late AppDatabase db;

  setUpAll(() async {
    final file = File('assets/databases/noor.db');
    expect(file.existsSync(), isTrue, reason: 'assets/databases/noor.db must exist');
    db = AppDatabase(NativeDatabase(file));
    await DatabaseService.init(db);
  });

  tearDownAll(() async {
    await DatabaseService.close();
  });

  group('MonasteriesRepository (دليل الأديرة والكنائس الأثرية) Tests', () {
    const repo = MonasteriesRepository();

    test('contains at least 20 major monasteries and ancient churches (24 in DB)', () async {
      final all = await repo.getAllSites();
      expect(all.length, greaterThanOrEqualTo(20));
      expect(all.length, 24);

      final monasteries = await repo.getMonasteries();
      expect(monasteries.length, 17);

      final churches = await repo.getChurches();
      expect(churches.length, 7);
    });

    test('verifies key monastic foundation sites are accurately documented', () async {
      // St. Anthony
      final stAnthony = await repo.getSiteById('st_anthony');
      expect(stAnthony, isNotNull);
      expect(stAnthony!.nameAr, contains('أنطونيوس'));
      expect(stAnthony.location, contains('البحر الأحمر'));
      expect(stAnthony.feastDate, contains('طوبة'));
      expect(stAnthony.nameCoptic, isNotNull);

      // St. Paul
      final stPaul = await repo.getSiteById('st_paul');
      expect(stPaul, isNotNull);
      expect(stPaul!.nameAr, contains('بولا'));
      expect(stPaul.feastDate, contains('أمشير'));

      // St. Macarius
      final stMacarius = await repo.getSiteById('st_macarius');
      expect(stMacarius, isNotNull);
      expect(stMacarius!.location, contains('وادي النطرون'));

      // The Hanging Church
      final hanging = await repo.getSiteById('hanging_church');
      expect(hanging, isNotNull);
      expect(hanging!.nameAr, contains('المعلقة'));
      expect(hanging.location, contains('مصر القديمة'));
    });

    test('searches sites by name, saint, location, or historical keywords', () async {
      final wadiNatrun = await repo.searchSites('وادي النطرون');
      expect(wadiNatrun.length, greaterThanOrEqualTo(3));

      final copticCairo = await repo.searchSites('مصر القديمة');
      expect(copticCairo.length, greaterThanOrEqualTo(2));

      final searchAnthony = await repo.searchSites('أنطونيوس');
      expect(searchAnthony.isNotEmpty, isTrue);
    });
  });
}
