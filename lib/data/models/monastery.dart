enum HolySiteType { monastery, church }

class Monastery {
  final String id;
  final String nameAr;
  final String? nameCoptic;
  final HolySiteType type;
  final String location;
  final String century;
  final String founder;
  final String patronSaints;
  final String coordinates;
  final String visitingHours;
  final String feastDate;
  final String architecturalDescription;
  final String historySummary;

  const Monastery({
    required this.id,
    required this.nameAr,
    this.nameCoptic,
    required this.type,
    required this.location,
    required this.century,
    required this.founder,
    required this.patronSaints,
    required this.coordinates,
    required this.visitingHours,
    required this.feastDate,
    required this.architecturalDescription,
    required this.historySummary,
  });

  bool get isMonastery => type == HolySiteType.monastery;
  bool get isChurch => type == HolySiteType.church;

  Map<String, dynamic> toJson() => {
    'id': id,
    'nameAr': nameAr,
    'nameCoptic': nameCoptic,
    'type': type.name,
    'location': location,
    'century': century,
    'founder': founder,
    'patronSaints': patronSaints,
    'coordinates': coordinates,
    'visitingHours': visitingHours,
    'feastDate': feastDate,
    'architecturalDescription': architecturalDescription,
    'historySummary': historySummary,
  };

  factory Monastery.fromJson(Map<String, dynamic> json) => Monastery(
    id: json['id'] as String,
    nameAr: json['nameAr'] as String,
    nameCoptic: json['nameCoptic'] as String?,
    type: json['type'] == 'church' ? HolySiteType.church : HolySiteType.monastery,
    location: json['location'] as String,
    century: json['century'] as String,
    founder: json['founder'] as String,
    patronSaints: json['patronSaints'] as String,
    coordinates: json['coordinates'] as String,
    visitingHours: json['visitingHours'] as String,
    feastDate: json['feastDate'] as String,
    architecturalDescription: json['architecturalDescription'] as String,
    historySummary: json['historySummary'] as String,
  );

  factory Monastery.fromDb(dynamic m) => Monastery(
    id: m.id as String,
    nameAr: m.nameAr as String,
    nameCoptic: m.nameCoptic as String?,
    type: m.type == 'church' ? HolySiteType.church : HolySiteType.monastery,
    location: m.location as String,
    century: m.founded as String,
    founder: m.founder as String,
    patronSaints: (m.patronSaints as String?) ?? '',
    coordinates: (m.latitude != null && m.longitude != null)
        ? '${m.latitude}° N, ${m.longitude}° E'
        : '',
    visitingHours: (m.visitingHours as String?) ?? 'مفتوح للزيارة ونوال البركة',
    feastDate: (m.feastDate as String?) ?? '',
    architecturalDescription: (m.architecturalDescription as String?) ?? '',
    historySummary: m.description as String,
  );
}
