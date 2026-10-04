import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:noor_app/data/repositories/cross_reference_repository.dart';

void main() {
  late AppDatabase db;
  late CrossReferenceRepository repository;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);
    repository = CrossReferenceRepository();

    // Insert Bible Books
    await db.into(db.bibleBooks).insert(
          BibleBooksCompanion.insert(
            id: const Value(43),
            nameAr: 'إنجيل يوحنا',
            nameEn: 'John',
            testament: 'new',
            testamentAr: 'العهد الجديد',
            category: 'gospels',
            categoryAr: 'الأناجيل',
            bookOrder: 43,
            chapterCount: 21,
          ),
        );

    await db.into(db.bibleBooks).insert(
          BibleBooksCompanion.insert(
            id: const Value(45),
            nameAr: 'رسالة رومية',
            nameEn: 'Romans',
            testament: 'new',
            testamentAr: 'العهد الجديد',
            category: 'pauline',
            categoryAr: 'رسائل بولس',
            bookOrder: 45,
            chapterCount: 16,
          ),
        );

    // Insert Verses
    await db.into(db.bibleVerses).insert(
          BibleVersesCompanion.insert(
            bookId: 43,
            chapter: 3,
            verseNumber: 16,
            content: 'لأَنَّهُ هكَذَا أَحَبَّ اللهُ الْعَالَمَ حَتَّى بَذَلَ ابْنَهُ الْوَحِيدَ...',
          ),
        );

    await db.into(db.bibleVerses).insert(
          BibleVersesCompanion.insert(
            bookId: 45,
            chapter: 5,
            verseNumber: 8,
            content: 'وَلكِنَّ اللهَ بَيَّنَ مَحَبَّتَهُ لَنَا، لأَنَّهُ وَنَحْنُ بَعْدُ خُطَاةٌ مَاتَ الْمَسِيحُ لأَجْلِنَا.',
          ),
        );

    // Insert Cross Reference
    await db.into(db.bibleCrossReferences).insert(
          BibleCrossReferencesCompanion.insert(
            sourceBookId: 43,
            sourceChapter: 3,
            sourceVerse: 16,
            targetBookId: 45,
            targetChapter: 5,
            targetVerse: 8,
            relationType: const Value('love'),
          ),
        );
  });

  tearDown(() async {
    await DatabaseService.close();
  });

  group('CrossReferenceDao & Repository Tests', () {
    test('getCrossReferences returns matching target verses with book names', () async {
      final refs = await repository.getCrossReferences(43, 3, 16);
      expect(refs.length, 1);

      final first = refs.first;
      expect(first.bookId, 45);
      expect(first.chapter, 5);
      expect(first.verse, 8);
      expect(first.bookName, 'رسالة رومية');
      expect(first.text, contains('وَنَحْنُ بَعْدُ خُطَاةٌ'));
    });

    test('hasCrossReferences returns true when links exist', () async {
      final hasRefs = await repository.hasCrossReferences(43, 3, 16);
      expect(hasRefs, isTrue);

      final noRefs = await repository.hasCrossReferences(43, 3, 1);
      expect(noRefs, isFalse);
    });
  });
}
