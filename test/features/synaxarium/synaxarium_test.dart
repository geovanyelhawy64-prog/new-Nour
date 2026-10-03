import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/core/services/preferences_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:noor_app/features/synaxarium/presentation/synaxarium_home_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await PreferencesService.init();
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);

    // Insert test synaxarium entry
    await db.into(db.synaxariumEntries).insert(
          SynaxariumEntriesCompanion.insert(
            id: 'synax_01_01_01',
            copticMonth: 1,
            copticDay: 1,
            entryOrder: 1,
            title: 'عيد النيروز رأس السنة القبطية',
            type: 'feast',
            shortText: 'في هذا اليوم تعيد الكنيسة برأس السنة القبطية',
            fullText: 'في هذا اليوم المبارك تعيد الكنيسة برأس السنة القبطية وتكريم الشهداء الأطهار...',
          ),
        );
  });

  tearDownAll(() async {
    await DatabaseService.close();
  });

  testWidgets('SynaxariumHomeScreen renders navigation and entries', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SynaxariumHomeScreen(),
      ),
    );

    await tester.pumpAndSettle();

    // Check AppBar title
    expect(find.text('التذكارات (السنكسار القبطي)'), findsOneWidget);

    // Check actions: search, today, calendar
    expect(find.byIcon(Icons.search_rounded), findsOneWidget);
    expect(find.byIcon(Icons.today_rounded), findsOneWidget);
    expect(find.byIcon(Icons.calendar_month_rounded), findsOneWidget);

    // Tap search icon to toggle search bar
    await tester.tap(find.byIcon(Icons.search_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
  });
}
