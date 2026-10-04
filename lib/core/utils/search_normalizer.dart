class SearchNormalizer {
  SearchNormalizer._();

  static final RegExp _tashkeelRegex = RegExp(r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06ED]');
  static final RegExp _tatweelRegex = RegExp(r'\u0640');
  static final RegExp _bidiControlsRegex = RegExp(r'[\u200B-\u200F\u202A-\u202E\u2066-\u2069]');
  static final RegExp _extraSpacesRegex = RegExp(r'\s+');

  static const _arabicIndicDigits = {
    '٠': '0', '١': '1', '٢': '2', '٣': '3', '٤': '4',
    '٥': '5', '٦': '6', '٧': '7', '٨': '8', '٩': '9',
    '۰': '0', '۱': '1', '۲': '2', '۳': '3', '۴': '4',
    '۵': '5', '۶': '6', '۷': '7', '۸': '8', '۹': '9',
  };

  /// تطبيع النص العربي للبحث السريع والدقيق (كما في التطبيقات العربية الكبرى)
  static String normalize(String input) {
    if (input.isEmpty) return '';

    var result = input.trim();

    result = result.replaceAll(_bidiControlsRegex, '');
    result = result.replaceAll(_tashkeelRegex, '');
    result = result.replaceAll(_tatweelRegex, '');

    result = result
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ٱ', 'ا')
        .replaceAll('ء', '')
        .replaceAll('ؤ', 'و')
        .replaceAll('ئ', 'ي')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي')
        .replaceAll('ي', 'ي')
        .replaceAll('ی', 'ي')
        .replaceAll('ک', 'ك')
        .replaceAll('ك', 'ك');

    result = result.replaceAllMapped(RegExp(r'[٠-٩۰-۹]'), (m) {
      return _arabicIndicDigits[m[0]] ?? m[0]!;
    });

    result = result.replaceAll(_extraSpacesRegex, ' ');

    return result.toLowerCase().trim();
  }

  /// هل النص يحتوي على الكلمة المفتاحية بعد التطبيع
  static bool matches(String source, String query) {
    if (query.isEmpty) return true;
    final normalizedSource = normalize(source);
    final normalizedQuery = normalize(query);
    return normalizedSource.contains(normalizedQuery);
  }
}
