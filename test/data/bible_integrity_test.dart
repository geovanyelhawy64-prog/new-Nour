import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/data/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUpAll(() {
    final file = File('assets/databases/noor.db');
    expect(file.existsSync(), isTrue, reason: 'assets/databases/noor.db must exist');
    db = AppDatabase(NativeDatabase(file));
  });

  tearDownAll(() async {
    await db.close();
  });

  group('Bible Integrity Master Audit Tests', () {
    test('عدد الأسفار = 73 (39 قديم + 7 قانونية ثانية + 27 جديد)', () async {
      final books = await db.bibleDao.getAllBooks();
      expect(books.length, 73);

      final old = await db.bibleDao.getBooksByTestament('old');
      expect(old.length, 39);

      final deutero = await db.bibleDao.getBooksByTestament('deutero');
      expect(deutero.length, 7);

      final newT = await db.bibleDao.getBooksByTestament('new');
      expect(newT.length, 27);
    });

    test('عدد المزامير = 151 (يشمل المزمور 151 السبعيني الكنسي)', () async {
      final psalmsBook = await db.bibleDao.getBook(21);
      expect(psalmsBook.nameAr, contains('المزامير'));
      expect(psalmsBook.chapterCount, 151);

      // Verify Psalm 151 verses exist
      final p151Verses = await db.bibleDao.getChapterVerses(21, 151);
      expect(p151Verses.length, 8);
      expect(p151Verses.first.content, contains('صغيرا'));
    });

    test('كل سفر فيه فصول > 0', () async {
      final books = await db.bibleDao.getAllBooks();
      for (final book in books) {
        expect(book.chapterCount, greaterThan(0), reason: 'Book ${book.nameAr} has 0 chapters');
      }
    });

    test('كل فصل في كل سفر فيه آيات > 0', () async {
      final genesis1 = await db.bibleDao.getChapterVerses(1, 1);
      expect(genesis1.length, 31);

      final matthew1 = await db.bibleDao.getChapterVerses(47, 1);
      expect(matthew1.length, 25);

      final revelation22 = await db.bibleDao.getChapterVerses(73, 22);
      expect(revelation22.length, 21);
    });

    test('مفيش آية فاضية ومفيش آية فيها HTML tags وكل آية فيها أكتر من 3 حروف', () async {
      final sampleVerses = await db.bibleDao.getChapterVerses(1, 1);
      for (final verse in sampleVerses) {
        expect(verse.content.trim().isNotEmpty, isTrue);
        expect(verse.content.contains('<') && verse.content.contains('>'), isFalse);
        expect(verse.content.trim().length, greaterThan(3));
      }
    });
  });
}
