import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/coptic_calendar/coptic_date.dart';
import '../../../core/coptic_calendar/rite_determiner.dart';
import '../../../data/database/app_database.dart';
import '../../../data/models/coptic_day_info.dart';
import '../../../core/services/database_service.dart';

/// سياق الشاشة الذكية المتغير تلقائياً حسب الوقت من اليوم
class SmartTimeContext {
  final String periodGreeting;
  final String recommendedPrayerTitle;
  final String recommendedPrayerSubtitle;
  final String recommendedPrayerRoute;
  final IconData recommendedIcon;

  const SmartTimeContext({
    required this.periodGreeting,
    required this.recommendedPrayerTitle,
    required this.recommendedPrayerSubtitle,
    required this.recommendedPrayerRoute,
    required this.recommendedIcon,
  });

  factory SmartTimeContext.fromDateTime(DateTime dt) {
    final hour = dt.hour;
    if (hour >= 4 && hour < 11) {
      return const SmartTimeContext(
        periodGreeting: 'صباح الخير ونور القيامة',
        recommendedPrayerTitle: 'صلاة باكر',
        recommendedPrayerSubtitle: 'ابدأ يومك بنور المسيح الحقيقي وبركة الصباح',
        recommendedPrayerRoute: '/agpeya/hour/prime',
        recommendedIcon: Icons.wb_sunny_rounded,
      );
    } else if (hour >= 11 && hour < 15) {
      return const SmartTimeContext(
        periodGreeting: 'نهار مبارك وممتلئ نعمة',
        recommendedPrayerTitle: 'صلاة الساعة السادسة',
        recommendedPrayerSubtitle: 'تذكار صلب المسيح الفادي والقداس الإلهي',
        recommendedPrayerRoute: '/agpeya/hour/sext',
        recommendedIcon: Icons.church_rounded,
      );
    } else if (hour >= 15 && hour < 20) {
      return const SmartTimeContext(
        periodGreeting: 'مساء مبارك بسلام الرب',
        recommendedPrayerTitle: 'صلاة الغروب',
        recommendedPrayerSubtitle: 'تقديم الشكر عن بركات اليوم وعشية المساء',
        recommendedPrayerRoute: '/agpeya/hour/vespers',
        recommendedIcon: Icons.wb_twilight_rounded,
      );
    } else {
      return const SmartTimeContext(
        periodGreeting: 'ليلة هادئة بسلام المسيح',
        recommendedPrayerTitle: 'صلاة النوم',
        recommendedPrayerSubtitle: 'راحة النفس وطلب الحماية الإلهية لليل هادئ',
        recommendedPrayerRoute: '/agpeya/hour/compline',
        recommendedIcon: Icons.bedtime_rounded,
      );
    }
  }
}

final todayInfoProvider = Provider<CopticDayInfo>((ref) {
  final now = DateTime.now();
  final copticDate = CopticDate.fromGregorian(now);
  final riteInfo = RiteDeterminer.determineRite(now);

  return CopticDayInfo(
    copticDate: copticDate,
    gregorianDate: now,
    riteInfo: riteInfo,
  );
});

final smartTimeContextProvider = Provider<SmartTimeContext>((ref) {
  return SmartTimeContext.fromDateTime(DateTime.now());
});

final dailyVerseProvider = FutureProvider<DailyVerse?>((ref) async {
  final db = DatabaseService.instance;
  return db.dailyVerseDao.getTodayVerse();
});

final todayLiturgicalReadingsProvider = FutureProvider<List<KatamerosReading>>((ref) async {
  final db = DatabaseService.instance;
  final now = DateTime.now();
  final copticDate = CopticDate.fromGregorian(now);
  return db.katamerosDao.getLiturgicalReadingsForDate(now, copticDate);
});

final todaySynaxariumProvider = FutureProvider<List<SynaxariumEntry>>((ref) async {
  final db = DatabaseService.instance;
  final now = DateTime.now();
  final copticDate = CopticDate.fromGregorian(now);
  return db.synaxariumDao.getEntriesForDay(copticDate.month, copticDate.day);
});
