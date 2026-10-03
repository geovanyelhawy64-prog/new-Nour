import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/constants/category_names.dart';
import 'package:noor_app/core/theme/app_theme.dart';
import 'package:noor_app/core/widgets/app_bottom_nav.dart';
import 'package:noor_app/core/widgets/text_mode_switcher.dart';

void main() {
  group('AppTheme and Theme Helpers', () {
    test('Colors constants match specifications', () {
      expect(AppTheme.lightBg, const Color(0xFFFAF6F0));
      expect(AppTheme.lightText, const Color(0xFF2D2D2D));
      expect(AppTheme.lightGold, const Color(0xFFC49B3C));
      expect(AppTheme.darkBg, const Color(0xFF141821));
      expect(AppTheme.darkText, const Color(0xFFE8DFD0));
      expect(AppTheme.darkGold, const Color(0xFFD4A843));
    });

    testWidgets('Theme helpers resolve light and dark appropriately', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Theme(
            data: AppTheme.lightTheme,
            child: Builder(
              builder: (context) {
                expect(AppTheme.isDark(context), isFalse);
                expect(AppTheme.gold(context), AppTheme.lightGold);
                expect(AppTheme.bg(context), AppTheme.lightBg);
                expect(AppTheme.text(context), AppTheme.lightText);
                return const Placeholder();
              },
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Theme(
            data: AppTheme.darkTheme,
            child: Builder(
              builder: (context) {
                expect(AppTheme.isDark(context), isTrue);
                expect(AppTheme.gold(context), AppTheme.darkGold);
                expect(AppTheme.bg(context), AppTheme.darkBg);
                expect(AppTheme.text(context), AppTheme.darkText);
                return const Placeholder();
              },
            ),
          ),
        ),
      );
    });
  });

  group('CategoryNames', () {
    test('all 18 categories are defined and queryable', () {
      expect(CategoryNames.all.length, 18);
      expect(CategoryNames.getName('home'), 'الرئيسية');
      expect(CategoryNames.getName('agpeya'), 'الصلوات');
      expect(CategoryNames.getName('liturgy'), 'القداس');
      expect(CategoryNames.getName('katameros'), 'القراءات');
      expect(CategoryNames.getName('synaxarium'), 'التذكارات');
      expect(CategoryNames.getName('hymns'), 'الألحان');
      expect(CategoryNames.getName('nonexistent'), 'nonexistent');
    });
  });

  group('AppBottomNav Widget', () {
    testWidgets('renders all 4 tabs and responds to tap', (tester) async {
      int tappedIndex = -1;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: AppBottomNav(
              currentIndex: 0,
              onTap: (index) => tappedIndex = index,
            ),
          ),
        ),
      );

      expect(find.text('الرئيسية'), findsOneWidget);
      expect(find.text('المكتبة'), findsOneWidget);
      expect(find.text('البحث'), findsOneWidget);
      expect(find.text('المحفوظات'), findsOneWidget);

      await tester.tap(find.text('المكتبة'));
      expect(tappedIndex, 1);

      await tester.tap(find.text('المحفوظات'));
      expect(tappedIndex, 3);
    });
  });

  group('TextModeSwitcher Widget', () {
    testWidgets('renders mode selector popup button', (tester) async {
      TextDisplayMode? changedMode;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              actions: [
                TextModeSwitcher(
                  currentMode: TextDisplayMode.arabic,
                  onModeChanged: (mode) => changedMode = mode,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(PopupMenuButton<TextDisplayMode>), findsOneWidget);
      await tester.tap(find.byType(PopupMenuButton<TextDisplayMode>));
      await tester.pumpAndSettle();

      expect(find.text('عربي'), findsWidgets);
      expect(find.text('قبطي'), findsOneWidget);
      expect(find.text('قبطي معرب'), findsOneWidget);

      await tester.tap(find.text('قبطي'));
      await tester.pumpAndSettle();

      expect(changedMode, TextDisplayMode.coptic);
    });

    testWidgets('renders multilingual hymn viewer content', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TextModeSwitcher(
              arabicText: 'المجد للآب',
              copticText: 'Doja Patri',
              phoneticText: 'دوكسا باتري',
              showHymnLayout: true,
              currentMode: TextDisplayMode.all,
            ),
          ),
        ),
      );

      expect(find.text('المجد للآب'), findsOneWidget);
      expect(find.text('Doja Patri'), findsOneWidget);
      expect(find.text('دوكسا باتري'), findsOneWidget);
    });
  });
}
