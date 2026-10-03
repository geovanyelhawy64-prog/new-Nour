import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/core/services/preferences_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:noor_app/features/bookmarks/presentation/bookmarks_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await PreferencesService.init();
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);

    // Insert test bookmarks
    await DatabaseService.userData.addBookmark(
      contentType: 'bible',
      contentId: '1/1',
      displayTitle: 'التكوين ١: ١',
      note: 'آية جميلة',
    );

    await DatabaseService.userData.addBookmark(
      contentType: 'agpeya',
      contentId: 'prime',
      displayTitle: 'صلاة باكر - مزمور ٥٠',
    );
  });

  tearDownAll(() async {
    await DatabaseService.close();
  });

  testWidgets('BookmarksScreen renders saved bookmarks, filters and supports delete', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: BookmarksScreen(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('المحفوظات والمفضلة'), findsOneWidget);
    expect(find.text('التكوين ١: ١'), findsOneWidget);
    expect(find.text('آية جميلة'), findsOneWidget);
    expect(find.text('صلاة باكر - مزمور ٥٠'), findsOneWidget);

    // Filter by 'الكتاب المقدس'
    await tester.tap(find.text('الكتاب المقدس'));
    await tester.pumpAndSettle();

    expect(find.text('التكوين ١: ١'), findsOneWidget);
    expect(find.text('صلاة باكر - مزمور ٥٠'), findsNothing);

    // Filter back to 'الكل'
    await tester.tap(find.text('الكل'));
    await tester.pumpAndSettle();
    expect(find.text('صلاة باكر - مزمور ٥٠'), findsOneWidget);

    // Test export button
    await tester.tap(find.byIcon(Icons.upload_file_rounded));
    await tester.pumpAndSettle();
    expect(find.textContaining('تم نسخ النسخة الاحتياطية'), findsOneWidget);

    // Delete one item
    final deleteButtons = find.byIcon(Icons.delete_outline_rounded);
    await tester.tap(deleteButtons.first);
    await tester.pumpAndSettle();
  });
}
