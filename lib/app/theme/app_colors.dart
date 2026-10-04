import 'package:flutter/material.dart';

/// نظام الألوان الكنسي المريح للعين (Eye-Comfort Ecclesiastical Palette)
/// تم اختياره وتدقيقه بعناية ليلائم القراءة الطويلة في الكنيسة والليل دون أي إجهاد بصري
class AppColors {
  AppColors._();

  // ==========================================
  // الألوان الأساسية: ذهب كنسي مطفأ ودافئ (غير فاقع)
  // ==========================================
  static const Color primary = Color(0xFFC49B3C);       // ذهبي #C49B3C
  static const Color primaryDark = Color(0xFFA88438);   // ذهبي كنسي رصين
  static const Color primaryLight = Color(0xFFD4A843);  // ذهبي للوضع الداكن #D4A843

  // ==========================================
  // خلفيات مريحة لشبكية العين (Anti-Eye Strain)
  // مأخوذة بدقة: الفاتح #FAF6F0 والغامق #141821 (ممنوع الأبيض أو الأسود الناصع)
  // ==========================================
  static const Color backgroundLight = Color(0xFFFAF6F0); // كريمي مريح للعين
  static const Color surfaceLight = Color(0xFFF2ECE1);    // بيج هادئ بديل للأبيض الناصع

  static const Color backgroundDark = Color(0xFF141821);  // أزرق أسود عميق مريح
  static const Color surfaceDark = Color(0xFF1E2433);     // كحلي فحمي بديل للأسود الناصع

  // ==========================================
  // النصوص: تباين عالي ومريح بدون حدة
  // ==========================================
  static const Color textPrimaryLight = Color(0xFF2D2D2D);   // نص فاتح مريح #2D2D2D
  static const Color textSecondaryLight = Color(0xFF6E655B); // رصاصي دافئ
  static const Color textPrimaryDark = Color(0xFFE8DFD0);    // نص غامق مريح #E8DFD0
  static const Color textSecondaryDark = Color(0xFFA69E92);  // بيج رملي ناعم

  // ==========================================
  // ألوان الأدوار الطقسية (هادئة ووقورة)
  // ==========================================
  static const Color priestColor = Color(0xFFBA3838); // أحمر قرمزي نقي (الكاهن)
  static const Color deaconColor = Color(0xFF2069B4); // أزرق سماوي كنسي (الشماس)
  static const Color peopleColor = Color(0xFF2E7D48); // أخضر زيتوني ناعم (الشعب)
  static const Color rubricColor = Color(0xFF7E3894); // بنفسجي وقور (التعليمات الطقسية)

  // ==========================================
  // ألوان المناسبات الطقسية
  // ==========================================
  static const Color festiveColor = Color(0xFFC5A059); // ذهبي للفرايحي
  static const Color lentenColor = Color(0xFF6B588E);  // بنفسجي للصيامي
  static const Color annualColor = Color(0xFF2E8278);  // تركواز هادئ للسنوي
  static const Color kiahkiColor = Color(0xFFD46C20);  // مريمي كيهكي دافئ
  static const Color paschaColor = Color(0xFF2A2725);  // رمادي بصخة وقور

  // مسميات بديلة متوافقة مع الأكواد السابقة
  static const Color priest = priestColor;
  static const Color deacon = deaconColor;
  static const Color people = peopleColor;
  static const Color rubric = rubricColor;
  static const Color rolePriest = priestColor;
  static const Color roleDeacon = deaconColor;
  static const Color rolePeople = peopleColor;
  static const Color roleRubric = rubricColor;
  static const Color festive = festiveColor;
  static const Color lenten = lentenColor;
  static const Color annual = annualColor;
  static const Color kiahki = kiahkiColor;
  static const Color pascha = paschaColor;

  // ==========================================
  // ألوان وظيفية وهيكلية
  // ==========================================
  static const Color accent = Color(0xFF5E60CE);
  static const Color error = Color(0xFFCF4343);
  static const Color success = Color(0xFF388E4C);
  static const Color divider = Color(0xFFE6E0D4);
  static const Color dividerLight = divider;
  static const Color dividerDark = Color(0xFF2D2A26);
  static const Color cardLight = surfaceLight;
  static const Color cardDark = surfaceDark;
  static const Color gold = primary;
  static const Color goldLight = primaryLight;
  static const Color goldDark = primaryDark;
  static const Color copticLight = textPrimaryLight;
  static const Color copticDark = textPrimaryDark;

  // ==========================================
  // نمط ورق البردي والمخطوطات العتيقة (Sepia)
  // ==========================================
  static const Color backgroundSepia = Color(0xFFF6EEDC);
  static const Color surfaceSepia = Color(0xFFECE1CA);
  static const Color textPrimarySepia = Color(0xFF362819);
  static const Color textSecondarySepia = Color(0xFF6B5742);
  static const Color dividerSepia = Color(0xFFD8C7A5);
  static const Color primarySepia = Color(0xFF9E7227);

  // ==========================================
  // نمط AMOLED الموفر للبطارية بشاشات OLED
  // ==========================================
  static const Color backgroundAmoled = Color(0xFF000000);
  static const Color surfaceAmoled = Color(0xFF0F0E0E);
  static const Color textPrimaryAmoled = Color(0xFFF3EFE6);
  static const Color textSecondaryAmoled = Color(0xFFA59E93);
  static const Color dividerAmoled = Color(0xFF201D1A);
  static const Color primaryAmoled = Color(0xFFDDB560);
}
