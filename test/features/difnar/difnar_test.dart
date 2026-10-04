import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/core/coptic_calendar/coptic_calendar_engine.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/core/services/preferences_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart' as drift;
import 'package:noor_app/features/difnar/presentation/difnar_home_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await PreferencesService.init();
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);

    final today = CopticCalendarEngine.getLiturgicalDayInfo(DateTime.now()).copticDate;

    // Insert test difnar entry for today
    await db.into(db.difnarEntries).insert(
          DifnarEntriesCompanion(
            id: const drift.Value('difnar_today_01'),
            copticMonth: drift.Value(today.month),
            copticDay: drift.Value(today.day),
            textCoptic: const drift.Value('Ⲡⲓⲁⲅⲓⲟⲥ Ⲅⲉⲱⲣⲅⲓⲟⲥ'),
            textPhonetic: const drift.Value('بي أجيوس جيؤرجيوس'),
            textAr: const drift.Value('الشهيد العظيم مارجرجس\n\nطرح واطس يرتل في عيده المبارك'),
          ),
        );
  });

  tearDownAll(() async {
    await DatabaseService.close();
  });

  testWidgets('DifnarHomeScreen renders coptic date, tone, and difnar entries', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: DifnarHomeScreen(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('كتاب الدفنار والمدائح'), findsOneWidget);
    expect(find.text('كتاب الدفنار الطقسي'), findsOneWidget);
    expect(find.text('Ⲡⲓⲁⲅⲓⲟⲥ Ⲅⲉⲱⲣⲅⲓⲟⲥ'), findsOneWidget);
    expect(find.text('بي أجيوس جيؤرجيوس'), findsOneWidget);
    expect(find.textContaining('الشهيد العظيم مارجرجس'), findsOneWidget);

    // Test font controls
    await tester.tap(find.byIcon(Icons.text_increase_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.text_decrease_rounded));
    await tester.pumpAndSettle();

    // Test copy
    await tester.tap(find.byIcon(Icons.copy_rounded));
    await tester.pumpAndSettle();
    expect(find.text('تم نسخ مديح الدفنار إلى الحافظة'), findsOneWidget);

    // Test next day navigation
    await tester.tap(find.byIcon(Icons.chevron_left_rounded));
    await tester.pumpAndSettle();
  });
}
