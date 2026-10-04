import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/data/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUpAll(() async {
    final file = File('assets/databases/noor.db');
    expect(file.existsSync(), isTrue, reason: 'assets/databases/noor.db must exist');
    db = AppDatabase(NativeDatabase(file));
  });

  tearDownAll(() async {
    await db.close();
  });

  group('Hymn Books & 11 Canonical Volumes Tests', () {
    test('hymn_books returns 11 books corresponding to Osama Lotfy structure', () async {
      final books = await db.hymnsDao.getAllBooks();
      expect(books.length, equals(11));
      expect(books[0].id, 'osama_lotfy_01');
      expect(books[0].nameAr, contains('بخور عشية وباكر'));
      expect(books[1].id, 'osama_lotfy_02');
      expect(books[1].nameAr, contains('القداس الإلهي'));
      expect(books[2].id, 'osama_lotfy_03');
      expect(books[2].nameAr, contains('صوم وأعياد شهر كيهك'));
      expect(books[3].id, 'osama_lotfy_04');
      expect(books[3].nameAr, contains('الميلاد المجيد والغطاس'));
      expect(books[4].id, 'osama_lotfy_05');
      expect(books[4].nameAr, contains('صوم يونان والصوم الكبير'));
      expect(books[5].id, 'osama_lotfy_06');
      expect(books[5].nameAr, contains('جمعة ختام الصوم'));
      expect(books[6].id, 'osama_lotfy_07');
      expect(books[6].nameAr, contains('أسبوع الآلام والبصخة'));
      expect(books[7].id, 'osama_lotfy_08');
      expect(books[7].nameAr, contains('خميس العهد والجمعة العظيمة'));
      expect(books[8].id, 'osama_lotfy_09');
      expect(books[8].nameAr, contains('عيد القيامة المجيد'));
      expect(books[9].id, 'osama_lotfy_10');
      expect(books[9].nameAr, contains('أعياد الصعود والعنصرة'));
      expect(books[10].id, 'osama_lotfy_11');
      expect(books[10].nameAr, contains('صوم وعيد السيدة العذراء'));
    });

    test('hymns table maintains all 63 hymns distributed over the 11 books', () async {
      final allHymns = await db.select(db.hymns).get();
      expect(allHymns.length, 63);

      final book1Hymns = await db.hymnsDao.getHymnsForBook('osama_lotfy_01');
      expect(book1Hymns.length, 9);

      final book2Hymns = await db.hymnsDao.getHymnsForBook('osama_lotfy_02');
      expect(book2Hymns.length, 10);

      final book3Hymns = await db.hymnsDao.getHymnsForBook('osama_lotfy_03');
      expect(book3Hymns.length, 6);

      final book4Hymns = await db.hymnsDao.getHymnsForBook('osama_lotfy_04');
      expect(book4Hymns.length, 5);

      final book5Hymns = await db.hymnsDao.getHymnsForBook('osama_lotfy_05');
      expect(book5Hymns.length, 5);

      final book6Hymns = await db.hymnsDao.getHymnsForBook('osama_lotfy_06');
      expect(book6Hymns.length, 4);

      final book7Hymns = await db.hymnsDao.getHymnsForBook('osama_lotfy_07');
      expect(book7Hymns.length, 5);

      final book8Hymns = await db.hymnsDao.getHymnsForBook('osama_lotfy_08');
      expect(book8Hymns.length, 5);

      final book9Hymns = await db.hymnsDao.getHymnsForBook('osama_lotfy_09');
      expect(book9Hymns.length, 5);

      final book10Hymns = await db.hymnsDao.getHymnsForBook('osama_lotfy_10');
      expect(book10Hymns.length, 4);

      final book11Hymns = await db.hymnsDao.getHymnsForBook('osama_lotfy_11');
      expect(book11Hymns.length, 5);
    });

    test('database indexes exist on all queried columns', () async {
      final indexes = await db.customSelect("SELECT name FROM sqlite_master WHERE type='index'").get();
      final indexNames = indexes.map((r) => r.read<String>('name')).toSet();

      expect(indexNames.contains('idx_bible_verses_lookup'), isTrue);
      expect(indexNames.contains('idx_katameros_date'), isTrue);
      expect(indexNames.contains('idx_synaxarium_date'), isTrue);
      expect(indexNames.contains('idx_difnar_date'), isTrue);
      expect(indexNames.contains('idx_agpeya_sections'), isTrue);
      expect(indexNames.contains('idx_liturgy_parts'), isTrue);
      expect(indexNames.contains('idx_hymns_book'), isTrue);
      expect(indexNames.contains('idx_hymn_segments'), isTrue);
      expect(indexNames.contains('idx_pascha_readings'), isTrue);
      expect(indexNames.contains('idx_psali_sections'), isTrue);
      expect(indexNames.contains('idx_rite_sections'), isTrue);
      expect(indexNames.contains('idx_holy_places_type'), isTrue);
      expect(indexNames.contains('idx_holy_places_gov'), isTrue);
      expect(indexNames.contains('idx_emotion_prayers_cat'), isTrue);
    });
  });
}
