import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_strings.dart';

/// مساعد مشاركة ونسخ النصوص والآيات الكنسية مع التوثيق
class ShareHelper {
  ShareHelper._();

  /// نسخ النص مع الشاهد واسم التطبيق إلى الحافظة
  static Future<void> copyWithAttribution(
    BuildContext context, {
    required String text,
    String? reference,
    String? sourceTitle,
  }) async {
    final buffer = StringBuffer();
    buffer.writeln('«$text»');

    if (reference != null && reference.isNotEmpty) {
      buffer.writeln();
      buffer.write('— $reference');
    }

    if (sourceTitle != null && sourceTitle.isNotEmpty) {
      buffer.write(' ($sourceTitle)');
    }

    buffer.writeln();
    buffer.write('نور - تطبيق مسيحي أرثوذكسي شامل');

    await Clipboard.setData(ClipboardData(text: buffer.toString()));

    if (context.mounted) {
      HapticFeedback.lightImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.copiedToClipboard),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
