/// أسماء الأقسام الـ ١٨ المتفق عليها والموحدة في تطبيق نور
class CategoryNames {
  CategoryNames._();

  static const Map<String, String> mapping = {
    // المعرف الكنسي -> الاسم الحديث المتفق عليه
    'home': 'الرئيسية',
    'agpeya': 'الصلوات',
    'liturgy': 'القداس',
    'katameros': 'القراءات',
    'synaxarium': 'التذكارات',
    'pascha': 'أسبوع الآلام',
    'feasts': 'الأعياد',
    'sacraments': 'الأسرار',
    'theology': 'العقيدة',
    'history': 'التاريخ',
    'faq': 'أسئلة وأجوبة',
    'daily': 'تأمل اليوم',
    'psali': 'التسابيح',
    'hymns': 'الألحان',
    'rites': 'الطقوس',
    'holy_places': 'الأماكن المقدسة',
    'emotions': 'صلوات المشاعر',
    'more': 'المزيد',
  };

  /// إرجاع الاسم الموحد للقسم
  static String getName(String key) => mapping[key] ?? key;

  /// إرجاع كافة الأقسام
  static Map<String, String> get all => mapping;
}
