import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/core/services/preferences_service.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:noor_app/features/prayers/presentation/feelings_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await PreferencesService.init();
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);

    // Insert mock feeling prayers for testing
    for (final cat in ['feeling_anxiety', 'feeling_sadness', 'feeling_joy', 'feeling_repentance', 'feeling_sickness']) {
      await db.into(db.occasionalPrayers).insert(
            OccasionalPrayersCompanion.insert(
              id: '${cat}_1',
              category: cat,
              categoryAr: 'مشاعر',
              title: 'صلاة اختبارية لـ $cat',
              content: 'أيها الرب الصالح المعزي املأ قلبي بسلامك الفائق لكل عقل.',
              prayerOrder: 1,
            ),
          );
    }
  });

  tearDownAll(() async {
    await DatabaseService.close();
  });

  testWidgets('FeelingsScreen renders 5 feelings and switches between them', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: FeelingsScreen(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify AppBar
    expect(find.text('صلاة حسب المشاعر'), findsOneWidget);

    // Verify 5 feelings are rendered
    expect(find.text('قلق'), findsOneWidget);
    expect(find.text('حزن'), findsOneWidget);
    expect(find.text('فرح'), findsOneWidget);
    expect(find.text('توبة'), findsOneWidget);
    expect(find.text('مرض'), findsOneWidget);

    // Verify initial feeling (قلق) prayer content loaded
    expect(find.text('صلاة اختبارية لـ feeling_anxiety'), findsOneWidget);
    expect(find.text('نسخ'), findsOneWidget);
    expect(find.text('مشاركة'), findsOneWidget);

    // Switch to 'حزن'
    await tester.tap(find.text('حزن'));
    await tester.pumpAndSettle();

    expect(find.text('صلاة اختبارية لـ feeling_sadness'), findsOneWidget);

    // Switch to 'فرح'
    await tester.tap(find.text('فرح'));
    await tester.pumpAndSettle();

    expect(find.text('صلاة اختبارية لـ feeling_joy'), findsOneWidget);
  });
}
