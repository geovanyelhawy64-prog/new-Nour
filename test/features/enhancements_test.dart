import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/app/theme/app_theme.dart';
import 'package:noor_app/widgets/common/adaptive_master_detail.dart';
import 'package:noor_app/widgets/common/auto_scroll_control.dart';
import 'package:noor_app/widgets/common/highlighted_text.dart';

void main() {
  group('V2.0 Enhancements Tests', () {
    test('AppTheme creates sepia and amoled ThemeData correctly', () {
      final sepiaTheme = AppTheme.sepia();
      expect(sepiaTheme.brightness, Brightness.light);
      expect(sepiaTheme.scaffoldBackgroundColor, isNotNull);

      final amoledTheme = AppTheme.amoled();
      expect(amoledTheme.brightness, Brightness.dark);
      expect(amoledTheme.scaffoldBackgroundColor, Colors.black);
    });

    testWidgets('HighlightedText highlights query keywords in rich text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HighlightedText(
              text: 'في البدء خلق الله السماوات والارض',
              query: 'السماوات',
            ),
          ),
        ),
      );

      expect(find.byType(HighlightedText), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('AutoScrollControl renders play button and speed controls', (tester) async {
      final scrollController = ScrollController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AutoScrollControl(
              scrollController: scrollController,
            ),
          ),
        ),
      );

      expect(find.byType(AutoScrollControl), findsOneWidget);
      expect(find.byIcon(Icons.play_circle_fill_rounded), findsOneWidget);
      expect(find.text('بطيء'), findsOneWidget);
      expect(find.text('متوسط'), findsOneWidget);
      expect(find.text('سريع'), findsOneWidget);

      // Tap play
      await tester.tap(find.byIcon(Icons.play_circle_fill_rounded));
      await tester.pump();

      expect(find.byIcon(Icons.pause_circle_filled_rounded), findsOneWidget);
    });

    testWidgets('AdaptiveMasterDetail renders single pane on mobile and two panes on tablet', (tester) async {
      // Mobile screen width
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AdaptiveMasterDetail(
              breakpoint: 720,
              master: Text('Master View'),
              detail: Text('Detail View'),
            ),
          ),
        ),
      );

      expect(find.text('Master View'), findsOneWidget);
      expect(find.text('Detail View'), findsNothing);

      // Tablet screen width
      tester.view.physicalSize = const Size(1000, 800);
      await tester.pump();

      expect(find.text('Master View'), findsOneWidget);
      expect(find.text('Detail View'), findsOneWidget);
    });
  });
}
