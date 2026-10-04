import 'coptic_date.dart';
import 'easter_calculator.dart';

/// أنواع الطقوس الكنسية القبطية
enum ChurchRite {
  annual, // سنوي
  festive, // فرايحي
  lenten, // صيامي
  kiahki, // كيهكي
  pascha, // أسبوع الآلام
  joyous, // الخمسين المقدسة
}

/// نتيجة وتفاصيل تحديد طقس اليوم
class DayRiteInfo {
  final CopticDate copticDate;
  final DateTime gregorianDate;
  final ChurchRite rite;
  final String? feastName;
  final String? fastName;
  final bool isMajorFeast;
  final bool isMinorFeast;
  final bool isFasting;
  final int? fastDaysRemaining;
  final String riteNameAr;

  /// اسم الموسم أو العيد أو الصوم
  String get seasonName => feastName ?? fastName ?? riteNameAr;

  const DayRiteInfo({
    required this.copticDate,
    required this.gregorianDate,
    required this.rite,
    this.feastName,
    this.fastName,
    this.isMajorFeast = false,
    this.isMinorFeast = false,
    this.isFasting = false,
    this.fastDaysRemaining,
    required this.riteNameAr,
  });

  @override
  String toString() {
    return 'DayRiteInfo(${copticDate.formatted}, rite: $riteNameAr, feast: $feastName, fast: $fastName)';
  }
}

/// محرك تحديد الطقس الكنسي اليومي وحالة الصيام والأعياد
class RiteDeterminer {
  RiteDeterminer._();

  static DayRiteInfo determineRite(DateTime date) {
    final cleanDate = DateTime(date.year, date.month, date.day);
    final copticDate = CopticDate.fromGregorian(cleanDate);
    final year = cleanDate.year;

    // 1. عيد أحد الشعانين المجيد (رابع الأعياد السيدية الكبرى - فرايحي بالشعانيني)
    final palmSunday = EasterCalculator.palmSunday(year);
    if (_isSameDay(cleanDate, palmSunday)) {
      return DayRiteInfo(
        copticDate: copticDate,
        gregorianDate: cleanDate,
        rite: ChurchRite.festive,
        feastName: 'عيد أحد الشعانين المجيد',
        isMajorFeast: true,
        isFasting: true,
        fastName: 'صوم الشعانين (فرايحي)',
        riteNameAr: 'فرايحي بالشعانيني',
      );
    }

    // 2. خميس العهد المجيد (من الأعياد السيدية الصغرى السبعة داخل البصخة)
    final covenantThursday = EasterCalculator.covenantThursday(year);
    if (_isSameDay(cleanDate, covenantThursday)) {
      return DayRiteInfo(
        copticDate: copticDate,
        gregorianDate: cleanDate,
        rite: ChurchRite.festive,
        feastName: 'خميس العهد المجيد (صلاة اللقان والقداس الإلهي)',
        isMinorFeast: true,
        isFasting: true,
        fastName: 'أسبوع الآلام المقدس',
        riteNameAr: 'سنوي بصلوات اللقان والقداس',
      );
    }

    // 3. أسبوع الآلام (البصخة المقدسة)
    if (EasterCalculator.isInPascha(cleanDate)) {
      return DayRiteInfo(
        copticDate: copticDate,
        gregorianDate: cleanDate,
        rite: ChurchRite.pascha,
        fastName: 'أسبوع الآلام المقدس',
        isFasting: true,
        riteNameAr: 'أسبوع الآلام',
      );
    }

    // 4. عيد القيامة المجيد
    final easter = EasterCalculator.calculateEaster(year);
    if (_isSameDay(cleanDate, easter)) {
      return DayRiteInfo(
        copticDate: copticDate,
        gregorianDate: cleanDate,
        rite: ChurchRite.festive,
        feastName: 'عيد القيامة المجيد',
        isMajorFeast: true,
        isFasting: false,
        riteNameAr: 'فرايحي',
      );
    }

    // 3. فترة الخمسين المقدسة (فرح كامل بدون أي صوم)
    if (EasterCalculator.isInPentecostalPeriod(cleanDate)) {
      final ascension = EasterCalculator.ascensionDay(year);
      if (_isSameDay(cleanDate, ascension)) {
        return DayRiteInfo(
          copticDate: copticDate,
          gregorianDate: cleanDate,
          rite: ChurchRite.festive,
          feastName: 'عيد الصعود المجيد',
          isMajorFeast: true,
          isFasting: false,
          riteNameAr: 'فرايحي',
        );
      }

      final pentecostDate = EasterCalculator.pentecost(year);
      if (_isSameDay(cleanDate, pentecostDate)) {
        return DayRiteInfo(
          copticDate: copticDate,
          gregorianDate: cleanDate,
          rite: ChurchRite.festive,
          feastName: 'عيد حلول الروح القدس (العنصرة)',
          isMajorFeast: true,
          isFasting: false,
          riteNameAr: 'فرايحي',
        );
      }

      final thomasSunday = EasterCalculator.thomasSunday(year);
      if (_isSameDay(cleanDate, thomasSunday)) {
        return DayRiteInfo(
          copticDate: copticDate,
          gregorianDate: cleanDate,
          rite: ChurchRite.festive,
          feastName: 'أحد توما',
          isMinorFeast: true,
          isFasting: false,
          riteNameAr: 'فرايحي',
        );
      }

      return DayRiteInfo(
        copticDate: copticDate,
        gregorianDate: cleanDate,
        rite: ChurchRite.joyous,
        isFasting: false,
        riteNameAr: 'الخمسين المقدسة',
      );
    }

    // 4. الصوم الكبير المقدس
    if (EasterCalculator.isInGreatLent(cleanDate)) {
      // التحقق من عيد البشارة أثناء الصوم الكبير (29 برمهات)
      final annunciation = _checkAnnunciation(copticDate, cleanDate);
      if (annunciation != null) return annunciation;

      final lentEnd = EasterCalculator.palmSunday(year);
      final daysRemaining = lentEnd.difference(cleanDate).inDays;

      return DayRiteInfo(
        copticDate: copticDate,
        gregorianDate: cleanDate,
        rite: ChurchRite.lenten,
        fastName: 'الصوم الكبير المقدس',
        isFasting: true,
        fastDaysRemaining: daysRemaining,
        riteNameAr: 'صيامي',
      );
    }

    // 5. صوم وفصح يونان (نينوى)
    if (EasterCalculator.isInJonahFast(cleanDate)) {
      return DayRiteInfo(
        copticDate: copticDate,
        gregorianDate: cleanDate,
        rite: ChurchRite.lenten,
        fastName: 'صوم يونان (نينوى)',
        isFasting: true,
        riteNameAr: 'صيامي',
      );
    }
    if (_isSameDay(cleanDate, EasterCalculator.jonahPassover(year))) {
      return DayRiteInfo(
        copticDate: copticDate,
        gregorianDate: cleanDate,
        rite: ChurchRite.festive,
        feastName: 'فصح يونان',
        isFasting: false,
        riteNameAr: 'فرايحي',
      );
    }

    // 6. صوم الرسل (يبدأ الإثنين بعد العنصرة حتى 12 يوليو = 5 أبيب)
    if (EasterCalculator.isInApostlesFast(cleanDate)) {
      final apostlesEnd = EasterCalculator.apostlesFastEnd(year);
      final remaining = apostlesEnd.difference(cleanDate).inDays;
      return DayRiteInfo(
        copticDate: copticDate,
        gregorianDate: cleanDate,
        rite: ChurchRite.annual,
        fastName: 'صوم الرسل الأطهار',
        isFasting: true,
        fastDaysRemaining: remaining,
        riteNameAr: 'سنوي',
      );
    }

    // 7. شهر كيهك (الشهر الرابع القبطي)
    if (copticDate.month == 4) {
      // فحص الأعياد الثابتة داخل كيهك كالميلاد
      final fixedFeast = _checkFixedFeasts(copticDate, cleanDate);
      if (fixedFeast != null) return fixedFeast;

      final nativityEnd = _copticToGregorian(copticDate.year, 4, 28);
      final remaining = nativityEnd.difference(cleanDate).inDays;

      return DayRiteInfo(
        copticDate: copticDate,
        gregorianDate: cleanDate,
        rite: ChurchRite.kiahki,
        fastName: 'صوم الميلاد المجيد',
        isFasting: true,
        fastDaysRemaining: remaining > 0 ? remaining : 0,
        riteNameAr: 'كيهكي',
      );
    }

    // 8. الأعياد الثابتة (سيدية كبرى وصغرى)
    final fixedFeast = _checkFixedFeasts(copticDate, cleanDate);
    if (fixedFeast != null) return fixedFeast;

    // 9. الأصوام الثابتة (صوم الميلاد، صوم العذراء)
    final fixedFast = _checkFixedFasts(copticDate, cleanDate);
    if (fixedFast != null) return fixedFast;

    // 10. صوم الأربعاء والجمعة الأسبوعي
    if (cleanDate.weekday == DateTime.wednesday ||
        cleanDate.weekday == DateTime.friday) {
      return DayRiteInfo(
        copticDate: copticDate,
        gregorianDate: cleanDate,
        rite: ChurchRite.annual,
        isFasting: true,
        fastName: cleanDate.weekday == DateTime.wednesday
            ? 'صوم الأربعاء'
            : 'صوم الجمعة',
        riteNameAr: 'سنوي',
      );
    }

    // 11. طقس سنوي عادي
    return DayRiteInfo(
      copticDate: copticDate,
      gregorianDate: cleanDate,
      rite: ChurchRite.annual,
      riteNameAr: 'سنوي',
    );
  }

  /// التحقق من الأعياد السيدية الثابتة
  static DayRiteInfo? _checkFixedFeasts(CopticDate coptic, DateTime gregorian) {
    final m = coptic.month;
    final d = coptic.day;

    // عيد النيروز (رأس السنة القبطية وتذكار الشهداء): 1 توت
    if (m == 1 && d == 1) {
      return DayRiteInfo(
        copticDate: coptic,
        gregorianDate: gregorian,
        rite: ChurchRite.festive,
        feastName: 'عيد النيروز (رأس السنة القبطية وعيد الشهداء)',
        isMinorFeast: false,
        riteNameAr: 'فرايحي',
      );
    }

    // عيد الصليب المجيد: 17، 18، 19 توت
    if (m == 1 && (d >= 17 && d <= 19)) {
      return DayRiteInfo(
        copticDate: coptic,
        gregorianDate: gregorian,
        rite: ChurchRite.festive,
        feastName: 'تذكار ظهور الصليب المقدس',
        isMinorFeast: true,
        riteNameAr: 'فرايحي',
      );
    }

    // عيد الصليب الثاني: 10 برمهات
    if (m == 7 && d == 10) {
      return DayRiteInfo(
        copticDate: coptic,
        gregorianDate: gregorian,
        rite: ChurchRite.festive,
        feastName: 'تذكار ظهور الصليب المقدس',
        isMinorFeast: true,
        riteNameAr: 'فرايحي',
      );
    }

    // عيد الميلاد المجيد: 29 كيهك
    if (m == 4 && d == 29) {
      return DayRiteInfo(
        copticDate: coptic,
        gregorianDate: gregorian,
        rite: ChurchRite.festive,
        feastName: 'عيد الميلاد المجيد',
        isMajorFeast: true,
        isFasting: false,
        riteNameAr: 'فرايحي',
      );
    }

    // عيد الختان المجيد: 6 طوبة (من الأعياد السيدية الصغرى السبعة)
    if (m == 5 && d == 6) {
      return DayRiteInfo(
        copticDate: coptic,
        gregorianDate: gregorian,
        rite: ChurchRite.festive,
        feastName: 'عيد الختان المجيد',
        isMinorFeast: true,
        riteNameAr: 'فرايحي',
      );
    }

    // عيد الغطاس المجيد: 11 طوبة (من الأعياد السيدية الكبرى السبعة)
    if (m == 5 && d == 11) {
      return DayRiteInfo(
        copticDate: coptic,
        gregorianDate: gregorian,
        rite: ChurchRite.festive,
        feastName: 'عيد الغطاس المجيد (الثيؤفانيا)',
        isMajorFeast: true,
        isFasting: false,
        riteNameAr: 'فرايحي',
      );
    }

    // عرس قانا الجليل: 13 طوبة (من الأعياد السيدية الصغرى السبعة)
    if (m == 5 && d == 13) {
      return DayRiteInfo(
        copticDate: coptic,
        gregorianDate: gregorian,
        rite: ChurchRite.festive,
        feastName: 'عيد عرس قانا الجليل',
        isMinorFeast: true,
        riteNameAr: 'فرايحي',
      );
    }

    // دخول السيد المسيح الهيكل: 8 أمشير (من الأعياد السيدية الصغرى السبعة)
    if (m == 6 && d == 8) {
      return DayRiteInfo(
        copticDate: coptic,
        gregorianDate: gregorian,
        rite: ChurchRite.festive,
        feastName: 'عيد دخول السيد المسيح إلى الهيكل',
        isMinorFeast: true,
        riteNameAr: 'فرايحي',
      );
    }

    // عيد البشارة المجيد: 29 برمهات (إذا لم يكن في أسبوع الآلام)
    if (m == 7 && d == 29 && !EasterCalculator.isInPascha(gregorian)) {
      return DayRiteInfo(
        copticDate: coptic,
        gregorianDate: gregorian,
        rite: ChurchRite.festive,
        feastName: 'عيد البشارة المجيد',
        isMajorFeast: true,
        riteNameAr: 'فرايحي',
      );
    }

    // دخول السيد المسيح أرض مصر: 24 بشنس (من الأعياد السيدية الصغرى السبعة)
    if (m == 9 && d == 24) {
      return DayRiteInfo(
        copticDate: coptic,
        gregorianDate: gregorian,
        rite: ChurchRite.festive,
        feastName: 'عيد دخول السيد المسيح أرض مصر',
        isMinorFeast: true,
        riteNameAr: 'فرايحي',
      );
    }

    // عيد التجلي المجيد: 13 مسرى (من الأعياد السيدية الصغرى السبعة)
    if (m == 12 && d == 13) {
      return DayRiteInfo(
        copticDate: coptic,
        gregorianDate: gregorian,
        rite: ChurchRite.festive,
        feastName: 'عيد التجلي المجيد',
        isMinorFeast: true,
        riteNameAr: 'فرايحي',
      );
    }

    // عيد الرسل الأطهار: 5 أبيب
    if (m == 11 && d == 5) {
      return DayRiteInfo(
        copticDate: coptic,
        gregorianDate: gregorian,
        rite: ChurchRite.festive,
        feastName: 'عيد استشهاد القديسين بطرس وبولس (عيد الرسل)',
        isFasting: false,
        riteNameAr: 'فرايحي',
      );
    }

    // عيد صعود جسد السيدة العذراء: 16 مسرى
    if (m == 12 && d == 16) {
      return DayRiteInfo(
        copticDate: coptic,
        gregorianDate: gregorian,
        rite: ChurchRite.festive,
        feastName: 'عيد صعود جسد السيدة العذراء مريم',
        isFasting: false,
        riteNameAr: 'فرايحي',
      );
    }

    return null;
  }

  /// التحقق من الأصوام الثابتة (الميلاد والعذراء)
  static DayRiteInfo? _checkFixedFasts(CopticDate coptic, DateTime gregorian) {
    final m = coptic.month;
    final d = coptic.day;

    // صوم الميلاد المجيد: من 16 هاتور حتى 28 كيهك
    if (m == 3 && d >= 16) {
      final end = _copticToGregorian(coptic.year, 4, 28);
      final remaining = end.difference(gregorian).inDays;
      return DayRiteInfo(
        copticDate: coptic,
        gregorianDate: gregorian,
        rite: ChurchRite.annual,
        fastName: 'صوم الميلاد المجيد',
        isFasting: true,
        fastDaysRemaining: remaining > 0 ? remaining : 0,
        riteNameAr: 'سنوي',
      );
    }

    // صوم السيدة العذراء مريم: من 1 مسرى حتى 15 مسرى (15 يوماً)
    if (m == 12 && d >= 1 && d <= 15) {
      return DayRiteInfo(
        copticDate: coptic,
        gregorianDate: gregorian,
        rite: ChurchRite.annual,
        fastName: 'صوم السيدة العذراء مريم',
        isFasting: true,
        fastDaysRemaining: 16 - d,
        riteNameAr: 'سنوي',
      );
    }

    return null;
  }

  /// التحقق من تداخل عيد البشارة مع الصوم الكبير
  static DayRiteInfo? _checkAnnunciation(CopticDate coptic, DateTime gregorian) {
    if (coptic.month == 7 && coptic.day == 29) {
      if (EasterCalculator.isInPascha(gregorian)) {
        return null; // لا يُحتفل به إذا وقع في أسبوع الآلام
      }
      return DayRiteInfo(
        copticDate: coptic,
        gregorianDate: gregorian,
        rite: ChurchRite.festive,
        feastName: 'عيد البشارة المجيد',
        isMajorFeast: true,
        isFasting: true,
        fastName: 'الصوم الكبير المقدس',
        riteNameAr: 'فرايحي (داخل الصوم الكبير)',
      );
    }
    return null;
  }

  static bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static DateTime _copticToGregorian(int year, int month, int day) {
    return CopticDate(year: year, month: month, day: day).toGregorian();
  }
}
