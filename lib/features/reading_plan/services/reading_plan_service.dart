import 'package:shared_preferences/shared_preferences.dart';
import '../data/reading_plans_data.dart';

class ReadingPlanService {
  static const String _activePlanKey = 'active_bible_reading_plan_id';

  /// الحصول على معرف الخطة النشطة
  static Future<String> getActivePlanId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_activePlanKey) ?? 'plan_whole_bible_365';
  }

  /// تغيير الخطة النشطة
  static Future<void> setActivePlanId(String planId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_activePlanKey, planId);
  }

  /// الحصول على قائمة الأيام المكتملة لخطة معينة
  static Future<List<int>> getCompletedDays(String planId) async {
    final prefs = await SharedPreferences.getInstance();
    final strList = prefs.getStringList('reading_plan_completed_$planId') ?? [];
    return strList.map((e) => int.tryParse(e) ?? 0).where((d) => d > 0).toList();
  }

  /// تبديل حالة يوم معين (مكتمل / غير مكتمل)
  static Future<bool> toggleDayCompleted(String planId, int dayNumber) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'reading_plan_completed_$planId';
    final strList = prefs.getStringList(key) ?? [];
    final dayStr = dayNumber.toString();
    bool isCompletedNow;

    if (strList.contains(dayStr)) {
      strList.remove(dayStr);
      isCompletedNow = false;
    } else {
      strList.add(dayStr);
      isCompletedNow = true;
    }

    await prefs.setStringList(key, strList);
    return isCompletedNow;
  }

  /// التحقق من اكتمال يوم معين
  static Future<bool> isDayCompleted(String planId, int dayNumber) async {
    final completed = await getCompletedDays(planId);
    return completed.contains(dayNumber);
  }

  /// الحصول على اليوم المقترح للقراءة حالياً (أول يوم غير مكتمل)
  static Future<int> getSuggestedDay(String planId) async {
    final completed = await getCompletedDays(planId);
    final plan = ReadingPlansData.plans.firstWhere(
      (p) => p.id == planId,
      orElse: () => ReadingPlansData.plans.first,
    );

    for (int d = 1; d <= plan.totalDays; d++) {
      if (!completed.contains(d)) {
        return d;
      }
    }
    return plan.totalDays;
  }

  /// حساب نسبة التقدم
  static Future<double> getProgress(String planId) async {
    final completed = await getCompletedDays(planId);
    final plan = ReadingPlansData.plans.firstWhere(
      (p) => p.id == planId,
      orElse: () => ReadingPlansData.plans.first,
    );
    if (plan.totalDays == 0) return 0.0;
    return (completed.length / plan.totalDays).clamp(0.0, 1.0);
  }

  /// إعادة تعيين تقدم الخطة
  static Future<void> resetPlan(String planId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('reading_plan_completed_$planId');
  }
}
