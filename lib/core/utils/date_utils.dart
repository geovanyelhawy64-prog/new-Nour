class AppDateUtils {
  AppDateUtils._();

  static const List<String> arabicMonths = [
    'يناير', 'فبراير', 'مارس', 'أبريل',
    'مايو', 'يونيو', 'يوليو', 'أغسطس',
    'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
  ];

  static const List<String> arabicDays = [
    'الإثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد',
  ];

  /// اسم اليوم بالعربية (الإثنين = 1، الأحد = 7)
  static String getDayNameAr(int weekday) {
    return arabicDays[weekday - 1];
  }

  /// اسم الشهر الميلادي بالعربية
  static String getMonthNameAr(int month) {
    return arabicMonths[month - 1];
  }

  /// تنسيق التاريخ الميلادي بالعربية: 5 مايو 2024
  static String formatGregorian(DateTime date) {
    return '${date.day} ${getMonthNameAr(date.month)} ${date.year}';
  }

  /// تنسيق التاريخ الميلادي مع اسم اليوم: الأحد 5 مايو 2024
  static String formatGregorianWithDay(DateTime date) {
    return '${getDayNameAr(date.weekday)} ${formatGregorian(date)}';
  }
}
