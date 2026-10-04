import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/coptic_calendar/coptic_date.dart';
import 'package:noor_app/core/coptic_calendar/coptic_month.dart';

void main() {
  group('CopticDate Conversion and Arithmetic Tests', () {
    test('13 Coptic Months are correctly identified', () {
      expect(CopticDate.monthNames.length, 13);
      expect(CopticDate.monthNames[0], 'توت');
      expect(CopticDate.monthNames[12], 'النسيء');
      expect(CopticMonth.values.length, 13);
    });

    test('Leap year detection works correctly', () {
      expect(CopticDate.isLeapYear(1739), isTrue);
      expect(CopticDate.isLeapYear(1740), isFalse);
      expect(CopticDate.isLeapYear(1741), isFalse);
      expect(CopticDate.isLeapYear(1742), isFalse);
      expect(CopticDate.isLeapYear(1743), isTrue);
      expect(CopticDate.epagomenalDays(1739), 6);
      expect(CopticDate.epagomenalDays(1740), 5);
    });

    test('Bidirectional round-trip: Gregorian -> Coptic -> Gregorian (365 consecutive days)', () {
      final start = DateTime(2024, 1, 1);
      for (int i = 0; i < 365; i++) {
        final date = start.add(Duration(days: i));
        final coptic = CopticDate.fromGregorian(date);
        final roundTrip = coptic.toGregorian();

        expect(
          roundTrip.year == date.year &&
              roundTrip.month == date.month &&
              roundTrip.day == date.day,
          isTrue,
          reason: 'Failed on $date -> Coptic: $coptic -> back: $roundTrip',
        );
      }
    });

    test('Bidirectional round-trip across century transition (1995 to 2035 sample)', () {
      for (int year = 1995; year <= 2035; year++) {
        final dates = [
          DateTime(year, 1, 1),
          DateTime(year, 1, 7),
          DateTime(year, 3, 21),
          DateTime(year, 9, 11),
          DateTime(year, 9, 12),
          DateTime(year, 12, 31),
        ];

        for (final date in dates) {
          final coptic = CopticDate.fromGregorian(date);
          final roundTrip = coptic.toGregorian();
          expect(
            roundTrip.year == date.year &&
                roundTrip.month == date.month &&
                roundTrip.day == date.day,
            isTrue,
            reason: 'Failed on $date -> Coptic: $coptic -> back: $roundTrip',
          );
        }
      }
    });

    test('nextDay and previousDay consistency', () {
      final coptic = const CopticDate(year: 1740, month: 1, day: 30);
      final next = coptic.nextDay();
      expect(next.month, 2);
      expect(next.day, 1);
      expect(next.previousDay(), coptic);
    });

    test('Year rollover at end of Nasie', () {
      // 1740 is a common year (5 Nasie days)
      final lastDay1740 = const CopticDate(year: 1740, month: 13, day: 5);
      final newYear1741 = lastDay1740.nextDay();
      expect(newYear1741.year, 1741);
      expect(newYear1741.month, 1);
      expect(newYear1741.day, 1);
      expect(newYear1741.previousDay(), lastDay1740);
    });

    test('Formatted outputs', () {
      const coptic = CopticDate(year: 1740, month: 4, day: 29);
      expect(coptic.formatted, '29 كيهك 1740');
      expect(coptic.monthNameCoptic, 'Ⲭⲟⲓⲁⲕ');
    });
  });
}
