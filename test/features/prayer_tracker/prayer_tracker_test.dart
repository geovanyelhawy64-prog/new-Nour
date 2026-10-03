import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/features/prayer_tracker/services/prayer_tracker_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('PrayerTrackerService (سجل الصلاة اليومي) Tests', () {
    test('canonical hours contain exactly 7 Agpeya hours', () {
      final hours = PrayerTrackerService.canonicalHours;
      expect(hours.length, 7);
      expect(hours.map((h) => h.id).toList(), [
        'prime',
        'terce',
        'sext',
        'none',
        'vespers',
        'compline',
        'midnight',
      ]);
    });

    test('toggles prayer completion and persists correctly', () async {
      final today = DateTime.now();
      expect(await PrayerTrackerService.isPrayerCompleted(today, 'prime'), isFalse);

      final result1 = await PrayerTrackerService.togglePrayer(today, 'prime');
      expect(result1, isTrue);
      expect(await PrayerTrackerService.isPrayerCompleted(today, 'prime'), isTrue);

      final completedList = await PrayerTrackerService.getCompletedPrayersForDate(today);
      expect(completedList, contains('prime'));

      final result2 = await PrayerTrackerService.togglePrayer(today, 'prime');
      expect(result2, isFalse);
      expect(await PrayerTrackerService.isPrayerCompleted(today, 'prime'), isFalse);
    });

    test('calculates prayer streaks consecutively', () async {
      final now = DateTime.now();
      // Initially 0
      expect(await PrayerTrackerService.calculateStreak(), 0);

      // Prayed today
      await PrayerTrackerService.togglePrayer(now, 'prime');
      expect(await PrayerTrackerService.calculateStreak(), 1);

      // Prayed yesterday
      final yesterday = now.subtract(const Duration(days: 1));
      await PrayerTrackerService.togglePrayer(yesterday, 'compline');
      expect(await PrayerTrackerService.calculateStreak(), 2);

      // Prayed 2 days ago
      final twoDaysAgo = now.subtract(const Duration(days: 2));
      await PrayerTrackerService.togglePrayer(twoDaysAgo, 'midnight');
      expect(await PrayerTrackerService.calculateStreak(), 3);
    });

    test('retrieves 7 days weekly stats correctly', () async {
      final weekly = await PrayerTrackerService.getWeeklyStats();
      expect(weekly.length, 7);
    });
  });
}
