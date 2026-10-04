import 'package:flutter/animation.dart';

/// أنيميشن وتوقيتات الحركة السلسة في تطبيق نور
class NoorAnimations {
  NoorAnimations._();

  // فتح الشاشة
  static const Duration pageTransition = Duration(milliseconds: 250);
  static const Curve pageCurve = Curves.easeOutCubic;

  // فتح كارت
  static const Duration cardAppear = Duration(milliseconds: 200);
  static const Curve cardCurve = Curves.easeOut;

  // الضغط على زر
  static const Duration buttonPress = Duration(milliseconds: 100);

  // تبديل وضع النص
  static const Duration textModeSwitch = Duration(milliseconds: 200);

  // Dark/Light mode
  static const Duration themeSwitch = Duration(milliseconds: 400);

  // Fade in للعناصر
  static const Duration fadeIn = Duration(milliseconds: 300);

  // Scroll سلس
  static const Duration smoothScroll = Duration(milliseconds: 500);
  static const Curve scrollCurve = Curves.easeInOut;
}
