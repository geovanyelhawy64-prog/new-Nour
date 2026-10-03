import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  static const String fontFamily = 'Cairo';
  static const String copticFontFamily = 'Antinoou';
  static const String fontFamilyCoptic = 'Antinoou';
  static const String notationFontFamily = 'NoorNotation';

  // العناوين
  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // النصوص الأساسية (مطابقة لقاعدة: حجم الخط الأساسي ≥ 18 ومسافة السطور ≥ 1.8)
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1.8,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.8,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.8,
  );

  // نص القراءة (آيات وصلوات)
  static const TextStyle scripture = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 2.0,
    letterSpacing: 0.3,
  );

  // النص القبطي
  static const TextStyle coptic = TextStyle(
    fontFamily: copticFontFamily,
    fontFamilyFallback: [fontFamily, 'sans-serif'],
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1.8,
  );

  // النص المعرب
  static const TextStyle phonetic = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.8,
    color: Color(0xFF5D4037),
  );

  // التعليمات الطقسية
  static const TextStyle rubric = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    height: 1.6,
  );

  // رقم الآية
  static const TextStyle verseNumber = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.0,
  );

  // التسمية التوضيحية
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );
}
