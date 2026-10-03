import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:noor_app/data/models/bible_commentary.dart' as model;
import 'package:noor_app/data/repositories/commentary_repository.dart';

void main() {
  late AppDatabase db;
  late CommentaryRepository repository;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);
    repository = CommentaryRepository();

    // Insert sample test data
    await db.commentaryDao.insertCommentary(
      BibleCommentariesCompanion.insert(
        bookId: 43,
        chapter: 3,
        source: 'تفسير القمص أنطونيوس فكري',
        author: 'القمص أنطونيوس فكري',
        content: 'يقدم هذا الإصحاح حديث السيد المسيح مع نيقوديموس حول الولادة الجديدة.',
        summary: 'حديث الرب مع نيقوديموس',
      ),
    );

    await db.commentaryDao.insertCommentary(
      BibleCommentariesCompanion.insert(
        bookId: 43,
        chapter: 3,
        verseStart: const Value(16),
        verseEnd: const Value(16),
        source: 'تفسير القمص أنطونيوس فكري',
        author: 'القمص أنطونيوس فكري',
        content: 'هذه الآية تلخص جوهر الإنجيل كله. هكذا أحب الله العالم حتى بذل ابنه الوحيد.',
        summary: 'محبة الله الفائقة وبذله لابنه الوحيد',
      ),
    );
  });

  tearDown(() async {
    await DatabaseService.close();
  });

  group('BibleCommentary Model Tests', () {
    test('reference and level getters work properly', () {
      const chapterCommentary = model.BibleCommentary(
        id: 1,
        bookId: 43,
        chapter: 3,
        source: 'مصدر',
        author: 'مؤلف',
        text: 'نص',
        summary: 'ملخص',
      );

      expect(chapterCommentary.isChapterLevel, isTrue);
      expect(chapterCommentary.isVerseLevel, isFalse);
      expect(chapterCommentary.reference, '3');

      const verseCommentary = model.BibleCommentary(
        id: 2,
        bookId: 43,
        chapter: 3,
        verseStart: 16,
        source: 'مصدر',
        author: 'مؤلف',
        text: 'نص',
        summary: 'ملخص',
      );

      expect(verseCommentary.isChapterLevel, isFalse);
      expect(verseCommentary.isVerseLevel, isTrue);
      expect(verseCommentary.reference, '3:16');

      const rangeCommentary = model.BibleCommentary(
        id: 3,
        bookId: 43,
        chapter: 3,
        verseStart: 16,
        verseEnd: 18,
        source: 'مصدر',
        author: 'مؤلف',
        text: 'نص',
        summary: 'ملخص',
      );

      expect(rangeCommentary.reference, '3:16-18');
    });
  });

  group('CommentaryDao & Repository Tests', () {
    test('getChapterCommentary returns only chapter-level items', () async {
      final commentaries = await repository.getChapterCommentary(43, 3);
      expect(commentaries.length, equals(1));
      expect(commentaries.first.isChapterLevel, isTrue);
      expect(commentaries.first.summary, contains('نيقوديموس'));
      expect(commentaries.first.text, contains('الولادة الجديدة'));
    });

    test('getVerseCommentary returns matching verse commentary', () async {
      final commentaries = await repository.getVerseCommentary(43, 3, 16);
      expect(commentaries.length, equals(1));
      expect(commentaries.first.verseStart, equals(16));
      expect(commentaries.first.text, contains('هكذا أحب الله العالم'));

      // Non-existent verse should return empty
      final empty = await repository.getVerseCommentary(43, 3, 1);
      expect(empty.isEmpty, isTrue);
    });

    test('hasCommentary returns true when chapter commentary exists', () async {
      final exists = await repository.hasCommentary(43, 3);
      expect(exists, isTrue);

      final notExists = await repository.hasCommentary(43, 4);
      expect(notExists, isFalse);
    });

    test('getCommentaryCount returns correct count', () async {
      final count = await db.commentaryDao.getCommentaryCount();
      expect(count, equals(2));
    });
  });
}
