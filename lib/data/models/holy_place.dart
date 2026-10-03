enum HolyPlaceType {
  monasteryMen('دير رهبان'),
  monasteryWomen('دير راهبات'),
  holyFamily('محطة العائلة المقدسة'),
  historicChurch('كنيسة أثرية'),
  shrine('مزار مقدس');

  final String labelAr;
  const HolyPlaceType(this.labelAr);

  static HolyPlaceType fromString(String s) {
    return HolyPlaceType.values.firstWhere(
      (e) => e.name == s,
      orElse: () => HolyPlaceType.monasteryMen,
    );
  }
}

class HolyPlace {
  final int id;
  final String nameAr;
  final String? nameCoptic;
  final HolyPlaceType type;
  final String governorate; // المحافظة
  final String locationDescription; // وصف الموقع والطريق
  final double? latitude;
  final double? longitude;
  final String? century; // القرن التاريخي للتأسيس
  final String? patronSaint; // شفيع المكان
  final String history; // النبذة التاريخية
  final String? feastDay; // أعياد الدير/المكان
  final String? visitingRules; // مواعيد وإرشادات الزيارة
  final int sortOrder;

  const HolyPlace({
    required this.id,
    required this.nameAr,
    this.nameCoptic,
    required this.type,
    required this.governorate,
    required this.locationDescription,
    this.latitude,
    this.longitude,
    this.century,
    this.patronSaint,
    required this.history,
    this.feastDay,
    this.visitingRules,
    required this.sortOrder,
  });
}
