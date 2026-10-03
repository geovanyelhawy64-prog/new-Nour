import 'failures.dart';

/// نمط النتيجة المغلق (Sealed Result Pattern)
/// يضمن معالجة الأخطاء والنجاح بنمط إلزامي خاضع للتحقق النوعي الكامل
sealed class Result<T> {
  const Result();

  /// إنشاء نتيجة ناجحة
  const factory Result.success(T data) = Success<T>;

  /// إنشاء نتيجة فاشلة
  const factory Result.failure(Failure failure) = FailureResult<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is FailureResult<T>;

  T? get dataOrNull => switch (this) {
        Success(data: final d) => d,
        FailureResult() => null,
      };

  Failure? get failureOrNull => switch (this) {
        Success() => null,
        FailureResult(failure: final f) => f,
      };

  /// تفريع إلزامي لمعالجة النتيجة
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) {
    return switch (this) {
      Success(data: final d) => success(d),
      FailureResult(failure: final f) => failure(f),
    };
  }

  /// تحويل البيانات إذا كانت النتيجة ناجحة
  Result<R> map<R>(R Function(T data) transform) {
    return switch (this) {
      Success(data: final d) => Result.success(transform(d)),
      FailureResult(failure: final f) => Result.failure(f),
    };
  }
}

final class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);

  @override
  String toString() => 'Result.success($data)';
}

final class FailureResult<T> extends Result<T> {
  final Failure failure;
  const FailureResult(this.failure);

  @override
  String toString() => 'Result.failure($failure)';
}
