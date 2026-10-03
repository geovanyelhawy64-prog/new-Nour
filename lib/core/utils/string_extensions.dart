import 'search_normalizer.dart';
import 'text_utils.dart';

extension StringExtensions on String {
  /// تطبيع النص للبحث
  String get normalizedForSearch => SearchNormalizer.normalize(this);

  /// هل النص يحتوي على حروف قبطية (مجال يونيكود U+2C80 حتى U+2CFF)
  bool get containsCoptic {
    for (final rune in runes) {
      if ((rune >= 0x2C80 && rune <= 0x2CFF) || (rune >= 0x03E2 && rune <= 0x03EF)) {
        return true;
      }
    }
    return false;
  }

  /// تحويل الأرقام في النص إلى أرقام عربية مشرقية
  String get withArabicDigits {
    var res = this;
    const eng = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const ara = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (int i = 0; i < eng.length; i++) {
      res = res.replaceAll(eng[i], ara[i]);
    }
    return res;
  }
}

extension IntExtensions on int {
  /// تحويل الرقم لأرقام عربية مشرقية
  String get arabicDigits => TextUtils.toArabicDigits(this);
}
