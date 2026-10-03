import 'package:flutter/material.dart';
import '../../app/theme/app_theme.dart' as app_theme_base;

export '../../app/theme/app_colors.dart';
export '../../app/theme/app_typography.dart';

/// الثيم المركزي الموحد لتطبيق نور
class AppTheme {
  AppTheme._();

  // === الألوان الأساسية المتفق عليها ===
  // Light Mode
  static const Color lightBg = Color(0xFFFAF6F0);
  static const Color lightText = Color(0xFF2D2D2D);
  static const Color lightGold = Color(0xFFC49B3C);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightDivider = Color(0xFFE8E0D0);

  // Dark Mode
  static const Color darkBg = Color(0xFF18130E);
  static const Color darkText = Color(0xFFE8DFD0);
  static const Color darkGold = Color(0xFFD4A843);
  static const Color darkCard = Color(0xFF211A13);
  static const Color darkDivider = Color(0xFF352A20);

  // === ثيم Light ===
  static ThemeData get lightTheme => app_theme_base.AppTheme.light();

  // === ثيم Dark ===
  static ThemeData get darkTheme => app_theme_base.AppTheme.dark();

  // === دوال مساعدة للوصول السريع للألوان حسب الثيم النشط ===
  static Color gold(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkGold : lightGold;

  static Color bg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkBg : lightBg;

  static Color text(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkText : lightText;

  static Color card(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkCard : lightCard;

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}
