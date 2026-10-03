import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/core/services/preferences_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart' as drift;
import 'package:noor_app/features/prayers/presentation/prayers_home_screen.dart';
import 'package:noor_app/features/prayers/presentation/prayer_reader_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await PreferencesService.init();
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);

    // Insert sample occasional prayers
    await db.into(db.occasionalPrayers).insert(
          const OccasionalPrayersCompanion(
            id: drift.Value('communion_before'),
            category: drift.Value('communion'),
            categoryAr: drift.Value('صلوات التناول المقدس'),
            title: drift.Value('صَلَاةٌ قَبْلَ التَّنَاوُلِ'),
            content: drift.Value('يَا رَبُّ إِنِّي غَيْرُ مُسْتَحِقٍّ أَنْ تَدْخُلَ تَحْتَ سَقْفِ بَيْتِي...'),
            prayerOrder: drift.Value(1),
          ),
        );

    await db.into(db.occasionalPrayers).insert(
          const OccasionalPrayersCompanion(
            id: drift.Value('study_exam'),
            category: drift.Value('study'),
            categoryAr: drift.Value('صلوات الطلبة والدارسين'),
            title: drift.Value('صَلَاةٌ قَبْلَ دُخُولِ الاِمْتِحَانِ'),
            content: drift.Value('يَا إِلَهِي الْقَدِيرَ، إِلَيْكَ أَلْجَأُ فِي هَذِهِ السَّاعَةِ...'),
            prayerOrder: drift.Value(2),
          ),
        );
  });

  tearDownAll(() async {
    await DatabaseService.close();
  });

  testWidgets('PrayersHomeScreen displays categories and supports live search', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: PrayersHomeScreen(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify categories rendered
    expect(find.text('صلوات المناسبات والطلبات'), findsOneWidget);
    expect(find.text('صلوات الحياة اليومية'), findsOneWidget);
    expect(find.text('صلوات التوبة والانسحاق'), findsOneWidget);
    expect(find.text('صلوات الحماية والتحصين'), findsOneWidget);
    expect(find.text('صلوات التناول المقدس'), findsOneWidget);

    // Enter search query
    await tester.enterText(find.byType(TextField), 'الامتحان');
    await tester.pumpAndSettle();

    // Verify search result
    expect(find.text('صَلَاةٌ قَبْلَ دُخُولِ الاِمْتِحَانِ'), findsOneWidget);

    // Clear search query
    await tester.tap(find.byIcon(Icons.clear_rounded));
    await tester.pumpAndSettle();

    // Verify categories back
    expect(find.text('صلوات التناول المقدس'), findsOneWidget);
  });

  testWidgets('PrayerReaderScreen displays category prayers, font zoom, and copy action', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: PrayerReaderScreen(categoryId: 'communion'),
      ),
    );

    await tester.pumpAndSettle();

    // Verify title and prayer card
    expect(find.text('صلوات التناول المقدس'), findsOneWidget);
    expect(find.text('صَلَاةٌ قَبْلَ التَّنَاوُلِ'), findsOneWidget);
    expect(find.textContaining('يَا رَبُّ إِنِّي غَيْرُ مُسْتَحِقٍّ'), findsOneWidget);

    // Check zoom buttons
    expect(find.byIcon(Icons.text_increase_rounded), findsOneWidget);
    expect(find.byIcon(Icons.text_decrease_rounded), findsOneWidget);

    // Tap copy button
    await tester.tap(find.byIcon(Icons.copy_rounded));
    await tester.pumpAndSettle();

    expect(find.text('تم نسخ الصلاة إلى الحافظة'), findsOneWidget);
  });
}
