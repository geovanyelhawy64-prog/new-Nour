import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/features/home/presentation/widgets/daily_father_quote_card.dart';

void main() {
  testWidgets('DailyFatherQuoteCard renders father quote, book, and interactions', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DailyFatherQuoteCard(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify title
    expect(find.text('من أقوال الآباء'), findsOneWidget);

    // Verify father name and book
    expect(find.textContaining('القديس'), findsWidgets);
    expect(find.textContaining('«'), findsWidgets);

    // Verify buttons
    expect(find.byIcon(Icons.refresh_rounded), findsOneWidget);
    expect(find.byIcon(Icons.copy_rounded), findsOneWidget);
    expect(find.text('تصفح بستان أقوال الآباء'), findsOneWidget);

    // Tap refresh button
    await tester.tap(find.byIcon(Icons.refresh_rounded));
    await tester.pumpAndSettle();

    // Verify still renders quote
    expect(find.textContaining('«'), findsWidgets);

    // Tap copy button
    await tester.tap(find.byIcon(Icons.copy_rounded));
    await tester.pumpAndSettle();

    // Verify snackbar
    expect(find.text('تم نسخ قول الأب القديس إلى الحافظة'), findsOneWidget);
  });
}
