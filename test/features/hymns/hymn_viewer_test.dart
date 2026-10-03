import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noor_app/core/services/preferences_service.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:noor_app/features/hymns/presentation/widgets/hymn_viewer.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await PreferencesService.init();
  });

  group('HymnSyllable Model Tests', () {
    test('HymnSyllable correctly parses JSON and computes wave & pitch badges', () {
      final jsonMap = {
        's': 'إب',
        'c': 'Ⲉ',
        'v': 3,
        'p': 'ascending',
        'ms': 1200,
      };

      final syl = HymnSyllable.fromJson(jsonMap);
      expect(syl.arabicSyllable, 'إب');
      expect(syl.copticSyllable, 'Ⲉ');
      expect(syl.vibratoCount, 3);
      expect(syl.durationMs, 1200);
      expect(syl.pitchLabel, contains('صاعد'));
      expect(syl.hazatWaves, contains('〰️'));
    });
  });

  group('HymnViewer Widget Tests', () {
    const testHymn = Hymn(
      id: 'epouro',
      bookId: 'annual',
      nameAr: 'لحن يا ملك السلام (إبؤرو)',
      nameCoptic: 'Ⲉⲡⲟⲩⲣⲟ',
      occasion: 'liturgy',
      tone: 'annual',
      hymnOrder: 1,
    );

    const testSegment = HymnSegment(
      id: 1,
      hymnId: 'epouro',
      segmentOrder: 1,
      lineNumber: 1,
      coptic: 'Ⲉⲡⲟⲩⲣⲟ ⲛ̀ⲧⲉ ϯϩⲓⲣⲏⲛⲏ',
      phonetic: 'إبؤرو إنتي تي هيريني',
      arabic: 'يا ملك السلام أعطنا سلامك',
      syllablesJson: '[{"s":"إب","c":"Ⲉ","v":2,"p":"medium","ms":800},{"s":"أو","c":"ⲡⲟⲩ","v":4,"p":"high","ms":1600}]',
    );

    testWidgets('HymnViewer renders structured liturgical text, syllables, and controls', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HymnViewer(
              hymn: testHymn,
              segments: [testSegment],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check text rendering
      expect(find.textContaining('Ⲉⲡⲟⲩⲣⲟ'), findsWidgets);
      expect(find.textContaining('إبؤرو'), findsWidgets);
      expect(find.textContaining('يا ملك السلام'), findsWidgets);

      // Check syllable badges rendering
      expect(find.textContaining('2 هزة'), findsOneWidget);
      expect(find.textContaining('4 هزة'), findsOneWidget);

      // Check Hazat toggle chip
      expect(find.text('إظهار الهزات الموسيقية'), findsOneWidget);

      // Tap on syllable card to focus it
      await tester.tap(find.textContaining('2 هزة'));
      await tester.pumpAndSettle();

      // Switch language mode to coptic only
      await tester.tap(find.textContaining('قبطي أصيل'));
      await tester.pumpAndSettle();

      // Arabic translation should be hidden
      expect(find.text('يا ملك السلام أعطنا سلامك'), findsNothing);
      // Coptic text should remain visible
      expect(find.textContaining('Ⲉⲡⲟⲩⲣⲟ'), findsWidgets);

      // Switch to Arabic only
      await tester.tap(find.textContaining('عربي'));
      await tester.pumpAndSettle();
      expect(find.text('يا ملك السلام أعطنا سلامك'), findsOneWidget);

      // Toggle off Hazat
      await tester.tap(find.text('إظهار الهزات الموسيقية'));
      await tester.pumpAndSettle();
      expect(find.text('إخفاء الهزات الموسيقية'), findsOneWidget);
      expect(find.textContaining('2 هزة'), findsNothing);
    });
  });
}
