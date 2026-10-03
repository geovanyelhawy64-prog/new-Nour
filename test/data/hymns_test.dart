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

  group('Hymn Books & 4 Canonical Volumes Tests', () {
    test('hymn_books returns 4 books corresponding to Osama Lotfy structure', () async {
      final books = await db.hymnsDao.getAllBooks();
      expect(books.length, equals(4));
      expect(books[0].id, 'osama_lotfy_01');
      expect(books[0].nameAr, contains('بخور عشية وباكر'));
      expect(books[1].id, 'osama_lotfy_02');
      expect(books[1].nameAr, contains('القداس الإلهي'));
      expect(books[2].id, 'osama_lotfy_03');
      expect(books[2].nameAr, contains('المناسبات والأعياد'));
      expect(books[3].id, 'osama_lotfy_04');
      expect(books[3].nameAr, contains('الصوم الكبير وأسبوع الآلام'));
    });

    test('hymns table maintains all 63 hymns distributed over the 4 books', () async {
      final allHymns = await db.select(db.hymns).get();
      expect(allHymns.length, 63);

      final book1Hymns = await db.hymnsDao.getHymnsForBook('osama_lotfy_01');
      expect(book1Hymns.length, 9);

      final book2Hymns = await db.hymnsDao.getHymnsForBook('osama_lotfy_02');
      expect(book2Hymns.length, 10);

      final book3Hymns = await db.hymnsDao.getHymnsForBook('osama_lotfy_03');
      expect(book3Hymns.length, 25);

      final book4Hymns = await db.hymnsDao.getHymnsForBook('osama_lotfy_04');
      expect(book4Hymns.length, 19);
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
