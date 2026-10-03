import 'package:flutter/material.dart';

/// توقيت موحد للحركة مع احترام إعداد تقليل الحركة في النظام.
class NoorAnimations {
  NoorAnimations._();

  static const Duration fast = Duration(milliseconds: 200);
  static const Duration standard = Duration(milliseconds: 250);
  static const Duration emphasized = Duration(milliseconds: 350);
  static const Curve curve = Curves.easeOutCubic;

  static const Duration pageTransition = standard;
  static const Curve pageCurve = curve;
  static const Duration cardAppear = fast;
  static const Curve cardCurve = curve;
  static const Duration buttonPress = fast;
  static const Duration textModeSwitch = fast;
  static const Duration themeSwitch = emphasized;
  static const Duration fadeIn = standard;
  static const Duration smoothScroll = emphasized;
  static const Curve scrollCurve = curve;

  static bool reduceMotion(BuildContext context) {
    final media = MediaQuery.maybeOf(context);
    return media?.disableAnimations == true ||
        media?.accessibleNavigation == true;
  }

  static Duration effective(
    BuildContext context, [
    Duration preferred = standard,
  ]) {
    return reduceMotion(context) ? Duration.zero : preferred;
  }
}
