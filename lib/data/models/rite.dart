enum RiteCategory {
  sacrament('سر مقدس'),
  ordination('سيامة'),
  funeral('جناز'),
  laqan('لقان'),
  consecration('تدشين');

  final String labelAr;
  const RiteCategory(this.labelAr);

  static RiteCategory fromString(String s) {
    return RiteCategory.values.firstWhere(
      (e) => e.name == s,
      orElse: () => RiteCategory.sacrament,
    );
  }
}

class Rite {
  final int id;
  final String nameAr;
  final String? nameEn;
  final String? nameCoptic;
  final RiteCategory category;
  final String? description;
  final int sortOrder;
  final String? icon;

  const Rite({
    required this.id,
    required this.nameAr,
    this.nameEn,
    this.nameCoptic,
    required this.category,
    this.description,
    required this.sortOrder,
    this.icon,
  });
}

class RiteSection {
  final int id;
  final int riteId;
  final String titleAr;
  final String textAr;
  final String? copticText;
  final String? copticArabicText;
  final String? rubric;
  final String? response;
  final int sortOrder;

  const RiteSection({
    required this.id,
    required this.riteId,
    required this.titleAr,
    required this.textAr,
    this.copticText,
    this.copticArabicText,
    this.rubric,
    this.response,
    required this.sortOrder,
  });
}
