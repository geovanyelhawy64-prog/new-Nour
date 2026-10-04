import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/coptic_calendar/easter_calculator.dart';

void main() {
  group('EasterCalculator Tests (2020 - 2030 Canonical Dates)', () {
    final expectedEasterDates = {
      2020: DateTime(2020, 4, 19),
      2021: DateTime(2021, 5, 2),
      2022: DateTime(2022, 4, 24),
      2023: DateTime(2023, 4, 16),
      2024: DateTime(2024, 5, 5),
      2025: DateTime(2025, 4, 20),
      2026: DateTime(2026, 4, 12),
      2027: DateTime(2027, 5, 2),
      2028: DateTime(2028, 4, 16),
      2029: DateTime(2029, 4, 8),
      2030: DateTime(2030, 4, 28),
    };

    test('Coptic Easter is calculated accurately from 2020 to 2030', () {
      expectedEasterDates.forEach((year, expectedDate) {
        final calculated = EasterCalculator.calculateEaster(year);
        expect(
          calculated,
          equals(expectedDate),
          reason: 'Easter date mismatch for year $year',
        );
      });
    });

    test('Movable feasts have correct day intervals and weekdays', () {
      for (final year in expectedEasterDates.keys) {
        final easter = EasterCalculator.calculateEaster(year);
        expect(easter.weekday, DateTime.sunday, reason: 'Easter must be Sunday');

        // Great Lent starts 55 days before Easter on a Monday
        final lentStart = EasterCalculator.greatLentStart(year);
        final lentDiff = DateTime.utc(easter.year, easter.month, easter.day)
            .difference(DateTime.utc(lentStart.year, lentStart.month, lentStart.day))
            .inDays;
        expect(lentDiff, 55);
        expect(lentStart.weekday, DateTime.monday, reason: 'Great Lent must start on Monday');

        // Palm Sunday is 7 days before Easter on a Sunday
        final palmSunday = EasterCalculator.palmSunday(year);
        final palmDiff = DateTime.utc(easter.year, easter.month, easter.day)
            .difference(DateTime.utc(palmSunday.year, palmSunday.month, palmSunday.day))
            .inDays;
        expect(palmDiff, 7);
        expect(palmSunday.weekday, DateTime.sunday, reason: 'Palm Sunday must be Sunday');

        // Ascension is 39 days after Easter on a Thursday (day 40 counting Easter as day 1)
        final ascension = EasterCalculator.ascensionDay(year);
        final ascensionDiff = DateTime.utc(ascension.year, ascension.month, ascension.day)
            .difference(DateTime.utc(easter.year, easter.month, easter.day))
            .inDays;
        expect(ascensionDiff, 39);
        expect(ascension.weekday, DateTime.thursday, reason: 'Ascension must be Thursday');

        // Pentecost is 49 days after Easter on a Sunday (day 50 counting Easter as day 1)
        final pentecost = EasterCalculator.pentecost(year);
        final pentecostDiff = DateTime.utc(pentecost.year, pentecost.month, pentecost.day)
            .difference(DateTime.utc(easter.year, easter.month, easter.day))
            .inDays;
        expect(pentecostDiff, 49);
        expect(pentecost.weekday, DateTime.sunday, reason: 'Pentecost must be Sunday');

        // Apostles Fast starts the Monday following Pentecost
        final apostlesStart = EasterCalculator.apostlesFastStart(year);
        expect(apostlesStart.weekday, DateTime.monday, reason: 'Apostles fast must start on Monday');
        final apostlesDiff = DateTime.utc(apostlesStart.year, apostlesStart.month, apostlesStart.day)
            .difference(DateTime.utc(pentecost.year, pentecost.month, pentecost.day))
            .inDays;
        expect(apostlesDiff, 1);
      }
    });

    test('Period detection helper methods work accurately for 2024', () {
      final easter2024 = DateTime(2024, 5, 5);
      final pentecost2024 = DateTime(2024, 6, 23);

      // In Pentecostal period
      expect(EasterCalculator.isInPentecostalPeriod(easter2024), isTrue);
      expect(EasterCalculator.isInPentecostalPeriod(DateTime(2024, 5, 20)), isTrue);
      expect(EasterCalculator.isInPentecostalPeriod(pentecost2024), isTrue);
      expect(EasterCalculator.isInPentecostalPeriod(DateTime(2024, 6, 24)), isFalse);

      // In Great Lent
      final lentStart2024 = DateTime(2024, 3, 11);
      expect(EasterCalculator.isInGreatLent(lentStart2024), isTrue);
      expect(EasterCalculator.isInGreatLent(DateTime(2024, 4, 15)), isTrue);
      expect(EasterCalculator.isInGreatLent(easter2024), isFalse);

      // In Pascha
      final palmSunday2024 = DateTime(2024, 4, 28);
      expect(EasterCalculator.isInPascha(palmSunday2024), isTrue);
      expect(EasterCalculator.isInPascha(DateTime(2024, 5, 3)), isTrue); // Good Friday
      expect(EasterCalculator.isInPascha(easter2024), isFalse);
    });
  });
}
