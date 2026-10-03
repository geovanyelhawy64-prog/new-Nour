import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/coptic_calendar/coptic_date.dart';
import 'package:noor_app/core/coptic_calendar/rite_determiner.dart';

void main() {
  group('RiteDeterminer Comprehensive Liturgical Tests', () {
    test('Easter 2024 is Festive Major Feast', () {
      final easter2024 = DateTime(2024, 5, 5);
      final rite = RiteDeterminer.determineRite(easter2024);

      expect(rite.rite, ChurchRite.festive);
      expect(rite.isMajorFeast, isTrue);
      expect(rite.isFasting, isFalse);
      expect(rite.feastName, contains('عيد القيامة'));
    });

    test('Holy 50 Days (الخمسين المقدسة) has Joyous Rite and No Fasting on Wed/Fri', () {
      // Wednesday during Holy 50 days (e.g. May 15, 2024)
      final wednesdayIn50 = DateTime(2024, 5, 15);
      expect(wednesdayIn50.weekday, DateTime.wednesday);

      final rite = RiteDeterminer.determineRite(wednesdayIn50);
      expect(rite.rite, ChurchRite.joyous);
      expect(rite.isFasting, isFalse, reason: 'No fasting permitted during Holy 50 days');
    });

    test('Ascension and Pentecost in 2024 are Festive Major Feasts without Fasting', () {
      final ascension2024 = DateTime(2024, 6, 13);
      final ascensionRite = RiteDeterminer.determineRite(ascension2024);
      expect(ascensionRite.rite, ChurchRite.festive);
      expect(ascensionRite.isMajorFeast, isTrue);
      expect(ascensionRite.isFasting, isFalse);

      final pentecost2024 = DateTime(2024, 6, 23);
      final pentecostRite = RiteDeterminer.determineRite(pentecost2024);
      expect(pentecostRite.rite, ChurchRite.festive);
      expect(pentecostRite.isMajorFeast, isTrue);
      expect(pentecostRite.isFasting, isFalse);
    });

    test('Great Lent days are Lenten Rite and Fasting', () {
      final lentDay = DateTime(2024, 3, 20); // Wednesday during Lent
      final rite = RiteDeterminer.determineRite(lentDay);

      expect(rite.rite, ChurchRite.lenten);
      expect(rite.isFasting, isTrue);
      expect(rite.fastName, contains('الصوم الكبير'));
    });

    test('Palm Sunday is Major Dominical Feast with Shaanini Festive Rite', () {
      final palmSunday2024 = DateTime(2024, 4, 28);
      final rite = RiteDeterminer.determineRite(palmSunday2024);

      expect(rite.rite, ChurchRite.festive);
      expect(rite.isMajorFeast, isTrue);
      expect(rite.feastName, contains('أحد الشعانين'));
      expect(rite.riteNameAr, contains('شعانيني'));
    });

    test('Covenant Thursday is Minor Dominical Feast inside Pascha', () {
      final covenantThursday2024 = DateTime(2024, 5, 2);
      final rite = RiteDeterminer.determineRite(covenantThursday2024);

      expect(rite.isMinorFeast, isTrue);
      expect(rite.feastName, contains('خميس العهد'));
    });

    test('Pascha week (أسبوع الآلام) is Pascha Rite', () {
      final goodFriday2024 = DateTime(2024, 5, 3);
      final rite = RiteDeterminer.determineRite(goodFriday2024);

      expect(rite.rite, ChurchRite.pascha);
      expect(rite.isFasting, isTrue);
      expect(rite.fastName, contains('أسبوع الآلام'));
    });

    test('Fixed Fast: St. Mary Fast (1-15 Mesra)', () {
      // In Coptic Date: 1 Mesra
      final copticMesra1 = const CopticDate(year: 1740, month: 12, day: 1);
      final gregorian = copticMesra1.toGregorian();

      final rite = RiteDeterminer.determineRite(gregorian);
      expect(rite.isFasting, isTrue);
      expect(rite.fastName, contains('صوم السيدة العذراء'));
    });

    test('Fixed Feast: St. Mary Ascension of Body (16 Mesra)', () {
      final copticMesra16 = const CopticDate(year: 1740, month: 12, day: 16);
      final gregorian = copticMesra16.toGregorian();

      final rite = RiteDeterminer.determineRite(gregorian);
      expect(rite.rite, ChurchRite.festive);
      expect(rite.isFasting, isFalse);
      expect(rite.feastName, contains('صعود جسد السيدة العذراء'));
    });

    test('Standard Wednesday and Friday in Annual period are Fasting', () {
      // Find an ordinary Wednesday outside fasts and 50 days (e.g. October 9, 2024)
      final wednesday = DateTime(2024, 10, 9);
      expect(wednesday.weekday, DateTime.wednesday);

      final rite = RiteDeterminer.determineRite(wednesday);
      expect(rite.isFasting, isTrue);
      expect(rite.fastName, 'صوم الأربعاء');
      expect(rite.rite, ChurchRite.annual);
    });

    test('Standard Tuesday in Annual period is Annual non-fasting', () {
      final tuesday = DateTime(2024, 10, 8);
      expect(tuesday.weekday, DateTime.tuesday);

      final rite = RiteDeterminer.determineRite(tuesday);
      expect(rite.isFasting, isFalse);
      expect(rite.rite, ChurchRite.annual);
      expect(rite.riteNameAr, 'سنوي');
    });
  });
}
