import 'dart:io';
import 'package:flutter/services.dart';
import '../coptic_calendar/coptic_date.dart';
import 'database_service.dart';

class WidgetService {
  WidgetService._();

  static const MethodChannel _channel = MethodChannel('com.noor.noor_app/widget');

  /// تحديث ودجت الشاشة الرئيسية بآية اليوم والتاريخ القبطي
  static Future<bool> updateHomeScreenWidget() async {
    // يعمل على نظام أندرويد فقط
    try {
      if (!Platform.isAndroid) return false;
    } catch (_) {
      // في بيئة flutter_test قد يفشل فحص Platform
      return false;
    }

    try {
      final db = DatabaseService.instance;
      final verse = await db.dailyVerseDao.getTodayVerse();
      final now = DateTime.now();
      final copticDate = CopticDate.fromGregorian(now);

      final verseText = verse?.content ??
          '«أَنَا هُوَ نُورُ الْعَالَمِ. مَنْ يَتْبَعْنِي فَلاَ يَمْشِي فِي الظُّلْمَةِ بَلْ يَكُونُ لَهُ نُورُ الْحَيَاةِ»';
      final verseRef = verse != null && verse.reference.isNotEmpty
          ? '(${verse.reference})'
          : '(إنجيل يوحنا ٨ : ١٢)';
      final copticDateStr = '${copticDate.day} ${copticDate.monthName} ${copticDate.year} ش';

      final res = await _channel.invokeMethod<bool>('updateWidget', {
        'verseText': verseText,
        'verseRef': verseRef,
        'copticDate': copticDateStr,
      });

      return res ?? false;
    } catch (_) {
      // إخفاق صامت آمن دون التأثير على عمل التطبيق
      return false;
    }
  }
}
