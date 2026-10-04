import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/app.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';
import '../../core/services/preferences_service.dart';

/// زر القائمة السريعة الشاملة (⋮) المتاح في كافة الشاشات للتنقل الفوري والمشاركة
class AppQuickMenu extends StatelessWidget {
  const AppQuickMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert_rounded),
      tooltip: 'القائمة السريعة',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onSelected: (value) async {
        switch (value) {
          case 'search':
            context.push('/search');
            break;
          case 'toggle_theme':
            final next = isDark ? AppThemeType.light : AppThemeType.dark;
            try {
              final container = ProviderScope.containerOf(context, listen: false);
              container.read(appThemeProvider.notifier).state = next;
            } catch (_) {
              // Graceful fallback when rendered outside ProviderScope in isolated tests
            }
            await PreferencesService.setThemeMode(
              next == AppThemeType.light ? 'light' : 'dark',
            );
            break;
          case 'bookmarks':
            context.push('/bookmarks');
            break;
          case 'settings':
            context.push('/settings');
            break;
          case 'share':
            await _shareApp(context);
            break;
          case 'report':
            _showReportDialog(context);
            break;
          case 'about':
            _showAboutDialog(context);
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'search',
          child: Row(
            children: [
              Icon(Icons.search_rounded, size: 20),
              SizedBox(width: 12),
              Text('بحث شامل'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'toggle_theme',
          child: Row(
            children: [
              Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(isDark ? 'الوضع الفاتح ☀️' : 'الوضع الغامق 🌙'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'bookmarks',
          child: Row(
            children: [
              Icon(Icons.star_rounded, size: 20, color: AppColors.gold),
              SizedBox(width: 12),
              Text('المفضلة'),
            ],
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: 'share',
          child: Row(
            children: [
              Icon(Icons.share_rounded, size: 20, color: AppColors.primary),
              SizedBox(width: 12),
              Text('مشاركة التطبيق'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'report',
          child: Row(
            children: [
              Icon(Icons.flag_outlined, size: 20, color: Colors.orange),
              SizedBox(width: 12),
              Text('أبلغ عن ملاحظة / خطأ'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'settings',
          child: Row(
            children: [
              Icon(Icons.settings_outlined, size: 20),
              SizedBox(width: 12),
              Text('الإعدادات'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'about',
          child: Row(
            children: [
              Icon(Icons.info_outline_rounded, size: 20),
              SizedBox(width: 12),
              Text('عن التطبيق'),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _shareApp(BuildContext context) async {
    const text = 'تطبيق نور • Noor\n'
        'تطبيق مسيحي أرثوذكسي قبطي شامل (الكتاب المقدس، الأجبية، الخولاجي، القطمارس، السنكسار، الألحان بالهزات).\n'
        'يعمل أوفلاين سيادياً 100% بدون إعلانات وبدون اتصال بالإنترنت.';
    await Clipboard.setData(const ClipboardData(text: text));
    if (context.mounted) {
      HapticFeedback.lightImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم نسخ بيانات مشاركة التطبيق بنجاح!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) =>  AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.verified_user_rounded, color: AppColors.gold, size: 24),
              SizedBox(width: 8),
              Text('إبلاغ عن ملاحظة كنسية'),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'حرصاً على أمانة ودقة النصوص الطقسية والكنسية والتشكيل، نراجع كل كلمة بمطابقتها مع الطبعات المعتمدة للأديرة القبطية.',
                style: AppTypography.bodySmall,
              ),
              SizedBox(height: 12),
              Text(
                'لإرسال أي تصحيح أو اقتراح للمطور (Geovany Elhawy)، يرجى تدوين الملاحظة واسم السفر أو اللحن وسيتم فحصها فوراً.',
                style: AppTypography.caption,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('إغلاق'),
            ),
          ],
        ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) =>  AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'N',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text('Noor • نور'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'تطبيق مسيحي أرثوذكسي قبطي شامل، مجاني وبدون إعلانات وبدون اتصال بالإنترنت.',
                style: AppTypography.bodySmall,
              ),
              const SizedBox(height: 12),
              const Text(
                'الإصدار: 2.2.0 (النسخة الكنسية الكبرى الشاملة)',
                style: AppTypography.caption,
              ),
              const SizedBox(height: 4),
              const Text(
                'عمل أوفلاين سيادي 100%',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const Divider(height: 24),
              Row(
                children: [
                  const Icon(
                    Icons.code_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'المطور: Geovany Elhawy',
                    style: AppTypography.caption.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('إغلاق'),
            ),
          ],
        ),
    );
  }
}
