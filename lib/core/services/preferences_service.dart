import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class PreferencesService {
  static late SharedPreferences _prefs;

  PreferencesService._();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ========== حجم الخط ==========
  static double getFontSize() {
    return _prefs.getDouble(AppConstants.prefFontSize) ?? AppConstants.defaultFontSize;
  }

  static Future<void> setFontSize(double size) async {
    final clamped = size.clamp(AppConstants.minFontSize, AppConstants.maxFontSize);
    await _prefs.setDouble(AppConstants.prefFontSize, clamped);
  }

  // ========== وضع الثيم (light / dark / system) ==========
  static String getThemeMode() {
    return _prefs.getString(AppConstants.prefThemeMode) ?? 'system';
  }

  static Future<void> setThemeMode(String mode) async {
    await _prefs.setString(AppConstants.prefThemeMode, mode);
  }

  // ========== آخر قراءة في الكتاب المقدس ==========
  static String? getLastBibleRead() {
    return _prefs.getString(AppConstants.prefLastBibleRead);
  }

  static Future<void> setLastBibleRead(int bookId, int chapter) async {
    await _prefs.setString(
      AppConstants.prefLastBibleRead,
      '$bookId:$chapter',
    );
  }

  // ========== آخر صلاة في الأجبية ==========
  static String? getLastAgpeyaHour() {
    return _prefs.getString(AppConstants.prefLastAgpeyaHour);
  }

  static Future<void> setLastAgpeyaHour(String hourId) async {
    await _prefs.setString(AppConstants.prefLastAgpeyaHour, hourId);
  }

  // ========== أول استخدام ==========
  static bool isFirstLaunch() {
    return _prefs.getBool(AppConstants.prefFirstLaunch) ?? true;
  }

  static Future<void> setFirstLaunchDone() async {
    await _prefs.setBool(AppConstants.prefFirstLaunch, false);
  }

  // ========== إظهار التشكيل ==========
  static bool getShowTashkeel() {
    return _prefs.getBool(AppConstants.prefShowTashkeel) ?? true;
  }

  static Future<void> setShowTashkeel(bool value) async {
    await _prefs.setBool(AppConstants.prefShowTashkeel, value);
  }

  // ========== إبقاء الشاشة مضاءة ==========
  static bool getKeepScreenOn() {
    return _prefs.getBool(AppConstants.prefKeepScreenOn) ?? true;
  }

  static Future<void> setKeepScreenOn(bool value) async {
    await _prefs.setBool(AppConstants.prefKeepScreenOn, value);
  }

  // ========== التنبيهات والإشعارات ==========
  static bool getNotificationsEnabled() {
    return _prefs.getBool(AppConstants.prefNotificationsEnabled) ?? true;
  }

  static Future<void> setNotificationsEnabled(bool value) async {
    await _prefs.setBool(AppConstants.prefNotificationsEnabled, value);
  }

  static int getDailyVerseHour() {
    return _prefs.getInt(AppConstants.prefDailyVerseHour) ?? 8;
  }

  static int getDailyVerseMinute() {
    return _prefs.getInt(AppConstants.prefDailyVerseMinute) ?? 0;
  }

  static Future<void> setDailyVerseTime(int hour, int minute) async {
    await _prefs.setInt(AppConstants.prefDailyVerseHour, hour);
    await _prefs.setInt(AppConstants.prefDailyVerseMinute, minute);
  }

  // ========== عرض النصوص القبطية ==========
  static bool getShowCoptic() {
    return _prefs.getBool(AppConstants.prefShowCoptic) ?? true;
  }

  static Future<void> setShowCoptic(bool value) async {
    await _prefs.setBool(AppConstants.prefShowCoptic, value);
  }

  // ========== تذكيرات صلوات الأجبية ==========
  static bool getPrayerReminders() {
    return _prefs.getBool(AppConstants.prefPrayerReminders) ?? true;
  }

  static Future<void> setPrayerReminders(bool value) async {
    await _prefs.setBool(AppConstants.prefPrayerReminders, value);
  }

  static int getPrayerReminderHour() {
    return _prefs.getInt(AppConstants.prefPrayerReminderHour) ?? 9;
  }

  static int getPrayerReminderMinute() {
    return _prefs.getInt(AppConstants.prefPrayerReminderMinute) ?? 0;
  }

  static Future<void> setPrayerReminderTime(int hour, int minute) async {
    await _prefs.setInt(AppConstants.prefPrayerReminderHour, hour);
    await _prefs.setInt(AppConstants.prefPrayerReminderMinute, minute);
  }

  // ========== اهتزاز الهزات في الألحان ==========
  static bool getHapticHazat() {
    return _prefs.getBool(AppConstants.prefHapticHazat) ?? true;
  }

  static Future<void> setHapticHazat(bool value) async {
    await _prefs.setBool(AppConstants.prefHapticHazat, value);
  }

  // ========== إعادة ضبط الإعدادات ==========
  static Future<void> resetToDefaults() async {
    await setFontSize(AppConstants.defaultFontSize);
    await setThemeMode('system');
    await setShowTashkeel(true);
    await setKeepScreenOn(true);
    await setNotificationsEnabled(true);
    await setDailyVerseTime(8, 0);
    await setShowCoptic(true);
    await setPrayerReminders(true);
    await setPrayerReminderTime(9, 0);
    await setHapticHazat(true);
  }
}
