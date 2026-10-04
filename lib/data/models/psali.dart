enum PsaliType {
  hos,         // هوس
  theotokia,   // تئوطوكية
  madih,       // مديح
  psali,       // إبصلمودية (مزمور قبطي)
  lobsh,       // لبش
  tarh,        // طرح
  doxology,    // ذوكصولوجية
}

class Psali {
  final int id;
  final String psaliId;
  final PsaliType type;
  final String nameAr;
  final String? nameCoptic;
  final String? namePhonetic;
  final String occasion;
  final String? dayOfWeek; // sunday, monday, ... saturday
  final String? season;    // annual, kiahki, lent, pascha, festive
  final int order;

  const Psali({
    required this.id,
    required this.psaliId,
    required this.type,
    required this.nameAr,
    this.nameCoptic,
    this.namePhonetic,
    required this.occasion,
    this.dayOfWeek,
    this.season,
    required this.order,
  });

  String get typeAr {
    switch (type) {
      case PsaliType.hos:
        return 'هوس';
      case PsaliType.theotokia:
        return 'تئوطوكية';
      case PsaliType.madih:
        return 'مديح';
      case PsaliType.psali:
        return 'إبصلمودية';
      case PsaliType.lobsh:
        return 'لبش';
      case PsaliType.tarh:
        return 'طرح';
      case PsaliType.doxology:
        return 'ذوكصولوجية';
    }
  }

  String get dayAr {
    switch (dayOfWeek) {
      case 'sunday':
        return 'الأحد';
      case 'monday':
        return 'الإثنين';
      case 'tuesday':
        return 'الثلاثاء';
      case 'wednesday':
        return 'الأربعاء';
      case 'thursday':
        return 'الخميس';
      case 'friday':
        return 'الجمعة';
      case 'saturday':
        return 'السبت';
      default:
        return '';
    }
  }

  String get seasonAr {
    switch (season) {
      case 'annual':
        return 'سنوي';
      case 'kiahki':
        return 'كيهكي';
      case 'lent':
        return 'صوم كبير';
      case 'pascha':
        return 'بصخة';
      case 'festive':
        return 'فرايحي';
      default:
        return season ?? '';
    }
  }
}

class PsaliSection {
  final int id;
  final String psaliId;
  final int sectionOrder;
  final String textCoptic;
  final String textPhonetic;
  final String textArabic;
  final String? rubric;
  final String? response;

  const PsaliSection({
    required this.id,
    required this.psaliId,
    required this.sectionOrder,
    required this.textCoptic,
    required this.textPhonetic,
    required this.textArabic,
    this.rubric,
    this.response,
  });
}
