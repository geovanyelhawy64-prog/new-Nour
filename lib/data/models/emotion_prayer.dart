enum EmotionCategory {
  comfort('الضيق والحزن'),
  anxiety('القلق والخوف'),
  peace('السلام والطمأنينة'),
  repentance('التوبة والرجوع'),
  gratitude('الشكر والفرح'),
  guidance('الحيرة وطلب الإرشاد'),
  sickness('المرض والضعف'),
  temptation('محاربة التجارب');

  final String labelAr;
  const EmotionCategory(this.labelAr);

  static EmotionCategory fromString(String s) {
    return EmotionCategory.values.firstWhere(
      (e) => e.name == s,
      orElse: () => EmotionCategory.comfort,
    );
  }
}

class EmotionPrayer {
  final int id;
  final String category;
  final String title;
  final String verseText;
  final String verseReference;
  final String? psalmText;
  final String? psalmReference;
  final String? agpeyaPrayer;
  final String? agpeyaReference;
  final String meditation;
  final int sortOrder;

  const EmotionPrayer({
    required this.id,
    required this.category,
    required this.title,
    required this.verseText,
    required this.verseReference,
    this.psalmText,
    this.psalmReference,
    this.agpeyaPrayer,
    this.agpeyaReference,
    required this.meditation,
    required this.sortOrder,
  });
}
