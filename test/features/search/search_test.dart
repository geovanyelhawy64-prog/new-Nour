import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/core/services/preferences_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noor_app/features/search/presentation/search_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await PreferencesService.init();
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);

    // Insert book
    final bookId = await db.into(db.bibleBooks).insert(
          BibleBooksCompanion.insert(
            nameAr: 'التكوين',
            nameEn: 'Genesis',
            testament: 'old',
            testamentAr: 'العهد القديم',
            category: 'law',
            categoryAr: 'التوراة',
            bookOrder: 1,
            chapterCount: 50,
          ),
        );

    // Insert verse
    await db.into(db.bibleVerses).insert(
          BibleVersesCompanion.insert(
            bookId: bookId,
            chapter: 1,
            verseNumber: 1,
            content: 'في البدء خلق الله السماوات والارض',
          ),
        );

    // Insert saint
    await db.into(db.saints).insert(
          const SaintsCompanion(
            id: drift.Value('saint_george'),
            nameAr: drift.Value('الشهيد مارجرجس'),
            type: drift.Value('martyrs'),
            biography: drift.Value('سيرة الشهيد مارجرجس الروماني'),
            shortBio: drift.Value('أمير الشهداء'),
          ),
        );
  });

  tearDownAll(() async {
    await DatabaseService.close();
  });

  testWidgets('SearchScreen performs global search and filtering', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SearchScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('البحث الشامل'), findsOneWidget);
    expect(find.text('الكل'), findsOneWidget);
    expect(find.text('الكتاب المقدس'), findsOneWidget);

    // Search for "السماوات"
    await tester.enterText(find.byType(TextField), 'السماوات');
    await tester.pumpAndSettle();

    expect(find.text('التكوين 1:1'), findsOneWidget);
    expect(find.text('الكتاب المقدس'), findsNWidgets(2)); // Filter chip + Card chip

    // Search for saint
    await tester.enterText(find.byType(TextField), 'مارجرجس');
    await tester.pumpAndSettle();

    expect(find.text('الشهيد مارجرجس'), findsOneWidget);
    expect(find.text('القديسين'), findsNWidgets(2)); // Filter chip + Card chip
  });
}
