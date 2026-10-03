import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/errors/failures.dart';
import 'package:noor_app/core/errors/result.dart';

void main() {
  group('Result Pattern & Sealed Failures Unit Tests', () {
    test('Result.success holds data and dispatches when correctly', () {
      const result = Result.success('نص الإنجيل المقدس');

      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.dataOrNull, 'نص الإنجيل المقدس');
      expect(result.failureOrNull, isNull);

      final dispatched = result.when(
        success: (data) => 'نجاح: $data',
        failure: (f) => 'فشل: ${f.message}',
      );
      expect(dispatched, 'نجاح: نص الإنجيل المقدس');
    });

    test('Result.failure holds failure and maps gracefully', () {
      const failure = DatabaseFailure('تعذر قراءة قاعدة البيانات');
      const result = Result<String>.failure(failure);

      expect(result.isSuccess, isFalse);
      expect(result.isFailure, isTrue);
      expect(result.dataOrNull, isNull);
      expect(result.failureOrNull, equals(failure));

      final mapped = result.map((data) => data.length);
      expect(mapped.isFailure, isTrue);
      expect(mapped.failureOrNull?.message, 'تعذر قراءة قاعدة البيانات');
    });

    test('Sealed Failures support offline-first failure types', () {
      const f1 = DatabaseFailure('خطأ في الاتصال');
      const f2 = NotFoundFailure('العنصر غير موجود');
      const f3 = AssetMissingFailure('ملف noor.db غير موجود');
      const f4 = CorruptedDataFailure('تلف في جدول الآيات');
      const f5 = UnexpectedFailure('خطأ غير متوقع');

      expect(f1, isA<Failure>());
      expect(f2, isA<Failure>());
      expect(f3, isA<Failure>());
      expect(f4, isA<Failure>());
      expect(f5, isA<Failure>());
    });
  });
}
