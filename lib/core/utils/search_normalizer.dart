class SearchNormalizer {
  SearchNormalizer._();

  // تشمل علامات التشكيل العربية والعلامات القرآنية، لا التشكيل الأساسي فقط.
  static final RegExp _tashkeelRegex =
      RegExp(r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06ED]');
  static final RegExp _tatweelRegex = RegExp(r'\u0640');
  static final RegExp _extraSpacesRegex = RegExp(r'\s+');

  /// تطبيع النص العربي للبحث السريع والدقيق
  static String normalize(String input) {
    if (input.isEmpty) return '';

    var result = input.trim();

    // 1. إزالة التشكيل
    result = result.replaceAll(_tashkeelRegex, '');

    // 2. إزالة التطويل (ـ)
    result = result.replaceAll(_tatweelRegex, '');

    // 3. توحيد الهمزات والألف
    result = result
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ٱ', 'ا')
        .replaceAll('ء', '')
        .replaceAll('ؤ', 'و')
        .replaceAll('ئ', 'ي');

    // 4. توحيد التاء المربوطة والهاء
    result = result.replaceAll('ة', 'ه');

    // 5. توحيد الألف المقصورة والياء
    result = result.replaceAll('ى', 'ي');

    // 6. توحيد المسافات
    result = result.replaceAll(_extraSpacesRegex, ' ');

    return result.toLowerCase();
  }

  /// يحول البحث المطبّع إلى تعبير FTS5 آمن.
  ///
  /// كل كلمة توضع داخل علامات اقتباس لمنع تفسير مدخل المستخدم كعامل FTS.
  static String toFts5Query(String input) {
    final normalized = normalize(input);
    if (normalized.isEmpty) return '';
    return normalized
        .split(' ')
        .where((token) => token.isNotEmpty)
        .map((token) => '"${token.replaceAll('"', '""')}"')
        .join(' AND ');
  }

  /// هل النص يحتوي على الكلمة المفتاحية بعد التطبيع
  static bool matches(String source, String query) {
    if (query.isEmpty) return true;
    final normalizedSource = normalize(source);
    final normalizedQuery = normalize(query);
    return normalizedSource.contains(normalizedQuery);
  }
}
