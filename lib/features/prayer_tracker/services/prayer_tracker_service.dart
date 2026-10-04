import 'package:shared_preferences/shared_preferences.dart';

class AgpeyaHourInfo {
  final String id;
  final String title;
  final String subtitle;
  final String memorial;
  final String idealTime;

  const AgpeyaHourInfo({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.memorial,
    required this.idealTime,
  });
}

class PrayerTrackerService {
  static const List<AgpeyaHourInfo> canonicalHours = [
    AgpeyaHourInfo(
      id: 'prime',
      title: 'صلاة باكر',
      subtitle: 'الساعة الأولى من النهار',
      memorial: 'تذكار قيامة الرب يسوع ونوره الحقيقي المشرق في قلوبنا',
      idealTime: '6:00 ص',
    ),
    AgpeyaHourInfo(
      id: 'terce',
      title: 'صلاة الساعة الثالثة',
      subtitle: 'الساعة التاسعة صباحاً',
      memorial: 'تذكار محاكمة بيلاطس للمسيح وحلول الروح القدس على التلاميذ',
      idealTime: '9:00 ص',
    ),
    AgpeyaHourInfo(
      id: 'sext',
      title: 'صلاة الساعة السادسة',
      subtitle: 'وقت الظهيرة',
      memorial: 'تذكار صلب مخلصنا الصالح على عود الصليب لأجل فدائنا',
      idealTime: '12:00 م',
    ),
    AgpeyaHourInfo(
      id: 'none',
      title: 'صلاة الساعة التاسعة',
      subtitle: 'الساعة الثالثة بعد الظهر',
      memorial: 'تذكار الموت المحيي للسيد المسيح بالجسد وقبول اللص اليمين',
      idealTime: '3:00 م',
    ),
    AgpeyaHourInfo(
      id: 'vespers',
      title: 'صلاة الغروب',
      subtitle: 'الساعة الحادية عشرة',
      memorial: 'تذكار إنزال جسد المخلص الطاهر وتكفينه في المساء',
      idealTime: '5:00 م',
    ),
    AgpeyaHourInfo(
      id: 'compline',
      title: 'صلاة النوم',
      subtitle: 'الساعة الثانية عشرة',
      memorial: 'تذكار وضع جسد المسيح في القبر، وتأمل في انقضاء عمر الإنسان',
      idealTime: '9:00 م',
    ),
    AgpeyaHourInfo(
      id: 'midnight',
      title: 'صلاة نصف الليل',
      subtitle: 'الخدمات الثلاث',
      memorial: 'تذكار المجيء الثاني المخوف وسهر العذارى الحكيمات للقاء العريس',
      idealTime: '12:00 ص',
    ),
  ];

  static String _formatDate(DateTime date) {
    return '${date.year}_${date.month.toString().padLeft(2, '0')}_${date.day.toString().padLeft(2, '0')}';
  }

  /// الحصول على قائمة الصلوات المكتملة ليوم معين
  static Future<List<String>> getCompletedPrayersForDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'prayer_tracker_${_formatDate(date)}';
    return prefs.getStringList(key) ?? [];
  }

  /// تبديل حالة صلاة معينة (اكتملت / لم تكتمل)
  static Future<bool> togglePrayer(DateTime date, String hourId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'prayer_tracker_${_formatDate(date)}';
    final list = prefs.getStringList(key) ?? [];
    bool isCompletedNow;

    if (list.contains(hourId)) {
      list.remove(hourId);
      isCompletedNow = false;
    } else {
      list.add(hourId);
      isCompletedNow = true;
    }

    await prefs.setStringList(key, list);
    return isCompletedNow;
  }

  /// هل صلاة معينة مكتملة لليوم المحدد؟
  static Future<bool> isPrayerCompleted(DateTime date, String hourId) async {
    final completed = await getCompletedPrayersForDate(date);
    return completed.contains(hourId);
  }

  /// حساب عدد أيام الصلاة المتواصلة (Streak)
  static Future<int> calculateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    int streak = 0;
    DateTime checkDate = DateTime.now();

    // التحقق مما إذا كان اليوم قد صُلي فيه شيء
    final todayCompleted = await getCompletedPrayersForDate(checkDate);
    if (todayCompleted.isNotEmpty) {
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    } else {
      // إذا لم يصل اليوم بعد، نتحقق من الأمس حتى لا نقطع الستريك صباحاً
      final yesterday = checkDate.subtract(const Duration(days: 1));
      final yesterdayCompleted = await getCompletedPrayersForDate(yesterday);
      if (yesterdayCompleted.isNotEmpty) {
        checkDate = yesterday;
      } else {
        return 0;
      }
    }

    // العد التنازلي للأيام السابقة
    while (true) {
      final key = 'prayer_tracker_${_formatDate(checkDate)}';
      final list = prefs.getStringList(key) ?? [];
      if (list.isNotEmpty) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
      // حماية من الحلقات الطويلة
      if (streak > 3650) break;
    }

    return streak;
  }

  /// إحصائيات الأسبوع الأخير (7 أيام)
  static Future<Map<DateTime, int>> getWeeklyStats() async {
    final Map<DateTime, int> stats = {};
    final now = DateTime.now();
    for (int i = 6; i >= 0; i--) {
      final day = DateTime(now.year, now.month, now.day).subtract(Duration(days: i));
      final completed = await getCompletedPrayersForDate(day);
      stats[day] = completed.length;
    }
    return stats;
  }
}
