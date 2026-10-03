import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';
import 'verse_image_share_dialog.dart';

class QuoteCardDialog extends StatelessWidget {
  final String text;
  final String reference;
  final String? subtitle;

  const QuoteCardDialog({
    super.key,
    required this.text,
    required this.reference,
    this.subtitle,
  });

  static Future<void> show(
    BuildContext context, {
    required String text,
    required String reference,
    String? subtitle,
  }) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => QuoteCardDialog(
        text: text,
        reference: reference,
        subtitle: subtitle,
      ),
    );
  }

  void _copyToClipboard(BuildContext context) {
    HapticFeedback.lightImpact();
    final buffer = StringBuffer();
    buffer.writeln('╭───────────────────────────────╮');
    buffer.writeln('         تطبيق نـور • NOOR      ');
    buffer.writeln('╰───────────────────────────────╯');
    buffer.writeln();
    buffer.writeln('« $text »');
    buffer.writeln();
    buffer.writeln('— $reference');
    if (subtitle != null && subtitle!.isNotEmpty) {
      buffer.writeln('($subtitle)');
    }
    buffer.writeln();
    buffer.writeln(' تطبيق نور الأرثوذكسي الشامل بدون إنترنت ');

    Clipboard.setData(ClipboardData(text: buffer.toString()));
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ البطاقة بالكامل بنجاح للمشاركة! '),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      const Color(0xFF1E1E26),
                      const Color(0xFF16161C),
                    ]
                  : [
                      const Color(0xFFFFFDF8),
                      const Color(0xFFF9F5EC),
                    ],
            ),
            border: Border.all(
              color: AppColors.gold.withValues(alpha: 0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // الهيدر والزخرفة
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: 32,
                    color: AppColors.gold.withValues(alpha: 0.5),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.church_rounded, color: AppColors.gold, size: 28),
                  ),
                  Container(
                    height: 1,
                    width: 32,
                    color: AppColors.gold.withValues(alpha: 0.5),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'تطبيق نـور • NOOR',
                style: AppTypography.caption.copyWith(
                  color: AppColors.gold,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 18),

              // نص الآية / القول
              Flexible(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.03)
                          : AppColors.primary.withValues(alpha: 0.03),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.gold.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Text(
                      '« $text »',
                      style: AppTypography.scripture.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.8,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // الشاهد / المرجع
              Text(
                reference,
                style: AppTypography.heading3.copyWith(
                  fontSize: 15,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              if (subtitle != null && subtitle!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],

              const SizedBox(height: 24),
              const Divider(height: 1),
              const SizedBox(height: 16),

              // أزرار المشاركة والإغلاق
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: Colors.black,
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                icon: const Icon(Icons.image_rounded, size: 20),
                label: const Text(
                  'مشاركة كصورة (1080x1080)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  VerseImageShareDialog.show(
                    context,
                    text: text,
                    reference: reference,
                    subtitle: subtitle,
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(vertical: 11),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('إغلاق'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(vertical: 11),
                      ),
                      icon: const Icon(Icons.copy_all_rounded, size: 18),
                      label: const Text('نسخ النص'),
                      onPressed: () => _copyToClipboard(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
