import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/coptic_calendar/coptic_date.dart';
import 'package:noor_app/core/coptic_calendar/rite_determiner.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:noor_app/data/models/coptic_day_info.dart';

void main() {
  group('Domain & Database Data Models Tests', () {
    test('BibleVerse displays tashkeel when available and falls back to plain text', () {
      const vWithTashkeel = BibleVerse(
        id: 1,
        bookId: 1,
        chapter: 1,
        verseNumber: 1,
        content: 'في البدء خلق الله السماوات والارض',
        textWithTashkeel: 'فِي الْبَدْءِ خَلَقَ اللهُ السَّمَاوَاتِ وَالأَرْضَ',
      );
      expect(vWithTashkeel.displayText, 'فِي الْبَدْءِ خَلَقَ اللهُ السَّمَاوَاتِ وَالأَرْضَ');
      expect(vWithTashkeel.reference, '1:1');
      expect(vWithTashkeel.text, 'في البدء خلق الله السماوات والارض');

      const vWithoutTashkeel = BibleVerse(
        id: 2,
        bookId: 1,
        chapter: 1,
        verseNumber: 2,
        content: 'وكانت الارض خربة وخالية',
      );
      expect(vWithoutTashkeel.displayText, 'وكانت الارض خربة وخالية');
      expect(vWithoutTashkeel.text, 'وكانت الارض خربة وخالية');
    });

    test('BibleBook categories and testaments are correctly identified', () {
      const genesis = BibleBook(
        id: 1,
        nameAr: 'التكوين',
        nameEn: 'Genesis',
        testament: 'old',
        testamentAr: 'العهد القديم',
        category: 'law',
        categoryAr: 'التوراة',
        bookOrder: 1,
        chapterCount: 50,
      );
      expect(genesis.isOldTestament, isTrue);
      expect(genesis.isNewTestament, isFalse);
      expect(genesis.isDeuterocanonical, isFalse);

      const matthew = BibleBook(
        id: 40,
        nameAr: 'متى',
        nameEn: 'Matthew',
        testament: 'new',
        testamentAr: 'العهد الجديد',
        category: 'gospels',
        categoryAr: 'الأناجيل',
        bookOrder: 40,
        chapterCount: 28,
      );
      expect(matthew.isNewTestament, isTrue);
      expect(matthew.isOldTestament, isFalse);

      const tobit = BibleBook(
        id: 70,
        nameAr: 'طوبيا',
        nameEn: 'Tobit',
        testament: 'deutero',
        testamentAr: 'الأسفار القانونية الثانية',
        category: 'historical',
        categoryAr: 'تاريخية',
        bookOrder: 70,
        chapterCount: 14,
      );
      expect(tobit.isDeuterocanonical, isTrue);
    });

    test('LiturgyPart clerical secrets and roles', () {
      const part = LiturgyPart(
        id: 1,
        sectionId: 'anaphora',
        partOrder: 1,
        role: 'priest',
        type: 'prayer',
        textAr: 'الرب مع جميعكم',
        textCoptic: 'O Kurios meta pantwn umwn',
        isSecret: false,
      );
      expect(part.isPriest, isTrue);
      expect(part.isDeacon, isFalse);
      expect(part.isPeople, isFalse);
      expect(part.isSecret, isFalse);
    });

    test('CopticDayInfo liturgical attributes', () {
      final now = DateTime.now();
      final dayInfo = CopticDayInfo(
        copticDate: CopticDate(year: 1743, month: 1, day: 1),
        gregorianDate: now,
        riteInfo: DayRiteInfo(
          copticDate: CopticDate(year: 1743, month: 1, day: 1),
          gregorianDate: now,
          rite: ChurchRite.festive,
          feastName: 'عيد النيروز',
          isMajorFeast: true,
          isFasting: false,
          riteNameAr: 'فرايحي',
        ),
      );
      expect(dayInfo.copticDate.day, 1);
      expect(dayInfo.riteInfo.isFasting, isFalse);
      expect(dayInfo.riteInfo.rite, ChurchRite.festive);
    });

    test('Bookmark database data class properties', () {
      final now = DateTime.now();
      final bm = Bookmark(
        id: 1,
        contentType: 'bible',
        contentId: '1_1_1',
        displayTitle: 'التكوين ١ : ١',
        note: 'آية بداية الخليقة',
        createdAt: now,
      );
      expect(bm.contentType, 'bible');
      expect(bm.displayTitle, 'التكوين ١ : ١');
      expect(bm.contentId, '1_1_1');
    });
  });
}
