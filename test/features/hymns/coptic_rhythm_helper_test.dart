import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/features/hymns/presentation/widgets/coptic_rhythm_helper.dart';

void main() {
  testWidgets('CopticRhythmHelperDialog renders beat indicators, bpm presets, and manual pads',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => CopticRhythmHelperDialog.show(context),
              child: const Text('افتح الدف'),
            ),
          ),
        ),
      ),
    );

    // Open bottom sheet
    await tester.tap(find.text('افتح الدف'));
    await tester.pumpAndSettle();

    // Verify title and rhythm indicators
    expect(find.text('محاكي الدف والمثلث الكنسي'), findsOneWidget);
    expect(find.text('دُم'), findsOneWidget);
    expect(find.text('تَك'), findsNWidgets(3));

    // Verify presets
    expect(find.text('حزايني (٦٠)'), findsOneWidget);
    expect(find.text('سنوي (٩٠)'), findsOneWidget);
    expect(find.text('دمج (١٣٠)'), findsOneWidget);

    // Verify buttons
    expect(find.text('تشغيل الإيقاع التلقائي (المترونوم)'), findsOneWidget);
    expect(find.text('نقر الدف (دُم)'), findsOneWidget);
    expect(find.text('نقر المثلث (تَك)'), findsOneWidget);

    // Tap manual pad
    await tester.tap(find.text('نقر الدف (دُم)'));
    await tester.pump(const Duration(milliseconds: 100));

    // Tap preset
    await tester.tap(find.text('دمج (١٣٠)'));
    await tester.pumpAndSettle();
    expect(find.text('السرعة: ١٣٠ نبضة/دقيقة'), findsOneWidget);
  });
}
