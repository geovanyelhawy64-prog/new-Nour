import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/coptic_calendar/coptic_date.dart';
import 'package:noor_app/core/coptic_calendar/easter_calculator.dart';

void main() {
  group('حالات تحقق تقويمية معلومة', () {
    test('23 توت 1743 يوافق 3 أكتوبر 2026', () {
      final coptic = CopticDate.fromGregorian(DateTime(2026, 10, 3));
      expect(coptic, const CopticDate(year: 1743, month: 1, day: 23));
      expect(coptic.toGregorian(), DateTime(2026, 10, 3));
    });

    test('رأس السنة القبطية يتعامل مع انتقال القرن 2100', () {
      expect(
        CopticDate.fromGregorian(DateTime(2099, 9, 11)),
        const CopticDate(year: 1815, month: 13, day: 6),
      );
      expect(
        CopticDate.fromGregorian(DateTime(2100, 9, 11)),
        const CopticDate(year: 1816, month: 13, day: 5),
      );
      expect(
        CopticDate.fromGregorian(DateTime(2100, 9, 12)),
        const CopticDate(year: 1817, month: 1, day: 1),
      );
    });

    test('التحويل العكسي ثابت عند حدود كل سنة من 1900 إلى 2200', () {
      for (var year = 1900; year <= 2200; year++) {
        for (final date in [
          DateTime(year, 1, 1),
          DateTime(year, 2, 28),
          DateTime(year, 3, 1),
          DateTime(year, 9, 10),
          DateTime(year, 9, 11),
          DateTime(year, 9, 12),
          DateTime(year, 12, 31),
        ]) {
          expect(CopticDate.fromGregorian(date).toGregorian(), date);
        }
      }
    });

    test('سنوات النسيء تتناوب بخمسة وستة أيام دون تاريخ مستحيل', () {
      for (var year = 1600; year <= 1900; year++) {
        final expected = CopticDate.isLeapYear(year) ? 6 : 5;
        expect(CopticDate.epagomenalDays(year), expected);
        final last = CopticDate(year: year, month: 13, day: expected);
        expect(last.nextDay(), CopticDate(year: year + 1, month: 1, day: 1));
      }
    });
  });

  group('حساب القيامة والأيام المشتقة', () {
    test('يعالج تغير الفرق اليولياني بعد سنة 2100', () {
      expect(EasterCalculator.calculateEaster(2099), DateTime(2099, 4, 12));
      expect(EasterCalculator.calculateEaster(2100), DateTime(2100, 5, 2));
      expect(EasterCalculator.calculateEaster(2101), DateTime(2101, 4, 24));
    });

    test('الصعود والعنصرة مشتقان بفواصل ثابتة عبر 500 سنة', () {
      for (var year = 1900; year <= 2400; year++) {
        final easter = EasterCalculator.calculateEaster(year);
        final ascension = EasterCalculator.ascensionDay(year);
        final pentecost = EasterCalculator.pentecost(year);
        expect(_daysBetween(easter, ascension), 39);
        expect(_daysBetween(easter, pentecost), 49);
        expect(easter.weekday, DateTime.sunday);
        expect(ascension.weekday, DateTime.thursday);
        expect(pentecost.weekday, DateTime.sunday);
      }
    });

    test('يرفض السنوات خارج مجال الخوارزمية المعلن', () {
      expect(() => EasterCalculator.calculateEaster(325), throwsRangeError);
      expect(() => EasterCalculator.calculateEaster(10000), throwsRangeError);
    });
  });
}

int _daysBetween(DateTime start, DateTime end) => DateTime.utc(
      end.year,
      end.month,
      end.day,
    ).difference(DateTime.utc(start.year, start.month, start.day)).inDays;
