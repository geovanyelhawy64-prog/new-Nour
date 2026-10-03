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
    expect(find.text('نور'), findsWidgets);

    // Verify Bottom Navigation items exist
    expect(find.text('الرئيسية'), findsOneWidget);
    expect(find.text('المكتبة'), findsOneWidget);
    expect(find.text('البحث'), findsOneWidget);
    expect(find.text('المحفوظات'), findsOneWidget);

    // Verify Today Screen Cards
    expect(find.text('صلاة هذه الساعة'), findsOneWidget);
    expect(find.text('قراءات اليوم'), findsOneWidget);
    expect(find.text('سنكسار اليوم'), findsOneWidget);
  });

  testWidgets('NoorApp navigation uses Home, Library, Search, and Bookmarks', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: NoorApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('المكتبة'));
    await tester.pumpAndSettle();
    expect(find.text('الصلوات والطقوس'), findsOneWidget);
    expect(find.text('الكلمة'), findsOneWidget);

    await tester.tap(find.text('البحث'));
    await tester.pumpAndSettle();
    expect(find.text('البحث'), findsWidgets);

    await tester.tap(find.text('المحفوظات'));
    await tester.pumpAndSettle();
    expect(find.text('المحفوظات والمفضلة'), findsOneWidget);
  });

  testWidgets('Library prayer portal opens the Agpeya', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: NoorApp()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('المكتبة'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('الصلوات والطقوس'));
    await tester.pumpAndSettle();
    expect(find.text('الأجبية'), findsOneWidget);
  });

}
