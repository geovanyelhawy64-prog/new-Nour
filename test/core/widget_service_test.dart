import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/services/widget_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WidgetService Tests', () {
    const channel = MethodChannel('com.noor.noor_app/widget');
    final log = <MethodCall>[];

    setUp(() {
      log.clear();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        log.add(methodCall);
        if (methodCall.method == 'updateWidget') {
          return true;
        }
        return null;
      });
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test('updateHomeScreenWidget handles non-Android or missing DB gracefully', () async {
      // In flutter test runner without SQLite initialized, WidgetService should catch errors and return boolean
      final result = await WidgetService.updateHomeScreenWidget();
      // Should not throw an uncaught exception
      expect(result, isA<bool>());
    });
  });
}
