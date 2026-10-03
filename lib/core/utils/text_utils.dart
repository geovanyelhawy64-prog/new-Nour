import 'search_normalizer.dart';

class TextUtils {
  TextUtils._();

  /// استخراج مقتطف من النص يحيط بكلمة البحث
  static String extractSnippet(String text, String query, {int radius = 50}) {
    if (text.isEmpty) return '';
    if (query.isEmpty) {
      return text.length > radius * 2 ? '${text.substring(0, radius * 2)}...' : text;
    }

    final normalizedText = SearchNormalizer.normalize(text);
    final normalizedQuery = SearchNormalizer.normalize(query);

    final index = normalizedText.indexOf(normalizedQuery);
    if (index == -1) {
      return text.length > radius * 2 ? '${text.substring(0, radius * 2)}...' : text;
    }

    final start = (index - radius).clamp(0, text.length);
    final end = (index + query.length + radius).clamp(0, text.length);

    var snippet = text.substring(start, end).trim();
    if (start > 0) snippet = '...$snippet';
    if (end < text.length) snippet = '$snippet...';

    return snippet;
  }

  /// تحويل الأرقام الإنجليزية لأرقام عربية مشرقية (١، ٢، ٣)
  static String toArabicDigits(int number) {
    const englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    var str = number.toString();
    for (int i = 0; i < englishDigits.length; i++) {
      str = str.replaceAll(englishDigits[i], arabicDigits[i]);
    }
    return str;
  }
}
