import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/core/services/preferences_service.dart';
import 'package:noor_app/features/settings/presentation/settings_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await PreferencesService.init();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('dexterous.com/flutter/local_notifications'),
      (MethodCall methodCall) async => null,
    );
  });

  testWidgets('SettingsScreen renders themes, font slider, switches, and credits', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SettingsScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('الإعدادات'), findsOneWidget);
    expect(find.text('١. القراءة'), findsOneWidget);
    expect(find.text('٢. المظهر'), findsOneWidget);
    expect(find.text('٣. التذكيرات'), findsOneWidget);
    expect(find.text('٤. المحتوى واللغة'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();

    expect(find.text('٥. بيانات وعن التطبيق'), findsOneWidget);
    expect(find.textContaining('Geovany Elhawy'), findsOneWidget);

    // Test slider interaction
    final slider = find.byType(Slider);
    expect(slider, findsOneWidget);

    // Test switches (simple mode, prayer reminders, daily verse, tashkeel, coptic, haptic)
    final switches = find.byType(Switch);
    expect(switches, findsNWidgets(6));

    final prayerSwitch = find.widgetWithText(SwitchListTile, 'تنبيهات صلوات الأجبية');
    await tester.tap(prayerSwitch);
    await tester.pumpAndSettle();

    // Verify Notification Button and Time Pickers
    expect(find.text('تفعيل الإشعارات'), findsOneWidget);
    expect(find.text('ساعة تذكير الصلوات'), findsOneWidget);
    expect(find.text('ساعة آية اليوم'), findsOneWidget);
  });

  testWidgets('Notification button handles granted permission correctly', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    // Mock Permission Handler channel
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('flutter.baseflow.com/permissions/methods'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'checkPermissionStatus') {
          return 1; // Granted
        }
        if (methodCall.method == 'requestPermissions') {
          return {17: 1}; // Notification permission granted
        }
        return null;
      },
    );

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SettingsScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final button = find.byKey(const Key('enable_notifications_button'));
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.text('تم تفعيل الإشعارات بنجاح'), findsOneWidget);
  });

  testWidgets('Notification button handles denied permission correctly', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    // Mock Permission Handler channel as denied
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('flutter.baseflow.com/permissions/methods'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'checkPermissionStatus') {
          return 0; // Denied
        }
        if (methodCall.method == 'requestPermissions') {
          return {17: 0}; // Notification permission denied
        }
        return null;
      },
    );

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SettingsScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final button = find.byKey(const Key('enable_notifications_button'));
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.text('الإشعارات معطلة'), findsOneWidget);
  });
}
