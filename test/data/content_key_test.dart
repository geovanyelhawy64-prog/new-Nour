import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/data/database/content_key.dart';

void main() {
  group('ContentKey', () {
    test('يبني مفتاح الإصحاح من المرجع لا من رقم صف', () {
      expect(
        ContentKey.bibleChapter(bookId: 43, chapter: 3),
        'chapter:43:3',
      );
    });

    test('يبني مفتاح الآية من السفر والإصحاح والآية', () {
      expect(
        ContentKey.bibleVerse(bookId: 43, chapter: 3, verse: 16),
        'verse:43:3:16',
      );
    });

    test('يحول صيغ الإصدارات القديمة مع الشرطتين', () {
      expect(
        ContentKey.canonicalizeBookmark('bible', '43/3'),
        'chapter:43:3',
      );
      expect(
        ContentKey.canonicalizeBookmark('bible', '43_3_16'),
        'verse:43:3:16',
      );
    });

    test('لا يغير المعرف النصي الثابت للأقسام الأخرى', () {
      expect(
        ContentKey.canonicalizeBookmark('agpeya', 'prime'),
        'prime',
      );
      expect(
        ContentKey.canonicalizeBookmark('liturgy', 'basil'),
        'basil',
      );
    });

    test('يفك المفتاح الثابت إلى مرجع', () {
      final reference = ContentKey.tryParseBible('verse:43:3:16');
      expect(reference, isNotNull);
      expect(reference!.bookId, 43);
      expect(reference.chapter, 3);
      expect(reference.verse, 16);
      expect(reference.canonical, 'verse:43:3:16');
    });

    test('يرفض الأرقام غير الموجبة عند إنشاء مفتاح جديد', () {
      expect(
        () => ContentKey.bibleChapter(bookId: 0, chapter: 1),
        throwsArgumentError,
      );
    });
  });
}
