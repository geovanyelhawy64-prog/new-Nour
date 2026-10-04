import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/core/services/preferences_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart' as drift;
import 'package:noor_app/features/saints/presentation/saints_home_screen.dart';
import 'package:noor_app/features/saints/presentation/saint_category_screen.dart';
import 'package:noor_app/features/saints/presentation/saint_reader_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await PreferencesService.init();
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);

    // Insert test saints
    await db.into(db.saints).insert(
          const SaintsCompanion(
            id: drift.Value('saint_george'),
            nameAr: drift.Value('الشهيد العظيم مارجرجس الروماني'),
            nameCoptic: drift.Value('Ⲡⲓⲁⲅⲓⲟⲥ Ⲅⲉⲱⲣⲅⲓⲟⲥ'),
            nameEn: drift.Value('Saint George'),
            type: drift.Value('martyrs'),
            feastMonth: drift.Value(8),
            feastDay: drift.Value(23),
            biography: drift.Value('أمير الشهداء القديس جاورجيوس الروماني استشهد في عهد دقلديانوس.'),
            shortBio: drift.Value('أمير الشهداء وكوكب الصبح المنير'),
          ),
        );

    await db.into(db.saints).insert(
          const SaintsCompanion(
            id: drift.Value('saint_anthony'),
            nameAr: drift.Value('القديس العظيم أنبا أنطونيوس كوكب البرية'),
            nameCoptic: drift.Value('Ⲁⲃⲃⲁ Ⲁⲛⲧⲱⲛⲓ'),
            nameEn: drift.Value('Saint Anthony'),
            type: drift.Value('monks'),
            feastMonth: drift.Value(5),
            feastDay: drift.Value(22),
            biography: drift.Value('أبو الرهبان ومؤسس الرهبنة في العالم كله.'),
            shortBio: drift.Value('أبو الرهبان في العالم'),
          ),
        );
  });

  tearDownAll(() async {
    await DatabaseService.close();
  });

  testWidgets('SaintsHomeScreen renders categories and search field', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: SaintsHomeScreen(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('سير القديسين والشهداء'), findsOneWidget);
    expect(find.text('الشهداء الأبرار'), findsOneWidget);
    expect(find.text('آباء الرهبنة والنساك'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    // Live search
    await tester.enterText(find.byType(TextField), 'مارجرجس');
    await tester.pumpAndSettle();

    expect(find.text('الشهيد العظيم مارجرجس الروماني'), findsOneWidget);
  });

  testWidgets('SaintCategoryScreen lists saints for category and filters', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: SaintCategoryScreen(categoryId: 'martyrs'),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('الشهداء الأبرار'), findsOneWidget);
    expect(find.text('الشهيد العظيم مارجرجس الروماني'), findsOneWidget);
    expect(find.text('التذكار: 23 برمودة'), findsOneWidget);
  });

  testWidgets('SaintReaderScreen renders biography, coptic text and controls', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: SaintReaderScreen(saintId: 'saint_george'),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('الشهيد العظيم مارجرجس الروماني'), findsNWidgets(2)); // AppBar and title card
    expect(find.text('Ⲡⲓⲁⲅⲓⲟⲥ Ⲅⲉⲱⲣⲅⲓⲟⲥ'), findsOneWidget);
    expect(find.text('التذكار: 23 برمودة'), findsOneWidget);
    expect(find.textContaining('أمير الشهداء القديس جاورجيوس'), findsOneWidget);

    // Test font size buttons
    await tester.tap(find.byIcon(Icons.text_increase_rounded));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.text_decrease_rounded));
    await tester.pumpAndSettle();

    // Test copy button
    await tester.tap(find.byIcon(Icons.copy_rounded));
    await tester.pumpAndSettle();
    expect(find.text('تم نسخ سيرة القديس إلى الحافظة'), findsOneWidget);
  });
}
