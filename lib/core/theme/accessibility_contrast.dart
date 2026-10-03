import 'dart:math' as math;

import 'package:flutter/material.dart';

class AccessibilityContrast {
  AccessibilityContrast._();

  static double ratio(Color first, Color second) {
    final lighter = math.max(_luminance(first), _luminance(second));
    final darker = math.min(_luminance(first), _luminance(second));
    return (lighter + 0.05) / (darker + 0.05);
  }

  static bool meetsNormalText(Color foreground, Color background) =>
      ratio(foreground, background) >= 4.5;

  static double _luminance(Color color) {
    double channel(double value) =>
        value <= 0.04045 ? value / 12.92 : math.pow((value + 0.055) / 1.055, 2.4).toDouble();
    final red = channel(color.r);
    final green = channel(color.g);
    final blue = channel(color.b);
    return 0.2126 * red + 0.7152 * green + 0.0722 * blue;
  }
}
