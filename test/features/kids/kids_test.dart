import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/features/kids/data/kids_data.dart';
import 'package:noor_app/features/kids/models/kids_story.dart';
import 'package:noor_app/features/kids/presentation/kids_home_screen.dart';
import 'package:noor_app/features/kids/presentation/kids_story_reader_screen.dart';
import 'package:noor_app/features/kids/presentation/kids_coloring_screen.dart';

void main() {
  group('Kids Mode Data Tests', () {
    test('Stories list is complete with 10 biblical stories', () {
      expect(KidsData.stories.length, equals(10));

      final otStories = KidsData.stories
          .where((s) => s.testament == KidsTestament.oldTestament)
          .toList();
      final ntStories = KidsData.stories
          .where((s) => s.testament == KidsTestament.newTestament)
          .toList();

      expect(otStories.length, equals(6));
      expect(ntStories.length, equals(4));

      for (final story in KidsData.stories) {
        expect(story.id.isNotEmpty, isTrue);
        expect(story.title.isNotEmpty, isTrue);
        expect(story.paragraphs.isNotEmpty, isTrue);
        expect(story.memoryVerse.isNotEmpty, isTrue);
        expect(story.moralLesson.isNotEmpty, isTrue);
      }
    });

    test('Prayers list has child-friendly daily prayers', () {
      expect(KidsData.prayers.length, equals(4));
      for (final prayer in KidsData.prayers) {
        expect(prayer.title.isNotEmpty, isTrue);
        expect(prayer.text.isNotEmpty, isTrue);
        expect(prayer.timing.isNotEmpty, isTrue);
        expect(prayer.psalmLine.isNotEmpty, isTrue);
      }
    });

    test('Memory verses and coloring outlines are well populated', () {
      expect(KidsData.memoryVerses.length, greaterThanOrEqualTo(6));
      expect(KidsData.coloringOutlines.length, greaterThanOrEqualTo(4));
    });
  });

  group('Kids Mode Presentation Tests', () {
    testWidgets('KidsHomeScreen renders tabs and stories correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: KidsHomeScreen(),
        ),
      );

      // Verify header
      expect(find.text('👶 وضع الأطفال'), findsOneWidget);
      expect(find.text('قصص الكتاب'), findsOneWidget);
      expect(find.text('صلواتي'), findsOneWidget);
      expect(find.text('آيات للحفظ'), findsOneWidget);
      expect(find.text('ركن التلوين'), findsOneWidget);

      // Verify stories tab content
      expect(find.text('سفينة نوح وقوس قزح'), findsWidgets);
    });

    testWidgets('KidsStoryReaderScreen displays story details and lessons', (tester) async {
      final sampleStory = KidsData.stories.first;

      await tester.pumpWidget(
        MaterialApp(
          home: KidsStoryReaderScreen(storyId: sampleStory.id),
        ),
      );

      expect(find.text(sampleStory.title), findsWidgets);
      expect(find.text('📖 شاهد القصة: ${sampleStory.reference}'), findsOneWidget);
      expect(find.text(sampleStory.paragraphs.first), findsOneWidget);

      await tester.scrollUntilVisible(find.text(sampleStory.moralLesson), 300.0);
      expect(find.text(sampleStory.memoryVerse), findsOneWidget);
      expect(find.text(sampleStory.moralLesson), findsOneWidget);
    });

    testWidgets('KidsColoringScreen renders canvas and drawing controls', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: KidsColoringScreen(templateId: 'ark'),
        ),
      );

      expect(find.text('🎨 سفينة نوح وحمامة السلام'), findsOneWidget);
      expect(find.byIcon(Icons.undo_rounded), findsOneWidget);
      expect(find.byIcon(Icons.delete_outline_rounded), findsOneWidget);
    });
  });
}
