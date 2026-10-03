import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/core/services/preferences_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:noor_app/features/pascha/presentation/pascha_reader_screen.dart';
import 'package:noor_app/features/pascha/presentation/pascha_home_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await PreferencesService.init();
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);

    // Insert sample Pascha readings for Monday Day, Hour 1
    await db.into(db.paschaReadings).insert(
          PaschaReadingsCompanion.insert(
            dayId: 'monday_day',
            dayNameAr: 'يوم الإثنين',
            hourNumber: 1,
            hourNameAr: 'باكر',
            readingType: 'prophecy',
            content: 'وَحَدَثَ فِي تِلْكَ الأَيَّامِ أَنَّ مُوسَى لَمَّا كَبِرَ خَرَجَ إِلَى إِخْوَتِهِ...',
            readingOrder: 1,
          ),
        );

    await db.into(db.paschaReadings).insert(
          PaschaReadingsCompanion.insert(
            dayId: 'monday_day',
            dayNameAr: 'يوم الإثنين',
            hourNumber: 1,
            hourNameAr: 'باكر',
            readingType: 'hymn',
            content: 'لك القوة والمجد والبركة والعزة إلى الأبد آمين عمانوئيل إلهنا وملكنا.',
            readingOrder: 2,
          ),
        );

    await db.into(db.paschaReadings).insert(
          PaschaReadingsCompanion.insert(
            dayId: 'monday_day',
            dayNameAr: 'يوم الإثنين',
            hourNumber: 1,
            hourNameAr: 'باكر',
            readingType: 'gospel',
            content: 'وَفِي الصَّبَاحِ إِذْ كَانَ رَاجِعاً إِلَى الْمَدِينَةِ جَاعَ...',
            readingOrder: 3,
          ),
        );

    await db.into(db.katamerosReadings).insert(
          KatamerosReadingsCompanion.insert(
            copticMonth: 0,
            copticDay: 50,
            periodType: 'great_lent',
            rite: 'lenten',
            serviceType: 'liturgy',
            readingType: 'gospel',
            reference: 'يوحنا 11: 1-45',
            content: 'وكان واحد مريض وهو لعازر من بيت عنيا...',
          ),
        );
  });

  tearDownAll(() async {
    await DatabaseService.close();
  });

  testWidgets('PaschaHomeScreen renders list of Holy Week days', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: PaschaHomeScreen(),
      ),
    );

    expect(find.text('أسبوع الآلام (البصخة المقدسة)'), findsOneWidget);
    expect(find.text('إثنين البصخة'), findsOneWidget);
    expect(find.text('الجمعة العظيمة'), findsOneWidget);
    expect(find.text('خميس العهد'), findsOneWidget);
  });

  testWidgets('PaschaReaderScreen displays readings, hour chips, and interactive Thok counter', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: PaschaReaderScreen(dayId: 'monday'),
      ),
    );

    await tester.pumpAndSettle();

    // Check title and hour chips
    expect(find.text('يوم الإثنين من البصخة المقدسة'), findsOneWidget);
    expect(find.text('باكر'), findsWidgets);
    expect(find.text('الثالثة'), findsOneWidget);
    expect(find.text('السادسة'), findsOneWidget);
    expect(find.text('التاسعة'), findsOneWidget);
    expect(find.text('الحادية عشر'), findsOneWidget);

    // Check loaded readings
    expect(find.text('النبوات المقدسة'), findsOneWidget);
    expect(find.text('الإنجيل المقدس العربي'), findsOneWidget);

    // Check Thok recitation counter widget
    expect(find.text('عداد الترتيل (١٢ مرة):'), findsOneWidget);
    expect(find.text('0 / 12'), findsOneWidget);

    // Tap to increment Thok recitation
    await tester.tap(find.byIcon(Icons.add_circle_outline_rounded));
    await tester.pumpAndSettle();
    expect(find.text('1 / 12'), findsOneWidget);

    // Font zoom controls
    expect(find.byIcon(Icons.text_increase_rounded), findsOneWidget);
    expect(find.byIcon(Icons.text_decrease_rounded), findsOneWidget);

    // Day/Night switch button
    expect(find.byIcon(Icons.dark_mode_rounded), findsOneWidget);
  });

  testWidgets('PaschaReaderScreen displays Katameros readings and service chips for Lazarus Saturday', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: PaschaReaderScreen(dayId: 'lazarus'),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('سبت لعازر الصديق'), findsOneWidget);
    expect(find.text('الكل'), findsOneWidget);
    expect(find.text('باكر'), findsOneWidget);
    expect(find.text('القداس الإلهي'), findsWidgets);
    expect(find.text('وكان واحد مريض وهو لعازر من بيت عنيا...'), findsOneWidget);
  });

  testWidgets('PaschaReaderScreen displays Revelation reading banner for Joyous Saturday', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: PaschaReaderScreen(dayId: 'bright_saturday'),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('سبت الفرح (أبو غلمسيس)'), findsOneWidget);
    expect(find.text('سفر الرؤيا كاملاً (أبو غلمسيس)'), findsOneWidget);
  });
}
