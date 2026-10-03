import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/widgets/common/verse_image_share_dialog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('VerseImageShareDialog renders Coptic poster, scripture, and controls', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (ctx) => ElevatedButton(
              onPressed: () => VerseImageShareDialog.show(
                ctx,
                text: '« أَنَا هُوَ نُورُ الْعَالَمِ »',
                reference: 'إنجيل يوحنا ٨ : ١٢',
              ),
              child: const Text('افتح'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('افتح'));
    await tester.pumpAndSettle();

    // Verify dialog title & motifs
    expect(find.text('تطبيق نـور • NOOR'), findsOneWidget);
    expect(find.text('« أَنَا هُوَ نُورُ الْعَالَمِ »'), findsOneWidget);
    expect(find.text('إنجيل يوحنا ٨ : ١٢'), findsOneWidget);
    expect(find.text('مشاركة كصورة (1080p)'), findsOneWidget);
    expect(find.text('إغلاق'), findsOneWidget);

    // Verify style chips
    expect(find.text('ستايل ملكي ليلي 🌙'), findsOneWidget);
    expect(find.text('ستايل بردي مضيء ☀️'), findsOneWidget);

    // Switch style to light
    await tester.tap(find.text('ستايل بردي مضيء ☀️'));
    await tester.pumpAndSettle();

    // Tap close
    await tester.tap(find.text('إغلاق'));
    await tester.pumpAndSettle();

    expect(find.text('مشاركة كصورة (1080p)'), findsNothing);
  });
}
