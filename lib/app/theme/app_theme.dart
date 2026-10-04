import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTypography.fontFamily,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.accent,
        surface: AppColors.surfaceLight,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.textPrimaryLight,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimaryLight,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors.divider.withValues(alpha: 0.5),
          ),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondaryLight,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 0.5,
        space: 0,
      ),
      textTheme: const TextTheme(
        headlineLarge: AppTypography.heading1,
        headlineMedium: AppTypography.heading2,
        headlineSmall: AppTypography.heading3,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelSmall: AppTypography.caption,
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTypography.fontFamily,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        onPrimary: AppColors.backgroundDark,
        secondary: AppColors.accent,
        surface: AppColors.surfaceDark,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        foregroundColor: AppColors.textPrimaryDark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimaryDark,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors.dividerDark.withValues(alpha: 0.5),
          ),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.textSecondaryDark,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: 0.5,
        space: 0,
      ),
    );
  }

  static ThemeData sepia() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTypography.fontFamily,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primarySepia,
        onPrimary: Colors.white,
        secondary: AppColors.primarySepia,
        surface: AppColors.surfaceSepia,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.backgroundSepia,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundSepia,
        foregroundColor: AppColors.textPrimarySepia,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimarySepia,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceSepia,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors.dividerSepia.withValues(alpha: 0.7),
          ),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceSepia,
        selectedItemColor: AppColors.primarySepia,
        unselectedItemColor: AppColors.textSecondarySepia,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerSepia,
        thickness: 0.5,
        space: 0,
      ),
    );
  }

  static ThemeData amoled() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTypography.fontFamily,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryAmoled,
        onPrimary: Colors.black,
        secondary: AppColors.primaryAmoled,
        surface: AppColors.surfaceAmoled,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.backgroundAmoled,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundAmoled,
        foregroundColor: AppColors.textPrimaryAmoled,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimaryAmoled,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceAmoled,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors.dividerAmoled.withValues(alpha: 0.8),
          ),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.backgroundAmoled,
        selectedItemColor: AppColors.primaryAmoled,
        unselectedItemColor: AppColors.textSecondaryAmoled,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerAmoled,
        thickness: 0.5,
        space: 0,
      ),
    );
  }
}
