import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

enum VerificationStatus {
  verified,
  needsReview,
}

/// شارة التحقق الكنسي من صحة النصوص المقدسة (Content Verification Badge)
/// توضح للمستخدم موثوقية النص الكنسي واعتماده
class VerificationBadge extends StatelessWidget {
  final VerificationStatus status;
  final bool compact;

  const VerificationBadge({
    super.key,
    this.status = VerificationStatus.verified,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isVerified = status == VerificationStatus.verified;
    final color = isVerified ? AppColors.success : const Color(0xFFF57C00);
    final icon = isVerified ? Icons.verified_rounded : Icons.info_outline_rounded;
    final label = isVerified ? 'نص كنسي معتمد' : 'قيد المراجعة';

    if (compact) {
      return Tooltip(
        message: label,
        child: Icon(icon, color: color, size: 16),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: color,
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
