import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/coptic_calendar/easter_calculator.dart';

void main() {
  group('100-Year Easter & Movable Feasts Stress Test (2000 - 2100)', () {
    test('Easter is deterministically an ecclesiastical Sunday within valid Gregorian window for 100 years', () {
      for (int year = 2000; year <= 2100; year++) {
        final easter = EasterCalculator.calculateEaster(year);

        // 1. عيد القيامة يقع حتماً يوم أحد
        expect(
          easter.weekday,
          DateTime.sunday,
          reason: 'Easter in $year must fall on a Sunday but was ${easter.weekday}',
        );

        // 2. يقع عيد القيامة الشرقي الأرثوذكسي دائماً بين 4 أبريل و 8 مايو في القرنين العشرين والحادي والعشرين
        final earliest = DateTime(year, 4, 4);
        final latest = DateTime(year, 5, 8);
        expect(
          easter.isBefore(earliest),
          isFalse,
          reason: 'Easter in $year ($easter) was earlier than April 4',
        );
        expect(
          easter.isAfter(latest),
          isFalse,
          reason: 'Easter in $year ($easter) was later than May 8',
        );

        int daysDiff(DateTime a, DateTime b) =>
            DateTime.utc(b.year, b.month, b.day).difference(DateTime.utc(a.year, a.month, a.day)).inDays;

        // 3. الصوم الكبير يبدأ يوم إثنين قبل القيامة بـ 55 يوماً
        final greatLent = EasterCalculator.greatLentStart(year);
        expect(greatLent.weekday, DateTime.monday);
        expect(daysDiff(greatLent, easter), 55);

        // 4. أحد الشعانين قبل القيامة بـ 7 أيام
        final palmSunday = EasterCalculator.palmSunday(year);
        expect(palmSunday.weekday, DateTime.sunday);
        expect(daysDiff(palmSunday, easter), 7);

        // 5. الصعود يوم خميس بعد القيامة بـ 39 يوماً
        final ascension = EasterCalculator.ascensionDay(year);
        expect(ascension.weekday, DateTime.thursday);
        expect(daysDiff(easter, ascension), 39);

        // 6. العنصرة يوم أحد بعد القيامة بـ 49 يوماً
        final pentecost = EasterCalculator.pentecost(year);
        expect(pentecost.weekday, DateTime.sunday);
        expect(daysDiff(easter, pentecost), 49);

        // 7. صوم الرسل يبدأ يوم إثنين بعد العنصرة مباشرة
        final apostlesStart = EasterCalculator.apostlesFastStart(year);
        expect(apostlesStart.weekday, DateTime.monday);
        expect(daysDiff(pentecost, apostlesStart), 1);
      }
    });
  });
}
