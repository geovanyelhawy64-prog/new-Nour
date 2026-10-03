import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/core/services/preferences_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart' as drift;
import 'package:noor_app/features/feasts/presentation/feasts_home_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await PreferencesService.init();
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);

    // Insert sample major feast
    await db.into(db.feastsAndFasts).insert(
          const FeastsAndFastsCompanion(
            id: drift.Value('nativity'),
            nameAr: drift.Value('عِيدُ الْمِيلَادِ الْمَجِيدُ'),
            type: drift.Value('major_feast'),
            copticMonth: drift.Value(4),
            copticDay: drift.Value(29),
            isMovable: drift.Value(false),
            rite: drift.Value('festive'),
            description: drift.Value('ميلاد ربنا يسوع المسيح بالجسد في ملء الزمان'),
            durationDays: drift.Value(1),
          ),
        );

    // Insert sample minor feast
    await db.into(db.feastsAndFasts).insert(
          const FeastsAndFastsCompanion(
            id: drift.Value('circumcision'),
            nameAr: drift.Value('عِيدُ الْخِتَانِ الْمَجِيدُ'),
            type: drift.Value('minor_feast'),
            copticMonth: drift.Value(5),
            copticDay: drift.Value(6),
            isMovable: drift.Value(false),
            rite: drift.Value('festive'),
            description: drift.Value('ختان الطفل يسوع في اليوم الثامن'),
            durationDays: drift.Value(1),
          ),
        );

    // Insert sample fast
    await db.into(db.feastsAndFasts).insert(
          const FeastsAndFastsCompanion(
            id: drift.Value('great_lent'),
            nameAr: drift.Value('الصَّوْمُ الْكَبِيرُ'),
            type: drift.Value('fast'),
            isMovable: drift.Value(true),
            calculationRule: drift.Value('easter - 55'),
            rite: drift.Value('lenten'),
            description: drift.Value('أقدس أصوام السنة الكنسية ٥٥ يوماً من النسك والصلوات'),
            durationDays: drift.Value(55),
          ),
        );
  });

  tearDownAll(() async {
    await DatabaseService.close();
  });

  testWidgets('FeastsHomeScreen renders tabs and feast cards, opens details bottom sheet', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: FeastsHomeScreen(),
      ),
    );

    await tester.pumpAndSettle();

    // Check TabBar headers
    expect(find.text('الأعياد السيدية'), findsOneWidget);
    expect(find.text('أصوام الكنيسة'), findsOneWidget);
    expect(find.text('أعياد القديسين'), findsOneWidget);

    // Check Lord's Feasts Tab
    expect(find.text('عِيدُ الْمِيلَادِ الْمَجِيدُ'), findsOneWidget);
    expect(find.text('عِيدُ الْخِتَانِ الْمَجِيدُ'), findsOneWidget);

    // Tap on Nativity Feast to open details bottom sheet
    await tester.tap(find.text('عِيدُ الْمِيلَادِ الْمَجِيدُ'));
    await tester.pumpAndSettle();

    // Verify bottom sheet content
    expect(find.text('ميلاد ربنا يسوع المسيح بالجسد في ملء الزمان'), findsOneWidget);
    expect(find.text('المدة: 1 يوم'), findsOneWidget);

    // Dismiss bottom sheet
    await tester.tapAt(const Offset(20, 20));
    await tester.pumpAndSettle();

    // Switch to Fasts tab
    await tester.tap(find.text('أصوام الكنيسة'));
    await tester.pumpAndSettle();

    // Verify fasts content
    expect(find.text('الصَّوْمُ الْكَبِيرُ'), findsOneWidget);
    expect(find.text('درجة أولى'), findsOneWidget);
  });
}
