import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/utils/scripture_reference_resolver.dart';

void main() {
  group('ScriptureReferenceResolver Unit Tests', () {
    test('Resolves verse with abbreviation: يو 3:16', () {
      final ref = ScriptureReferenceResolver.resolve('يو 3:16');
      expect(ref, isNotNull);
      expect(ref!.bookId, equals(50));
      expect(ref.chapter, equals(3));
      expect(ref.verse, equals(16));
      expect(ref.displayText, contains('إنجيل يوحنا'));
      expect(ref.routePath, equals('/bible/read/50/3'));
    });

    test('Resolves verse with Arabic numerals and spacing: يو ٣ : ١٦', () {
      final ref = ScriptureReferenceResolver.resolve('يو ٣ : ١٦');
      expect(ref, isNotNull);
      expect(ref!.bookId, equals(50));
      expect(ref.chapter, equals(3));
      expect(ref.verse, equals(16));
    });

    test('Resolves chapter only: مز 51', () {
      final ref = ScriptureReferenceResolver.resolve('مز 51');
      expect(ref, isNotNull);
      expect(ref!.bookId, equals(21));
      expect(ref.chapter, equals(51));
      expect(ref.verse, isNull);
      expect(ref.displayText, contains('سفر المزامير'));
      expect(ref.routePath, equals('/bible/read/21/51'));
    });

    test('Resolves chapter only: مت 5', () {
      final ref = ScriptureReferenceResolver.resolve('مت 5');
      expect(ref, isNotNull);
      expect(ref!.bookId, equals(47));
      expect(ref.chapter, equals(5));
      expect(ref.verse, isNull);
    });

    test('Resolves Romans with verse: رو 8:28', () {
      final ref = ScriptureReferenceResolver.resolve('رو 8:28');
      expect(ref, isNotNull);
      expect(ref!.bookId, equals(52));
      expect(ref.chapter, equals(8));
      expect(ref.verse, equals(28));
    });

    test('Resolves full book name: تكوين 1', () {
      final ref = ScriptureReferenceResolver.resolve('تكوين 1');
      expect(ref, isNotNull);
      expect(ref!.bookId, equals(1));
      expect(ref.chapter, equals(1));
    });

    test('Returns null for ordinary search query', () {
      expect(ScriptureReferenceResolver.resolve('المحبة لا تسقط'), isNull);
      expect(ScriptureReferenceResolver.resolve(''), isNull);
    });
  });
}
