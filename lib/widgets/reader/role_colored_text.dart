import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

enum LiturgicalRole {
  priest,
  deacon,
  people,
  rubric,
  normal,
}

class RoleColoredText extends StatelessWidget {
  final String text;
  final LiturgicalRole role;
  final double? fontSize;
  final bool isCoptic;
  final FontWeight? fontWeight;

  const RoleColoredText({
    super.key,
    required this.text,
    this.role = LiturgicalRole.normal,
    this.fontSize,
    this.isCoptic = false,
    this.fontWeight,
  });

  Color _getColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (role) {
      case LiturgicalRole.priest:
        return AppColors.priest;
      case LiturgicalRole.deacon:
        return AppColors.deacon;
      case LiturgicalRole.people:
        return isDark ? const Color(0xFF81C784) : AppColors.people;
      case LiturgicalRole.rubric:
        return AppColors.rubric;
      case LiturgicalRole.normal:
        return isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    }
  }

  String _getRoleLabel() {
    switch (role) {
      case LiturgicalRole.priest:
        return 'الكاهن';
      case LiturgicalRole.deacon:
        return 'الشماس';
      case LiturgicalRole.people:
        return 'الشعب';
      case LiturgicalRole.rubric:
        return 'إرشاد طقسي';
      case LiturgicalRole.normal:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor(context);
    final font = isCoptic ? AppTypography.fontFamilyCoptic : AppTypography.fontFamily;
    final isRubric = role == LiturgicalRole.rubric;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (role != LiturgicalRole.normal && !isRubric)
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                _getRoleLabel(),
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: (fontSize ?? 16) * 0.75,
                  fontWeight: FontWeight.bold,
                  color: color.withValues(alpha: 0.8),
                ),
              ),
            ),
          SelectableText(
            text,
            style: TextStyle(
              fontFamily: font,
              fontSize: isRubric ? (fontSize ?? 16) * 0.88 : (fontSize ?? 16),
              color: color,
              fontWeight: fontWeight ?? (isRubric ? FontWeight.normal : FontWeight.w500),
              fontStyle: isRubric ? FontStyle.italic : FontStyle.normal,
              height: isCoptic ? 1.6 : 1.9,
            ),
          ),
        ],
      ),
    );
  }
}
