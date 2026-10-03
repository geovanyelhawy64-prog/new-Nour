import 'coptic_month.dart';

/// محول رياضي بين التقويمين القبطي والميلادي عبر رقم اليوم اليولياني.
///
/// هذا حساب تقويمي فقط، ولا يستنتج منه حكم طقسي.
class CopticDate {
  final int year;
  final int month; // 1-13 (الشهر 13 = أيام النسيء)
  final int day;

  const CopticDate({
    required this.year,
    required this.month,
    required this.day,
  }) : assert(year > 0, 'Coptic year must be positive'),
       assert(month >= 1 && month <= 13, 'Coptic month must be between 1 and 13'),
       assert(day >= 1 && day <= 30, 'Coptic day must be between 1 and 30'),
       assert(
         month != 13 || day <= (year % 4 == 3 ? 6 : 5),
         'Invalid epagomenal day for this Coptic year',
       );

  /// أسماء الشهور القبطية بالعربية
  static const List<String> monthNames = [
    'توت', // 1
    'بابه', // 2
    'هاتور', // 3
    'كيهك', // 4
    'طوبة', // 5
    'أمشير', // 6
    'برمهات', // 7
    'برمودة', // 8
    'بشنس', // 9
    'بؤونة', // 10
    'أبيب', // 11
    'مسرى', // 12
    'النسيء', // 13
  ];

  /// أسماء الشهور بالقبطي
  static const List<String> monthNamesCoptic = [
    'Ⲑⲱⲟⲩⲧ',
    'Ⲡⲁⲟⲡⲓ',
    'Ⲁⲑⲱⲣ',
    'Ⲭⲟⲓⲁⲕ',
    'Ⲧⲱⲃⲓ',
    'Ⲙⲉϣⲓⲣ',
    'Ⲡⲁⲣⲉⲙϩⲟⲧⲡ',
    'Ⲫⲁⲣⲙⲟⲩⲑⲓ',
    'Ⲡⲁϣⲟⲛⲥ',
    'Ⲡⲁⲱⲛⲓ',
    'Ⲉⲡⲓⲡ',
    'Ⲙⲉⲥⲱⲣⲏ',
    'Ⲡⲓⲕⲟⲩϫⲓ',
  ];

  /// اسم الشهر بالعربي
  String get monthName => monthNames[month - 1];
  String get monthNameAr => monthName;

  /// اسم الشهر بالقبطي
  String get monthNameCoptic => monthNamesCoptic[month - 1];

  /// الشهر كـ Enum
  CopticMonth get copticMonth => CopticMonth.fromNumber(month);

  /// تحويل من تاريخ (alias)
  factory CopticDate.fromDate(DateTime date) => CopticDate.fromDateTime(date);

  /// هل السنة القبطية كبيسة (السنة الثالثة في كل دورة 4 سنوات)
  static bool isLeapYear(int copticYear) {
    return (copticYear % 4) == 3;
  }

  /// هل السنة الحالية كبيسة
  bool get isLeap => isLeapYear(year);

  /// عدد أيام النسيء لسنة معينة
  static int epagomenalDays(int copticYear) {
    return isLeapYear(copticYear) ? 6 : 5;
  }

  /// أقصى عدد أيام في هذا الشهر
  int get daysInMonth {
    if (month < 13) return 30;
    return epagomenalDays(year);
  }

  /// تحويل من تاريخ ميلادي لقبطي
  factory CopticDate.fromGregorian(DateTime gregorian) {
    if (gregorian.year < 284) {
      throw RangeError.range(gregorian.year, 284, 9999, 'gregorian.year');
    }
    final jdn = _gregorianToJDN(gregorian.year, gregorian.month, gregorian.day);
    return _jdnToCoptic(jdn);
  }

  /// تحويل من DateTime لقبطي
  factory CopticDate.fromDateTime(DateTime gregorian) {
    return CopticDate.fromGregorian(gregorian);
  }

  /// تحويل من قبطي لميلادي
  DateTime toGregorian() {
    final jdn = _copticToJDN(year, month, day);
    return _jdnToGregorian(jdn);
  }

  /// تحويل إلى DateTime (ميلادي)
  DateTime toDateTime() => toGregorian();

  /// تحويل تاريخ ميلادي لرقم اليوم اليولياني JDN
  static int _gregorianToJDN(int year, int month, int day) {
    final a = (14 - month) ~/ 12;
    final y = year + 4800 - a;
    final m = month + 12 * a - 3;
    return day +
        (153 * m + 2) ~/ 5 +
        365 * y +
        y ~/ 4 -
        y ~/ 100 +
        y ~/ 400 -
        32045;
  }

  /// تحويل تاريخ قبطي لرقم اليوم اليولياني JDN
  static int _copticToJDN(int year, int month, int day) {
    // 1 توت 1 ش = 29 أغسطس 284 ميلادي (يولياني) = JDN 1825030
    const copticEpochJDN = 1825030;
    final daysSinceEpoch =
        365 * (year - 1) + (year ~/ 4) + 30 * (month - 1) + (day - 1);
    return copticEpochJDN + daysSinceEpoch;
  }

  /// تحويل رقم اليوم اليولياني لتاريخ قبطي
  static CopticDate _jdnToCoptic(int jdn) {
    const copticEpochJDN = 1825030;
    final daysSinceEpoch = jdn - copticEpochJDN;

    final cycle4 = daysSinceEpoch ~/ 1461;
    final rem = daysSinceEpoch % 1461;

    int yearInCycle;
    int dayInYear;

    if (rem < 365) {
      yearInCycle = 0;
      dayInYear = rem;
    } else if (rem < 730) {
      yearInCycle = 1;
      dayInYear = rem - 365;
    } else if (rem < 1096) {
      // السنة الثالثة كبيسة 366 يوم
      yearInCycle = 2;
      dayInYear = rem - 730;
    } else {
      yearInCycle = 3;
      dayInYear = rem - 1096;
    }

    final copticYear = cycle4 * 4 + yearInCycle + 1;

    int copticMonth;
    int copticDay;

    if (dayInYear < 360) {
      copticMonth = (dayInYear ~/ 30) + 1;
      copticDay = (dayInYear % 30) + 1;
    } else {
      copticMonth = 13;
      copticDay = dayInYear - 360 + 1;
    }

    return CopticDate(
      year: copticYear,
      month: copticMonth,
      day: copticDay,
    );
  }

  /// تحويل رقم اليوم اليولياني لتاريخ ميلادي
  static DateTime _jdnToGregorian(int jdn) {
    final a = jdn + 32044;
    final b = (4 * a + 3) ~/ 146097;
    final c = a - (146097 * b) ~/ 4;
    final d = (4 * c + 3) ~/ 1461;
    final e = c - (1461 * d) ~/ 4;
    final m = (5 * e + 2) ~/ 153;

    final day = e - (153 * m + 2) ~/ 5 + 1;
    final month = m + 3 - 12 * (m ~/ 10);
    final year = 100 * b + d - 4800 + m ~/ 10;

    return DateTime(year, month, day);
  }

  /// التاريخ القبطي لليوم الحالي
  factory CopticDate.today() {
    return CopticDate.fromGregorian(DateTime.now());
  }

  /// اليوم التالي
  CopticDate nextDay() {
    if (day < daysInMonth) {
      return CopticDate(year: year, month: month, day: day + 1);
    } else if (month < 13) {
      return CopticDate(year: year, month: month + 1, day: 1);
    } else {
      return CopticDate(year: year + 1, month: 1, day: 1);
    }
  }

  /// اليوم السابق
  CopticDate previousDay() {
    if (day > 1) {
      return CopticDate(year: year, month: month, day: day - 1);
    } else if (month > 1) {
      final prevMonth = month - 1;
      final prevDays = prevMonth == 13 ? epagomenalDays(year) : 30;
      return CopticDate(year: year, month: prevMonth, day: prevDays);
    } else {
      final prevYear = year - 1;
      final nasieDays = epagomenalDays(prevYear);
      return CopticDate(year: prevYear, month: 13, day: nasieDays);
    }
  }

  /// صيغة العرض العربية: 12 بشنس 1740
  String get formatted => '$day $monthName $year';

  /// صيغة العرض العربية كدالة
  String formatArabic() => formatted;

  /// صيغة العرض الكاملة: 12 بشنس 1740 - 20 مايو 2024
  String get fullFormatted {
    final gregorian = toGregorian();
    const months = [
      'يناير', 'فبراير', 'مارس', 'أبريل',
      'مايو', 'يونيو', 'يوليو', 'أغسطس',
      'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
    ];
    return '$day $monthName $year - '
        '${gregorian.day} ${months[gregorian.month - 1]} '
        '${gregorian.year}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CopticDate &&
        year == other.year &&
        month == other.month &&
        day == other.day;
  }

  @override
  int get hashCode => Object.hash(year, month, day);

  @override
  String toString() => 'CopticDate($day/$month/$year)';
}
