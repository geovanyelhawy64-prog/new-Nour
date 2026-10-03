import 'coptic_date.dart';
import 'rite_determiner.dart';

/// المحرك الشامل للتقويم والطقوس القبطية
class CopticCalendarEngine {
  CopticCalendarEngine._();

  /// الحصول على تفاصيل اليوم الحالي كاملة
  static DayRiteInfo getToday() {
    return getDayInfo(DateTime.now());
  }

  /// الحصول على تفاصيل تاريخ ميلادي معين
  static DayRiteInfo getDayInfo(DateTime date) {
    return RiteDeterminer.determineRite(date);
  }

  /// الحصول على تفاصيل اليوم الليتورجي (اسم بديل)
  static DayRiteInfo getLiturgicalDayInfo(DateTime date) {
    return getDayInfo(date);
  }

  /// الحصول على تفاصيل تاريخ قبطي معين
  static DayRiteInfo getCopticDayInfo(CopticDate copticDate) {
    final gregorian = copticDate.toGregorian();
    return RiteDeterminer.determineRite(gregorian);
  }

  /// هل اليوم الحالي يوم صوم
  static bool isTodayFasting() {
    return getToday().isFasting;
  }

  /// الأعياد والمناسبات القادمة لـ 30 يوماً
  static List<DayRiteInfo> getUpcomingFeasts([int daysAhead = 30]) {
    final list = <DayRiteInfo>[];
    final today = DateTime.now();

    for (int i = 0; i < daysAhead; i++) {
      final d = DateTime(today.year, today.month, today.day + i);
      final info = getDayInfo(d);
      if (info.feastName != null || info.isMajorFeast || info.isMinorFeast) {
        list.add(info);
      }
    }
    return list;
  }
}
