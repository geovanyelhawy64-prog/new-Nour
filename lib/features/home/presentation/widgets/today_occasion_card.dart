import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/coptic_calendar/rite_determiner.dart';

class TodayOccasionCard extends StatelessWidget {
  final DayRiteInfo riteInfo;

  const TodayOccasionCard({
    super.key,
    required this.riteInfo,
  });

  @override
  Widget build(BuildContext context) {
    if (riteInfo.feastName == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.festiveColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.festiveColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.festiveColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.celebration_rounded,
              color: AppColors.festiveColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  riteInfo.feastName!,
                  style: AppTypography.heading3.copyWith(
                    color: AppColors.primaryDark,
                    fontSize: 16,
                  ),
                ),
                Text(
                  riteInfo.isMajorFeast
                      ? 'عيد سيدي كبير'
                      : (riteInfo.isMinorFeast ? 'عيد سيدي صغير' : 'تذكار كنسي'),
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
