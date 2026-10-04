import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/widgets/common/quote_card_dialog.dart';

void main() {
  testWidgets('QuoteCardDialog renders scripture text, reference, and buttons', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => QuoteCardDialog.show(
                context,
                text: 'أَنَا هُوَ نُورُ الْعَالَمِ',
                reference: 'إنجيل يوحنا ٨ : ١٢',
                subtitle: 'شاهد إنجيلي',
              ),
              child: const Text('افتح'),
            ),
          ),
        ),
      ),
    );

    // Tap open
    await tester.tap(find.text('افتح'));
    await tester.pumpAndSettle();

    // Verify dialog content
    expect(find.text('تطبيق نـور • NOOR'), findsOneWidget);
    expect(find.text('« أَنَا هُوَ نُورُ الْعَالَمِ »'), findsOneWidget);
    expect(find.text('إنجيل يوحنا ٨ : ١٢'), findsOneWidget);
    expect(find.text('شاهد إنجيلي'), findsOneWidget);
    expect(find.text('نسخ النص'), findsOneWidget);
    expect(find.text('مشاركة كصورة (1080x1080)'), findsOneWidget);
    expect(find.text('إغلاق'), findsOneWidget);

    // Tap close
    await tester.tap(find.text('إغلاق'));
    await tester.pumpAndSettle();

    expect(find.text('« أَنَا هُوَ نُورُ الْعَالَمِ »'), findsNothing);
  });
}
