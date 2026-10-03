import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/features/reading_plan/data/reading_plans_data.dart';
import 'package:noor_app/features/reading_plan/services/reading_plan_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Reading Plans (خطط قراءة الكتاب المقدس) Tests', () {
    test('contains 4 canonical reading plans', () {
      expect(ReadingPlansData.plans.length, 4);
      final ids = ReadingPlansData.plans.map((p) => p.id).toList();
      expect(ids, contains('plan_whole_bible_365'));
      expect(ids, contains('plan_new_testament_90'));
      expect(ids, contains('plan_psalms_30'));
      expect(ids, contains('plan_gospels_lent_45'));
    });

    test('verifies Psalms in 30 days plan covers all 151 psalms', () {
      final day1 = ReadingPlansData.getPsalmsPlanDay(1);
      expect(day1.readings.first.chapter, 1);
      expect(day1.readings.last.chapter, 5);

      final day30 = ReadingPlansData.getPsalmsPlanDay(30);
      expect(day30.readings.last.chapter, 151); // Psalm 151 included!
    });

    test('verifies Gospels in Great Lent (45 days) plan coverage', () {
      final day1 = ReadingPlansData.getGospelsPlanDay(1);
      expect(day1.readings.first.bookId, 47); // Matthew
      expect(day1.readings.first.chapter, 1);

      final day45 = ReadingPlansData.getGospelsPlanDay(45);
      expect(day45.readings.last.bookId, 50); // John
      expect(day45.readings.last.chapter, 21);
    });

    test('verifies Whole Bible in 365 days plan generation', () {
      for (int d = 1; d <= 365; d += 30) {
        final planDay = ReadingPlansData.getWholeBiblePlanDay(d);
        expect(planDay.readings.isNotEmpty, isTrue);
        expect(planDay.title.isNotEmpty, isTrue);
      }
    });

    test('ReadingPlanService manages completion and suggested day', () async {
      const planId = 'plan_psalms_30';
      expect(await ReadingPlanService.getProgress(planId), 0.0);
      expect(await ReadingPlanService.getSuggestedDay(planId), 1);

      // Complete Day 1
      await ReadingPlanService.toggleDayCompleted(planId, 1);
      expect(await ReadingPlanService.isDayCompleted(planId, 1), isTrue);
      expect(await ReadingPlanService.getSuggestedDay(planId), 2);
      expect(await ReadingPlanService.getProgress(planId), closeTo(1 / 30, 0.001));

      // Reset
      await ReadingPlanService.resetPlan(planId);
      expect(await ReadingPlanService.isDayCompleted(planId, 1), isFalse);
      expect(await ReadingPlanService.getProgress(planId), 0.0);
    });
  });
}
