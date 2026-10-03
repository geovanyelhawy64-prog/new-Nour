import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/coptic_calendar/coptic_date.dart';
import '../../../../core/coptic_calendar/rite_determiner.dart';
import '../../../../core/utils/date_utils.dart';

class CopticDateCard extends StatelessWidget {
  final CopticDate copticDate;
  final DayRiteInfo riteInfo;

  const CopticDateCard({
    super.key,
    required this.copticDate,
    required this.riteInfo,
  });

  @override
  Widget build(BuildContext context) {
    final riteColor = _getRiteColor();

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            riteColor.withValues(alpha: 0.15),
            riteColor.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: riteColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          // التاريخ القبطي
          Text(
            '${copticDate.day} ${copticDate.monthName}',
            style: AppTypography.heading1.copyWith(
              color: riteColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'سنة ${copticDate.year} للشهداء الأطهار',
            style: AppTypography.bodyMedium.copyWith(
              color: riteColor.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 8),
          // التاريخ الميلادي
          Text(
            AppDateUtils.formatGregorianWithDay(copticDate.toGregorian()),
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 12),
          // الطقس
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: riteColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'طقس ${riteInfo.riteNameAr}',
              style: AppTypography.bodySmall.copyWith(
                color: riteColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getRiteColor() {
    switch (riteInfo.rite) {
      case ChurchRite.festive:
      case ChurchRite.joyous:
        return AppColors.festiveColor;
      case ChurchRite.lenten:
        return AppColors.lentenColor;
      case ChurchRite.kiahki:
        return AppColors.kiahkiColor;
      case ChurchRite.pascha:
        return AppColors.paschaColor;
      case ChurchRite.annual:
        return AppColors.annualColor;
    }
  }
}
