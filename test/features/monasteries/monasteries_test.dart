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
    late final repo = MonasteriesRepository();

    test('monasteries table exists and is queryable (currently empty in DB)', () async {
      final all = await repo.getAllSites();
      expect(all.length, 0);

      final monasteries = await repo.getMonasteries();
      expect(monasteries.length, 0);

      final churches = await repo.getChurches();
      expect(churches.length, 0);
    });

    test('getSiteById returns null for non-existent IDs', () async {
      final site = await repo.getSiteById('non_existent');
      expect(site, isNull);
    });

    test('searchSites returns empty list when no data', () async {
      final results = await repo.searchSites('أنطونيوس');
      expect(results.isEmpty, isTrue);
    });
  });
}
