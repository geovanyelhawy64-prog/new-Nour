import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:noor_app/data/repositories/bible_repository.dart';
import 'package:noor_app/data/repositories/agpeya_repository.dart';
import 'package:noor_app/data/repositories/bookmarks_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);
  });

  tearDown(() async {
    await DatabaseService.close();
  });

  group('Clean Repositories Layer Unit Tests', () {
    test('BibleRepository retrieves books and chapter verses', () async {
      final repo = BibleRepository();

      // Insert test book
      final bookId = await db.into(db.bibleBooks).insert(
            BibleBooksCompanion.insert(
              nameAr: 'التكوين',
              nameEn: 'Genesis',
              testament: 'old',
              testamentAr: 'العهد القديم',
              category: 'law',
              categoryAr: 'التوراة',
              bookOrder: 1,
              chapterCount: 50,
            ),
          );

      await db.into(db.bibleVerses).insert(
            BibleVersesCompanion.insert(
              bookId: bookId,
              chapter: 1,
              verseNumber: 1,
              content: 'في البدء خلق الله السماوات والارض',
            ),
          );

      final oldBooks = await repo.getBooksByTestament('old');
      expect(oldBooks.length, 1);
      expect(oldBooks.first.nameAr, 'التكوين');

      final verses = await repo.getChapterVerses(bookId, 1);
      expect(verses.length, 1);
      expect(verses.first.text, contains('في البدء'));

      final searchResults = await repo.search('السماوات');
      expect(searchResults.length, 1);
    });

    test('AgpeyaRepository retrieves hours and sections', () async {
      final repo = AgpeyaRepository();

      await db.into(db.agpeyaHours).insert(
            AgpeyaHoursCompanion.insert(
              id: 'prime',
              nameAr: 'صلاة باكر',
              nameEn: 'Prime',
              hourOrder: 1,
              description: const Value('القيامة والنور'),
            ),
          );

      await db.into(db.agpeyaSections).insert(
            AgpeyaSectionsCompanion.insert(
              hourId: 'prime',
              sectionOrder: 1,
              type: 'prayer',
              title: 'صلاة الشكر',
              role: 'priest',
              textAr: 'فلنشكر صانع الخيرات...',
            ),
          );

      final hours = await repo.getAllHours();
      expect(hours.length, 1);
      expect(hours.first.nameAr, 'صلاة باكر');

      final sections = await repo.getHourSections('prime');
      expect(sections.length, 1);
      expect(sections.first.title, 'صلاة الشكر');
    });

    test('BookmarksRepository creates and lists bookmarks', () async {
      final repo = BookmarksRepository();

      await repo.add(
        contentType: 'bible',
        contentId: '1_1_1',
        displayTitle: 'التكوين ١ : ١',
        note: 'آية الخليقة',
      );

      final all = await repo.getAll();
      expect(all.length, 1);
      expect(all.first.displayTitle, 'التكوين ١ : ١');

      final isSaved = await repo.isBookmarked('bible', '1_1_1');
      expect(isSaved, isTrue);

      await repo.remove(all.first.id);
      final remaining = await repo.getAll();
      expect(remaining.isEmpty, isTrue);
    });
  });
}
