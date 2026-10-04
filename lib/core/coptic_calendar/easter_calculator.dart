/// حساب عيد القيامة والأعياد المتنقلة حسب الحساب الأبقطي القبطي
/// المعتمد في الكنيسة القبطية الأرثوذكسية منذ مجمع نيقية 325م
class EasterCalculator {
  EasterCalculator._();

  /// حساب تاريخ عيد القيامة المجيد لسنة ميلادية معينة
  static DateTime calculateEaster(int gregorianYear) {
    // 1. الدورة القمرية (الإبكتا) بالطريقة السكندرية اليوليانية
    final a = gregorianYear % 4;
    final b = gregorianYear % 7;
    final c = gregorianYear % 19;

    // 2. حساب قمر الفصح
    final d = (19 * c + 15) % 30;

    // 3. حساب يوم الأحد التالي
    final e = (2 * a + 4 * b - d + 34) % 7;

    // 4. الشهر واليوم بالتقويم اليولياني
    final julianMonth = (d + e + 114) ~/ 31; // 3 = مارس، 4 = أبريل
    final julianDay = ((d + e + 114) % 31) + 1;

    // 5. التحويل من اليولياني للميلادي الغريغوري (فرق 13 يوماً في القرنين 20 و 21)
    final diff = _julianToGregorianDiff(gregorianYear);
    return DateTime(gregorianYear, julianMonth, julianDay + diff);
  }

  /// حساب فرق الأيام بين التقويمين اليولياني والغريغوري
  static int _julianToGregorianDiff(int year) {
    final century = year ~/ 100;
    return century - (century ~/ 4) - 2;
  }

  /// بداية صوم يونان (نينوى) - يسبق الصوم الكبير بـ 15 يوماً (يبدأ يوم الإثنين)
  static DateTime jonahFastStart(int gregorianYear) {
    final lentStart = greatLentStart(gregorianYear);
    return DateTime(lentStart.year, lentStart.month, lentStart.day - 15);
  }

  /// فصح يونان (الخميس بعد صوم نينوى)
  static DateTime jonahPassover(int gregorianYear) {
    final start = jonahFastStart(gregorianYear);
    return DateTime(start.year, start.month, start.day + 3);
  }

  /// بداية الصوم الكبير المقدس (55 يوماً قبل القيامة - يبدأ يوم الإثنين)
  static DateTime greatLentStart(int gregorianYear) {
    final easter = calculateEaster(gregorianYear);
    return DateTime(easter.year, easter.month, easter.day - 55);
  }

  /// جمعة ختام الصوم الكبير
  static DateTime lentEndFriday(int gregorianYear) {
    final easter = calculateEaster(gregorianYear);
    return DateTime(easter.year, easter.month, easter.day - 9);
  }

  /// سبت لعازر
  static DateTime lazarusSaturday(int gregorianYear) {
    final easter = calculateEaster(gregorianYear);
    return DateTime(easter.year, easter.month, easter.day - 8);
  }

  /// أحد الشعانين (أحد السعف - قبل القيامة بأسبوع)
  static DateTime palmSunday(int gregorianYear) {
    final easter = calculateEaster(gregorianYear);
    return DateTime(easter.year, easter.month, easter.day - 7);
  }

  /// بداية أسبوع الآلام (البصخة المقدسة)
  static DateTime paschaStart(int gregorianYear) {
    return palmSunday(gregorianYear);
  }

  /// خميس العهد
  static DateTime covenantThursday(int gregorianYear) {
    final easter = calculateEaster(gregorianYear);
    return DateTime(easter.year, easter.month, easter.day - 3);
  }

  /// الجمعة العظيمة
  static DateTime goodFriday(int gregorianYear) {
    final easter = calculateEaster(gregorianYear);
    return DateTime(easter.year, easter.month, easter.day - 2);
  }

  /// سبت النور (سبت الفرح)
  static DateTime brightSaturday(int gregorianYear) {
    final easter = calculateEaster(gregorianYear);
    return DateTime(easter.year, easter.month, easter.day - 1);
  }

  /// أحد توما (الأحد الأول بعد القيامة)
  static DateTime thomasSunday(int gregorianYear) {
    final easter = calculateEaster(gregorianYear);
    return DateTime(easter.year, easter.month, easter.day + 7);
  }

  /// عيد الصعود المجيد (اليوم الأربعون بعد القيامة - يوم خميس)
  static DateTime ascensionDay(int gregorianYear) {
    final easter = calculateEaster(gregorianYear);
    return DateTime(easter.year, easter.month, easter.day + 39);
  }

  /// عيد العنصرة / حلول الروح القدس (البنديقستي - اليوم الخمسون - يوم أحد)
  static DateTime pentecost(int gregorianYear) {
    final easter = calculateEaster(gregorianYear);
    return DateTime(easter.year, easter.month, easter.day + 49);
  }

  /// بداية صوم الرسل (يوم الإثنين التالي لعيد العنصرة)
  static DateTime apostlesFastStart(int gregorianYear) {
    final pentecostDate = pentecost(gregorianYear);
    return DateTime(pentecostDate.year, pentecostDate.month, pentecostDate.day + 1);
  }

  /// نهاية صوم الرسل / عيد الرسل (ثابت في 5 أبيب = 12 يوليو)
  static DateTime apostlesFastEnd(int gregorianYear) {
    return DateTime(gregorianYear, 7, 12);
  }

  /// عدد أيام صوم الرسل لسنة معينة
  static int apostlesFastDays(int gregorianYear) {
    final start = apostlesFastStart(gregorianYear);
    final end = apostlesFastEnd(gregorianYear);
    return end.difference(start).inDays;
  }

  /// هل التاريخ داخل فترة الخمسين المقدسة (من القيامة إلى العنصرة)
  static bool isInPentecostalPeriod(DateTime date) {
    final easter = calculateEaster(date.year);
    final pentecostDate = pentecost(date.year);
    final cleanDate = DateTime(date.year, date.month, date.day);
    return !cleanDate.isBefore(easter) && !cleanDate.isAfter(pentecostDate);
  }

  /// هل التاريخ في الصوم الكبير
  static bool isInGreatLent(DateTime date) {
    final lentStart = greatLentStart(date.year);
    final easter = calculateEaster(date.year);
    final cleanDate = DateTime(date.year, date.month, date.day);
    return !cleanDate.isBefore(lentStart) && cleanDate.isBefore(easter);
  }

  /// هل التاريخ في أسبوع الآلام (من أحد الشعانين إلى سبت النور)
  static bool isInPascha(DateTime date) {
    final palmSundayDate = palmSunday(date.year);
    final easter = calculateEaster(date.year);
    final cleanDate = DateTime(date.year, date.month, date.day);
    return !cleanDate.isBefore(palmSundayDate) && cleanDate.isBefore(easter);
  }

  /// هل التاريخ في صوم يونان (3 أيام: الإثنين والثلاثاء والأربعاء)
  static bool isInJonahFast(DateTime date) {
    final start = jonahFastStart(date.year);
    final end = start.add(const Duration(days: 2));
    final cleanDate = DateTime(date.year, date.month, date.day);
    return !cleanDate.isBefore(start) && !cleanDate.isAfter(end);
  }

  /// هل التاريخ في صوم الرسل
  static bool isInApostlesFast(DateTime date) {
    final start = apostlesFastStart(date.year);
    final end = apostlesFastEnd(date.year).subtract(const Duration(days: 1));
    final cleanDate = DateTime(date.year, date.month, date.day);
    return !cleanDate.isBefore(start) && !cleanDate.isAfter(end);
  }
}
