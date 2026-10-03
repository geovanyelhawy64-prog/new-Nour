import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import '../constants/app_constants.dart';
import 'logger_service.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _isInitialized = false;

  NotificationService._();

  static bool get isInitialized => _isInitialized;

  static Future<void> init([FlutterLocalNotificationsPlugin? mockPlugin]) async {
    if (mockPlugin != null) {
      _isInitialized = true;
      return;
    }

    try {
      tz_data.initializeTimeZones();

      const androidSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );

      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const settings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _plugin.initialize(
        settings,
        onDidReceiveNotificationResponse: (response) {
          // التعامل مع النقر على الإشعار للتوجيه المباشر
        },
      );

      // طلب الصلاحية على أندرويد 13+
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();

      _isInitialized = true;
    } catch (e, st) {
      LoggerService.error('فشل تهيئة خدمة الإشعارات', e, st);
      // السماح بتجاوز التهيئة في بيئات الاختبار بدون تعطل
      _isInitialized = true;
    }
  }

  /// إظهار إشعار فوري
  static Future<void> showInstantNotification({
    int id = 100,
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      await _plugin.show(
        id,
        title,
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            AppConstants.dailyVerseChannelId,
            AppConstants.dailyVerseChannelName,
            channelDescription: AppConstants.dailyVerseChannelDesc,
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(presentAlert: true, presentSound: true),
        ),
        payload: payload,
      );
    } catch (e, st) {
      LoggerService.error('فشل إظهار الإشعار الفوري', e, st);
    }
  }

  /// جدولة إشعار آية اليوم
  static Future<void> scheduleDailyVerse({
    int hour = 8,
    int minute = 0,
    String title = 'Noor - آية اليوم',
    String body = 'اضغط لقراءة آية اليوم والتأمل في كلمة الله الحية',
  }) async {
    try {
      await _plugin.zonedSchedule(
        0, // معرف إشعار آية اليوم
        title,
        body,
        nextScheduledTime(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            AppConstants.dailyVerseChannelId,
            AppConstants.dailyVerseChannelName,
            channelDescription: AppConstants.dailyVerseChannelDesc,
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
            styleInformation: BigTextStyleInformation(''),
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'daily_verse',
      );
    } catch (e, st) {
      LoggerService.error('فشل جدولة إشعار آية اليوم', e, st);
    }
  }

  /// جدولة تذكير بموعد الصلاة اليومية المخصص
  static Future<void> scheduleDailyPrayerReminder({
    int hour = 9,
    int minute = 0,
    String title = 'تذكير بالصلاة والتأمل',
    String body = 'حان وقت الخلوة والصلاة ورفع القلب إلى الرب يسوع المسيح.',
  }) async {
    try {
      await _plugin.zonedSchedule(
        1, // معرف تذكير الصلاة المخصص
        title,
        body,
        nextScheduledTime(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'prayer_reminder_channel',
            'تذكير الصلوات',
            channelDescription: 'تذكير يومي بمواعيد الصلاة والخلوة',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'daily_prayer',
      );
    } catch (e, st) {
      LoggerService.error('فشل جدولة تذكير الصلاة اليومية', e, st);
    }
  }

  /// جدولة تذكير بصلوات الساعات (الأجبية)
  static Future<void> scheduleAgpeyaReminder({
    required int id,
    required String hourName,
    required int hour,
    required int minute,
  }) async {
    try {
      await _plugin.zonedSchedule(
        id,
        'تذكير بصلاة الأجبية',
        'حان الآن موعد صلاة $hourName. فلنرفع قلوبنا بالصلاة.',
        nextScheduledTime(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'agpeya_channel',
            'صلوات الأجبية',
            channelDescription: 'تذكير بمواعيد صلوات الساعات',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(presentAlert: true, presentSound: true),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'agpeya_$id',
      );
    } catch (e, st) {
      LoggerService.error('فشل جدولة تذكير صلاة الأجبية', e, st);
    }
  }

  /// جدولة تنبيه بمناسبة أو عيد كنسي
  static Future<void> scheduleFeastAlert({
    required int id,
    required String feastName,
    required DateTime date,
  }) async {
    try {
      final tzDate = tz.TZDateTime.from(date, tz.local);
      if (tzDate.isBefore(tz.TZDateTime.now(tz.local))) return;

      await _plugin.zonedSchedule(
        id,
        'عيد ومناسبة كنسية مباركة',
        'غداً تحتفل الكنيسة بـ: $feastName. بركة شفاعته/صلواته تكون معنا.',
        tzDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'feasts_channel',
            'الأعياد والمناسبات القبطية',
            channelDescription: 'تنبيهات بمواعيد الأعياد والأصوام الكنسية',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(presentAlert: true, presentSound: true),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: 'feast_$id',
      );
    } catch (e, st) {
      LoggerService.error('فشل جدولة تنبيه العيد الكنسي', e, st);
    }
  }

  /// حساب التوقيت القادم بدقة
  static tz.TZDateTime nextScheduledTime(int hour, int minute) {
    try {
      tz.local;
    } catch (_) {
      tz_data.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation('UTC'));
    }
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  /// جدولة التذكير بصلوات الأجبية السبع كاملة
  static Future<void> scheduleAllAgpeyaReminders() async {
    final prayers = [
      (id: 11, name: 'باكر', hour: 6, min: 0),
      (id: 12, name: 'الساعة الثالثة', hour: 9, min: 0),
      (id: 13, name: 'الساعة السادسة', hour: 12, min: 0),
      (id: 14, name: 'الساعة التاسعة', hour: 15, min: 0),
      (id: 15, name: 'الغروب (الحادية عشرة)', hour: 17, min: 0),
      (id: 16, name: 'النوم (الثانية عشرة)', hour: 21, min: 0),
      (id: 17, name: 'نصف الليل', hour: 0, min: 0),
    ];

    for (final p in prayers) {
      await scheduleAgpeyaReminder(
        id: p.id,
        hourName: p.name,
        hour: p.hour,
        minute: p.min,
      );
    }
  }

  /// جدولة تنبيهات أصوام الأربعاء والجمعة الأسبوعية
  static Future<void> scheduleWeeklyFastingAlerts() async {
    // تنبيه مساء الثلاثاء لصوم الأربعاء
    await _scheduleWeeklyAlert(
      id: 201,
      title: 'تذكير بصوم يوم الأربعاء',
      body: 'غداً الأربعاء، صوم أسبوعي مبارك وتذكار تسليم وبيع يهوذا للمخلص بالفضة.',
      dayOfWeek: DateTime.tuesday,
      hour: 20,
      minute: 0,
      payload: 'fasting_wednesday',
    );

    // تنبيه مساء الخميس لصوم الجمعة
    await _scheduleWeeklyAlert(
      id: 202,
      title: 'تذكير بصوم يوم الجمعة العظيمة الأسبوعية',
      body: 'غداً الجمعة، يوم صوم وتأمل في آلام الفداء وموت الرب بالجسد على عود الصليب.',
      dayOfWeek: DateTime.thursday,
      hour: 20,
      minute: 0,
      payload: 'fasting_friday',
    );
  }

  static Future<void> _scheduleWeeklyAlert({
    required int id,
    required String title,
    required String body,
    required int dayOfWeek,
    required int hour,
    required int minute,
    required String payload,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    while (scheduled.weekday != dayOfWeek || scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    try {
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        scheduled,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'feasts_channel',
            'الأعياد والأصوام القبطية',
            channelDescription: 'تنبيهات بمواعيد الأصوام الأسبوعية والأعياد',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(presentAlert: true, presentSound: true),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        payload: payload,
      );
    } catch (e, st) {
      LoggerService.error('فشل جدولة التذكير الأسبوعي', e, st);
    }
  }

  /// تفعيل كل التنبيهات الروحية الافتراضية
  static Future<void> scheduleAllDefaultSpiritualReminders() async {
    await scheduleDailyVerse(hour: 8, minute: 0);
    await scheduleAllAgpeyaReminders();
    await scheduleWeeklyFastingAlerts();
  }

  /// إلغاء كل الإشعارات
  static Future<void> cancelAll() async {
    try {
      await _plugin.cancelAll();
    } catch (e, st) {
      LoggerService.error('فشل إلغاء كل الإشعارات', e, st);
    }
  }
}
