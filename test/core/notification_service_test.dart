import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/services/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz_data;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    tz_data.initializeTimeZones();
  });

  group('NotificationService Unit Tests', () {
    test('NotificationService calculates next scheduled time correctly', () {
      final now = DateTime.now();
      // If we schedule for an hour in the future today
      final futureHour = (now.hour + 2) % 24;
      final scheduled = NotificationService.nextScheduledTime(futureHour, 0);

      expect(scheduled.hour, futureHour);
      expect(scheduled.minute, 0);
      expect(scheduled.isAfter(DateTime.now().subtract(const Duration(minutes: 1))), isTrue);
    });

    test('NotificationService initializes safely in test environment', () async {
      await NotificationService.init();
      expect(NotificationService.isInitialized, isTrue);
    });
  });
}
