import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/coptic_calendar/rite_determiner.dart';

class FastingStatusCard extends StatelessWidget {
  final DayRiteInfo riteInfo;

  const FastingStatusCard({
    super.key,
    required this.riteInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lentenColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.lentenColor.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.lentenColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.restaurant_menu_rounded,
              color: AppColors.lentenColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  riteInfo.fastName ?? 'يوم صوم مبارك',
                  style: AppTypography.heading3.copyWith(
                    color: AppColors.lentenColor,
                    fontSize: 16,
                  ),
                ),
                if (riteInfo.fastDaysRemaining != null && riteInfo.fastDaysRemaining! > 0) ...[
                  const SizedBox(height: 2),
                  Text(
                    'متبقي ${riteInfo.fastDaysRemaining} يوماً على العيد',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondaryLight,
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
