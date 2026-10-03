import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/app/theme/app_colors.dart';
import 'package:noor_app/app/theme/app_theme.dart';
import 'package:noor_app/core/theme/accessibility_contrast.dart';
import 'package:noor_app/core/theme/app_animations.dart';

void main() {
  test('ألوان النص الأساسية تحقق WCAG AA في الأوضاع الثلاثة', () {
    expect(
      AccessibilityContrast.meetsNormalText(
        AppColors.textPrimaryLight,
        AppColors.backgroundLight,
      ),
      isTrue,
    );
    expect(
      AccessibilityContrast.meetsNormalText(
        AppColors.textPrimaryDark,
        AppColors.backgroundDark,
      ),
      isTrue,
    );
    expect(
      AccessibilityContrast.meetsNormalText(
        AppColors.textPrimaryAmoled,
        AppColors.backgroundAmoled,
      ),
      isTrue,
    );
  });

  test('الذهبي في وضع الشموع يحقق تباين النص الطبيعي', () {
    expect(
      AccessibilityContrast.ratio(
        AppColors.primaryLight,
        AppColors.backgroundDark,
      ),
      greaterThanOrEqualTo(4.5),
    );
  });

  test('الثيم يفرض هدف لمس لا يقل عن 48', () {
    final themes = [AppTheme.light(), AppTheme.dark(), AppTheme.amoled()];
    for (final theme in themes) {
      final minimum = theme.iconButtonTheme.style?.minimumSize?.resolve({});
      expect(minimum?.width, greaterThanOrEqualTo(48));
      expect(minimum?.height, greaterThanOrEqualTo(48));
    }
  });

  testWidgets('تقليل الحركة يلغي مدة الانتقال', (tester) async {
    late BuildContext context;
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: Builder(
          builder: (buildContext) {
            context = buildContext;
            return const SizedBox();
          },
        ),
      ),
    );
    expect(NoorAnimations.effective(context), Duration.zero);
  });
}
