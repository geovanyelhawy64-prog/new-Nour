import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/app/app.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/core/services/preferences_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'pref_font_size': 18.0,
      'pref_theme_mode': 'light',
    });
    await PreferencesService.init();

    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);
  });

  tearDown(() async {
    await DatabaseService.close();
  });

  testWidgets('NoorApp smoke test: loads home screen with liturgical cards and navigation', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Build NoorApp inside ProviderScope
    await tester.pumpWidget(
      const ProviderScope(
        child: NoorApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify App Header
    expect(find.text('Noor'), findsOneWidget);

    // Verify Bottom Navigation items exist
    expect(find.text('الرئيسية'), findsOneWidget);
    expect(find.text('الكتاب'), findsOneWidget);
    expect(find.text('الألحان'), findsOneWidget);
    expect(find.text('المزيد'), findsOneWidget);

    // Verify Today Screen Cards
    expect(find.text('الصلوات اليومية'), findsOneWidget);
    expect(find.text('قراءات اليوم'), findsOneWidget);
    expect(find.text('تذكارات اليوم (السنكسار)'), findsOneWidget);
  });

  testWidgets('NoorApp navigation test: switches to Bible, Hymns, and More tabs', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const ProviderScope(
        child: NoorApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Tap Bible tab in NavigationBar
    await tester.tap(find.text('الكتاب'));
    await tester.pumpAndSettle();

    // Verify Bible screen loaded
    expect(find.text('الكتاب المقدس'), findsWidgets);

    // Tap Hymns tab in NavigationBar
    await tester.tap(find.text('الألحان'));
    await tester.pumpAndSettle();

    // Verify Hymns screen loaded
    expect(find.textContaining('ألحان'), findsWidgets);

    // Tap More tab in NavigationBar
    await tester.tap(find.text('المزيد'));
    await tester.pumpAndSettle();

    // Verify more screen loaded
    expect(find.text('المجموعات الكنسية والمزيد'), findsOneWidget);
    expect(find.text('الصلوات والطقوس'), findsOneWidget);
  });

  testWidgets('NoorApp navigation test: navigates into Agpeya and Liturgy screens', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const ProviderScope(
        child: NoorApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Tap Prayers (الصلوات)
    await tester.tap(find.text('الصلوات').first);
    await tester.pumpAndSettle();

    // Verify Agpeya HomeScreen loaded
    expect(find.text('الصلوات (الأجبية المقدسة)'), findsOneWidget);
    expect(find.text('صلاة باكر'), findsOneWidget);

    // Tap Prime Hour (باكر)
    await tester.tap(find.text('صلاة باكر'));
    await tester.pumpAndSettle();

    // Verify HourReaderScreen loaded
    expect(find.text('صلاة باكر'), findsWidgets);
    expect(find.text('الدور: '), findsOneWidget);
    expect(find.text('الكاهن'), findsOneWidget);
  });
}
