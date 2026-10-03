import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

/// ويدجت تخطيط متجاوب للشاشات الكبيرة وأجهزة التابلت (Master-Detail Adaptive Layout)
class AdaptiveMasterDetail extends StatelessWidget {
  final Widget master;
  final Widget? detail;
  final String? emptyDetailMessage;
  final IconData emptyDetailIcon;
  final double breakpoint;
  final double masterWidth;

  const AdaptiveMasterDetail({
    super.key,
    required this.master,
    this.detail,
    this.emptyDetailMessage,
    this.emptyDetailIcon = Icons.auto_stories_rounded,
    this.breakpoint = 720,
    this.masterWidth = 360,
  });

  /// فحص هل الشاشة الحالية تابلت / شاشة عريضة
  static bool isTablet(BuildContext context, {double breakpoint = 720}) {
    return MediaQuery.sizeOf(context).width >= breakpoint;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= breakpoint) {
          final isDark = Theme.of(context).brightness == Brightness.dark;

          return Row(
            children: [
              // اللوحة الرئيسية (Master Pane)
              SizedBox(
                width: masterWidth,
                child: master,
              ),

              // فاصل عمودي كنسي أنيق
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
              ),

              // لوحة التفاصيل والقراءة (Detail Pane)
              Expanded(
                child: detail ??
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            emptyDetailIcon,
                            size: 64,
                            color: AppColors.primary.withValues(alpha: 0.4),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            emptyDetailMessage ?? 'اختر صلاة أو قراءة من القائمة لعرضها هنا مباشرة',
                            style: AppTypography.heading3.copyWith(
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
              ),
            ],
          );
        }

        // للهواتف العادية: عرض القائمة بشكل طبيعي
        return master;
      },
    );
  }
}
