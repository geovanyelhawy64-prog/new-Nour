import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/core/services/database_service.dart';
import 'package:noor_app/core/services/preferences_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart' as drift;
import 'package:noor_app/features/theology/presentation/theology_home_screen.dart';
import 'package:noor_app/features/theology/presentation/theology_topic_screen.dart';
import 'package:noor_app/features/theology/presentation/theology_article_reader_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await PreferencesService.init();
    db = AppDatabase(NativeDatabase.memory());
    await DatabaseService.init(db);

    // Insert test theology articles
    await db.into(db.theologyArticles).insert(
          const TheologyArticlesCompanion(
            id: drift.Value('theology_christ_nature_01'),
            category: drift.Value('nature_of_christ'),
            categoryAr: drift.Value('طبيعة السيد المسيح'),
            title: drift.Value('عقيدة الطبيعة الواحدة المتجسدة لله الكلمة'),
            content: drift.Value('تؤمن الكنيسة القبطية الأرثوذكسية بالطبيعة الواحدة المتجسدة لله الكلمة بغير اختلاط ولا امتزاج ولا تغيير.'),
            articleOrder: drift.Value(1),
          ),
        );

    await db.into(db.theologyArticles).insert(
          const TheologyArticlesCompanion(
            id: drift.Value('theology_salvation_01'),
            category: drift.Value('salvation'),
            categoryAr: drift.Value('مفهوم الخلاص والجهاد'),
            title: drift.Value('عقيدة الخلاص في المفهوم الأرثوذكسي'),
            content: drift.Value('الخلاص يقوم على الفداء المجاني بدم المسيح والإيمان الحي العامل بالمحبة والجهاد.'),
            articleOrder: drift.Value(1),
          ),
        );
  });

  tearDownAll(() async {
    await DatabaseService.close();
  });

  testWidgets('TheologyHomeScreen renders topics and supports live search', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: TheologyHomeScreen(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('العقيدة واللاهوت الأرثوذكسي'), findsOneWidget);
    expect(find.text('عقيدة الثالوث القدوس'), findsOneWidget);
    expect(find.text('طبيعة السيد المسيح'), findsOneWidget);
    expect(find.text('الفداء: الصليب والقيامة'), findsOneWidget);
    expect(find.text('الكنيسة: طبيعتها ورسالتها'), findsOneWidget);
    expect(find.text('الأسرار الكنسية: شرح لاهوتي'), findsOneWidget);
    expect(find.text('العذراء مريم: والدة الإله'), findsOneWidget);
    expect(find.text('عالم الملائكة والأجناد السماوية'), findsOneWidget);
    expect(find.text('مفهوم الخلاص والجهاد'), findsOneWidget);
    expect(find.text('المجامع المسكونية وقانون الإيمان'), findsOneWidget);
    expect(find.text('الهرطقات والردود العقائدية'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    // Live search
    await tester.enterText(find.byType(TextField), 'المتجسدة');
    await tester.pumpAndSettle();

    expect(find.text('عقيدة الطبيعة الواحدة المتجسدة لله الكلمة'), findsOneWidget);
  });

  testWidgets('TheologyTopicScreen renders articles list for topic', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: TheologyTopicScreen(topicId: 'nature_of_christ'),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('طبيعة السيد المسيح'), findsOneWidget);
    expect(find.text('عقيدة الطبيعة الواحدة المتجسدة لله الكلمة'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('TheologyArticleReaderScreen renders article details and controls', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: TheologyArticleReaderScreen(articleId: 'theology_christ_nature_01'),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('عقيدة الطبيعة الواحدة المتجسدة لله الكلمة'), findsOneWidget);
    expect(find.text('طبيعة السيد المسيح'), findsNWidgets(2)); // AppBar and Chip
    expect(find.textContaining('بغير اختلاط ولا امتزاج ولا تغيير'), findsOneWidget);

    // Test font controls
    await tester.tap(find.byIcon(Icons.text_increase_rounded));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.text_decrease_rounded));
    await tester.pumpAndSettle();

    // Test copy
    await tester.tap(find.byIcon(Icons.copy_rounded));
    await tester.pumpAndSettle();
    expect(find.text('تم نسخ المقال إلى الحافظة'), findsOneWidget);
  });
}
