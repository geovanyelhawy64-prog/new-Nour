import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/data/database/app_database.dart';

void main() {
  group('Psalms LXX-MT Cross-Mapping Verification', () {
    late AppDatabase db;

    setUpAll(() async {
      final file = File('assets/databases/content_dev.db');
      expect(file.existsSync(), isTrue, reason: 'assets/databases/content_dev.db must exist (run build_content_db.py --dev first)');
      db = AppDatabase(NativeDatabase(file));
    });

    tearDownAll(() async {
      await db.close();
    });

    test('Psalms mapping table exists and is queryable', () async {
      final count = await db.select(db.psalmsMapping).get();
      expect(count.length, 151);
    });

test('Psalm 50 (LXX/Agpeya) resolves to Psalm 51 (MT/Van Dyck)', () async {
      // المزمور 50 في الأجبية (LXX) = المزمور 51 في الكتاب المقدس (MT) - مزمور التوبة
      final mapping = await (db.select(db.psalmsMapping)
            ..where((m) => m.lxx.equals(50)))
          .getSingleOrNull();
      expect(mapping, isNotNull, reason: 'LXX Psalm 50 mapping must exist');
      expect(mapping!.masoretic, 51, reason: 'Agpeya Psalm 50 should map to Van Dyck Psalm 51');
      expect(mapping.lxx, 50);
      expect(mapping.titleAr, contains('إله الآلهة الرب تكلم'), reason: 'Title should be LXX Psalm 50 title');
      expect(mapping.note, contains('51'), reason: 'Note should reference MT Psalm 51');
    });

    test('Psalm 22 (LXX/Agpeya) resolves to Psalm 22 (MT/Van Dyck)', () async {
      // المزمور 22 في الأجبية (LXX) = المزمور 22 في الكتاب المقدس (MT)
      // "إلهي إلهي لماذا تركتني"
      final mapping = await (db.select(db.psalmsMapping)
            ..where((m) => m.lxx.equals(22)))
          .getSingleOrNull();
      expect(mapping, isNotNull, reason: 'LXX Psalm 22 mapping must exist');
      expect(mapping!.masoretic, 22, reason: 'Agpeya Psalm 22 should map to Van Dyck Psalm 22');
      expect(mapping.lxx, 22);
      expect(mapping.titleAr, contains('إلهي إلهي لماذا تركتني'), reason: 'Title should be إلهي إلهي لماذا تركتني');
    });

    test('Psalm 23 (LXX/Agpeya) resolves to Psalm 23 (MT/Van Dyck)', () async {
      // المزمور 23 في الأجبية (LXX) = المزمور 23 في الكتاب المقدس (MT)
      // "الرب راعي"
      final mapping = await (db.select(db.psalmsMapping)
            ..where((m) => m.lxx.equals(23)))
          .getSingleOrNull();
      expect(mapping, isNotNull, reason: 'LXX Psalm 23 mapping must exist');
      expect(mapping!.masoretic, 23, reason: 'Agpeya Psalm 23 should map to Van Dyck Psalm 23');
      expect(mapping.lxx, 23);
      expect(mapping.titleAr, contains('الرب راعي'), reason: 'Title should reference الرب راعي');
    });

    test('Psalm 1-8 (LXX) match MT 1-8 (no offset in first 8)', () async {
      for (int i = 1; i <= 8; i++) {
        final mapping = await (db.select(db.psalmsMapping)
              ..where((m) => m.lxx.equals(i)))
            .getSingleOrNull();
        expect(mapping, isNotNull, reason: 'LXX Psalm $i mapping must exist');
        expect(mapping!.masoretic, i, reason: 'LXX Psalm $i should map to MT Psalm $i (no offset yet)');
      }
    });

    test('Psalm 9-10 (LXX combined) map to MT 9', () async {
      // LXX 9-10 = MT 9 (acrostic split)
      final m9 = await (db.select(db.psalmsMapping)..where((m) => m.lxx.equals(9))).getSingleOrNull();
      final m10 = await (db.select(db.psalmsMapping)..where((m) => m.lxx.equals(10))).getSingleOrNull();
      expect(m9, isNotNull);
      expect(m10, isNotNull);
      expect(m9!.masoretic, 9);
      expect(m10!.masoretic, 9);
    });

    test('Psalm 151 (LXX only) has no MT counterpart', () async {
      final mapping = await (db.select(db.psalmsMapping)
            ..where((m) => m.lxx.equals(151)))
          .getSingleOrNull();
      expect(mapping, isNotNull);
      expect(mapping!.masoretic, 151, reason: 'Psalm 151 is LXX-only');
      expect(mapping.note, contains('سبعينية'), reason: 'Note should mention Septuagint');
    });

    test('Agpeya Psalm 50 reference resolves to Bible verse content', () async {
      // Verify the actual Bible verse content exists for Psalm 51 (MT)
      // In Van Dyck, Psalm 51 is book_id=21 (المزامير), chapter=51
      final verses = await db.bibleDao.getChapterVerses(21, 51);
      expect(verses.length, greaterThan(0), reason: 'Van Dyck Psalm 51 must have verses');
      expect(verses.first.content, contains('ارحمني'), reason: 'Psalm 51 should start with ارحمني يا الله');
    });
  });
}