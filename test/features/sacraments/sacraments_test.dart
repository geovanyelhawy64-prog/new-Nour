import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/core/services/preferences_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart' as drift;
import 'package:noor_app/features/sacraments/presentation/sacraments_home_screen.dart';
import 'package:noor_app/features/sacraments/presentation/sacrament_detail_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await PreferencesService.init();
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);

    // Insert test sacrament
    await db.into(db.sacraments).insert(
          const SacramentsCompanion(
            id: drift.Value('baptism'),
            nameAr: drift.Value('سِرُّ الْمَعْمُودِيَّةِ الْمُقَدَّسُ'),
            sacramentOrder: drift.Value(1),
          ),
        );

    // Insert test sections
    await db.into(db.sacramentSections).insert(
          const SacramentSectionsCompanion(
            sacramentId: drift.Value('baptism'),
            title: drift.Value('التَّعْرِيفُ وَالْمَعْنَى اللّاهُوتِيُّ'),
            content: drift.Value('سِرُّ الْمَعْمُودِيَّةِ هُوَ بَابُ الأَسْرَارِ وَالْوِلَادَةُ الثَّانِيَةُ مِنَ الْمَاءِ وَالرُّوحِ.'),
            scriptures: drift.Value('يُوحَنَّا ٣: ٥؛ رُومِيَةَ ٦: ٤'),
            sectionOrder: drift.Value(1),
          ),
        );
  });

  tearDownAll(() async {
    await DatabaseService.close();
  });

  testWidgets('SacramentsHomeScreen renders list of seven holy sacraments', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: SacramentsHomeScreen(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('الأسرار الكنسية السبعة'), findsOneWidget);
    expect(find.text('سر المعمودية المقدس'), findsOneWidget);
    expect(find.text('سر الميرون المقدس'), findsOneWidget);
    expect(find.text('سر التوبة والاعتراف'), findsOneWidget);
    expect(find.text('سر الإفخارستيا (التناول)'), findsOneWidget);
    expect(find.text('سر مسحة المرضى (القنديل)'), findsOneWidget);
    expect(find.text('سر الزيجة المقدس (الإكليل)'), findsOneWidget);
    expect(find.text('سر الكهنوت المقدس'), findsOneWidget);
  });

  testWidgets('SacramentDetailScreen displays canonical sections, scriptures, and copy action', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: SacramentDetailScreen(sacramentId: 'baptism'),
      ),
    );

    await tester.pumpAndSettle();

    // Verify title and section content
    expect(find.text('سر المعمودية المقدس'), findsOneWidget);
    expect(find.text('التَّعْرِيفُ وَالْمَعْنَى اللّاهُوتِيُّ'), findsOneWidget);
    expect(find.text('يُوحَنَّا ٣: ٥؛ رُومِيَةَ ٦: ٤'), findsOneWidget);
    expect(find.textContaining('بَابُ الأَسْرَارِ وَالْوِلَادَةُ الثَّانِيَةُ'), findsOneWidget);

    // Font controls
    expect(find.byIcon(Icons.text_increase_rounded), findsOneWidget);
    expect(find.byIcon(Icons.text_decrease_rounded), findsOneWidget);

    // Copy action
    await tester.tap(find.byIcon(Icons.copy_rounded));
    await tester.pumpAndSettle();

    expect(find.text('تم نسخ النص إلى الحافظة'), findsOneWidget);
  });
}
