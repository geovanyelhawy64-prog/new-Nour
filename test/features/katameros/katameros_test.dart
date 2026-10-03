import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/core/services/preferences_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:noor_app/features/katameros/presentation/katameros_reader_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await PreferencesService.init();
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);

    // Insert test Katameros reading
    await db.into(db.katamerosReadings).insert(
          KatamerosReadingsCompanion.insert(
            copticMonth: 1,
            copticDay: 1,
            periodType: 'annual',
            rite: 'festive',
            serviceType: 'liturgy',
            readingType: 'pauline',
            reference: '٢ كو ٥ : ١١ ــ ٦ : ١٣',
            content: 'وَإذْ نَحْنُ عَارِفُونَ مَخَافَةَ الرَّبِّ صِرْنَا نُقْنِعُ النَّاسِ...',
          ),
        );
  });

  tearDownAll(() async {
    await DatabaseService.close();
  });

  testWidgets('KatamerosReaderScreen renders service filter chips and readings', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: KatamerosReaderScreen(sectionId: 'today'),
      ),
    );

    await tester.pumpAndSettle();

    // Check filter chips
    expect(find.text('الكل'), findsOneWidget);
    expect(find.text('القداس الإلهي'), findsOneWidget);
    expect(find.text('باكر'), findsOneWidget);
    expect(find.text('عشية'), findsOneWidget);

    // Tap on القداس الإلهي chip
    await tester.tap(find.text('القداس الإلهي'));
    await tester.pumpAndSettle();

    // Check actions (font zoom)
    expect(find.byIcon(Icons.text_increase_rounded), findsOneWidget);
    expect(find.byIcon(Icons.text_decrease_rounded), findsOneWidget);
  });
}
