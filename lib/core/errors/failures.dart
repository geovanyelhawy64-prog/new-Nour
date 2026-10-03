/// فئات الأخطاء المغلقة (Sealed Failures) للتطبيقات الأوفلاين (Offline-First)
sealed class Failure {
  final String message;
  final String? code;
  final dynamic cause;

  const Failure(this.message, {this.code, this.cause});

  @override
  String toString() => '$runtimeType(message: $message, code: $code)';
}

/// فشل الوصول لقاعدة البيانات المحلية (Drift SQLite)
final class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, {super.code, super.cause});
}

/// عدم العثور على العنصر أو النص المطلوب
final class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, {super.code, super.cause});
}

/// ملف قاعدة البيانات غير موجود أو تعذر تحميله من assets
final class AssetMissingFailure extends Failure {
  const AssetMissingFailure(super.message, {super.code, super.cause});
}

/// تلف في البيانات أو عدم توافق بنيوي
final class CorruptedDataFailure extends Failure {
  const CorruptedDataFailure(super.message, {super.code, super.cause});
}

/// خطأ عام غير متوقع
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message, {super.code, super.cause});
}
