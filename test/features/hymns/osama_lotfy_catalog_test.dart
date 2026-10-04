import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:noor_app/data/models/osama_lotfy_structure.dart';

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

  group('Osama Lotfy Catalog & 4 Parts Architecture Tests', () {
    test('catalog defines exactly 4 canonical parts with 19 ecclesiastical chapters', () {
      expect(OsamaLotfyPart.values.length, 5); // all + 4 parts

      final chapters = OsamaLotfyCatalog.chapters;
      expect(chapters.length, 19);

      // Part 1: Annual (السنوية)
      final annualChaps = OsamaLotfyCatalog.getChaptersForPart(OsamaLotfyPart.annual);
      expect(annualChaps.length, 3);
      final annualStats = OsamaLotfyCatalog.getPartStats(OsamaLotfyPart.annual);
      expect(annualStats.hymnsCount, 19);
      expect(annualStats.availableChapters, 3);

      // Part 2: Festive (الفرايحي)
      final festiveChaps = OsamaLotfyCatalog.getChaptersForPart(OsamaLotfyPart.festive);
      expect(festiveChaps.length, 7);
      final festiveStats = OsamaLotfyCatalog.getPartStats(OsamaLotfyPart.festive);
      expect(festiveStats.hymnsCount, 22);
      expect(festiveStats.availableChapters, 6);
      expect(festiveChaps.any((c) => !c.isAvailable), isTrue); // Nayrouz is empty

      // Part 3: Sorrowful (الحزايني)
      final sorrowfulChaps = OsamaLotfyCatalog.getChaptersForPart(OsamaLotfyPart.sorrowful);
      expect(sorrowfulChaps.length, 5);
      final sorrowfulStats = OsamaLotfyCatalog.getPartStats(OsamaLotfyPart.sorrowful);
      expect(sorrowfulStats.hymnsCount, 16);
      expect(sorrowfulStats.availableChapters, 3);
      final emptySorrowful = sorrowfulChaps.where((c) => !c.isAvailable).toList();
      expect(emptySorrowful.length, 2); // Pascha Psalms + Funerals

      // Part 4: Kiahk (كيهك)
      final kiahkChaps = OsamaLotfyCatalog.getChaptersForPart(OsamaLotfyPart.kiahk);
      expect(kiahkChaps.length, 4);
      final kiahkStats = OsamaLotfyCatalog.getPartStats(OsamaLotfyPart.kiahk);
      expect(kiahkStats.hymnsCount, 6);
      expect(kiahkStats.availableChapters, 2);
      final emptyKiahk = kiahkChaps.where((c) => !c.isAvailable).toList();
      expect(emptyKiahk.length, 2); // Theotokias + Doxologies
    });

    test('verifies all 63 hymns in the database exist in the catalog without duplicates or orphans', () async {
      final allDbHymns = await db.hymnsDao.getAllBooks().then(
            (_) => db.select(db.hymns).get(),
          );
      expect(allDbHymns.length, 63);

      final catalogHymnIds = <String>{};
      for (final c in OsamaLotfyCatalog.chapters) {
        for (final hid in c.hymnIds) {
          expect(catalogHymnIds.contains(hid), isFalse, reason: 'Duplicate hymn ID in catalog: $hid');
          catalogHymnIds.add(hid);
        }
      }

      expect(catalogHymnIds.length, 63);

      // Verify every DB hymn is present in catalog
      for (final hymn in allDbHymns) {
        expect(catalogHymnIds.contains(hymn.id), isTrue, reason: 'Hymn ${hymn.id} is missing from catalog');
      }
    });

    test('verifies key hymns are in their exact liturgical parts and chapters', () async {
      // Epouro in Annual Liturgy
      final annualLiturgy = OsamaLotfyCatalog.getChapterById('ch_annual_liturgy');
      expect(annualLiturgy, isNotNull);
      expect(annualLiturgy!.hymnIds.contains('ol02_01'), isTrue);

      // Khristos Anesti in Resurrection
      final resurrection = OsamaLotfyCatalog.getChapterById('ch_festive_resurrection');
      expect(resurrection, isNotNull);
      expect(resurrection!.hymnIds.contains('ol09_02'), isTrue);

      // Golgotha in Good Friday
      final holyWeekEnd = OsamaLotfyCatalog.getChapterById('ch_sorrowful_holy_week_end');
      expect(holyWeekEnd, isNotNull);
      expect(holyWeekEnd!.hymnIds.contains('ol08_04'), isTrue);

      // Efnouti Nai Nan in Kiahk
      final kiahkTasbeha = OsamaLotfyCatalog.getChapterById('ch_kiahk_tasbeha');
      expect(kiahkTasbeha, isNotNull);
      expect(kiahkTasbeha!.hymnIds.contains('ol03_01'), isTrue);
    });

    test('verifies empty chapters are clearly marked as not available', () {
      final nayrouz = OsamaLotfyCatalog.getChapterById('ch_festive_nayrouz');
      expect(nayrouz, isNotNull);
      expect(nayrouz!.isAvailable, isFalse);
      expect(nayrouz.count, 0);

      final paschaPsalms = OsamaLotfyCatalog.getChapterById('ch_sorrowful_pascha_psalms');
      expect(paschaPsalms, isNotNull);
      expect(paschaPsalms!.isAvailable, isFalse);
      expect(paschaPsalms.count, 0);

      final burials = OsamaLotfyCatalog.getChapterById('ch_sorrowful_burials');
      expect(burials, isNotNull);
      expect(burials!.isAvailable, isFalse);
      expect(burials.count, 0);
    });
  });
}
