class AppConstants {
  AppConstants._();

  static const String appName = 'Noor';
  static const String appTitleAr = 'نور - التطبيق المسيحي الأرثوذكسي الشامل';
  static const String appVersion = '2.3.0';
  static const int currentDbVersion = 18;
  static const String prefInstalledDbVersion = 'installed_db_version';

  // التخزين والإعدادات
  static const String prefFontSize = 'font_size';
  static const String prefThemeMode = 'theme_mode';
  static const String prefLastBibleRead = 'last_bible_read';
  static const String prefFirstLaunch = 'first_launch';
  static const String prefLastAgpeyaHour = 'last_agpeya_hour';
  static const String prefShowTashkeel = 'show_tashkeel';
  static const String prefKeepScreenOn = 'keep_screen_on';
  static const String prefNotificationsEnabled = 'notifications_enabled';
  static const String prefDailyVerseHour = 'daily_verse_hour';
  static const String prefDailyVerseMinute = 'daily_verse_minute';
  static const String prefShowCoptic = 'show_coptic';
  static const String prefPrayerReminders = 'prayer_reminders';
  static const String prefPrayerReminderHour = 'prayer_reminder_hour';
  static const String prefPrayerReminderMinute = 'prayer_reminder_minute';
  static const String prefHapticHazat = 'haptic_hazat';

  // الخطوط الافتراضية
  static const double defaultFontSize = 20.0;
  static const double minFontSize = 14.0;
  static const double maxFontSize = 32.0;

  // معرفات قنوات الإشعارات
  static const String dailyVerseChannelId = 'daily_verse_channel';
  static const String dailyVerseChannelName = 'آية اليوم';
  static const String dailyVerseChannelDesc = 'إشعار يومي بآية من الكتاب المقدس';
  static const String prayerReminderChannelId = 'prayer_reminder_channel';
  static const String agpeyaChannelId = 'agpeya_channel';
  static const String feastsChannelId = 'feasts_channel';
}
