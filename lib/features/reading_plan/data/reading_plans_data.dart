import '../models/reading_plan.dart';

class ReadingPlansData {
  static const List<BibleReadingPlan> plans = [
    BibleReadingPlan(
      id: 'plan_whole_bible_365',
      title: 'ختمة الكتاب المقدس في عام',
      subtitle: '365 يوماً',
      description: 'رحلة مباركة تغطي الكتاب المقدس كاملاً بعهديه القديم والجديد والأسفار القانونية الثانية والمزامير.',
      totalDays: 365,
      iconName: 'menu_book_rounded',
    ),
    BibleReadingPlan(
      id: 'plan_new_testament_90',
      title: 'العهد الجديد في 90 يوماً',
      subtitle: '3 أشهر (90 يوماً)',
      description: 'قراءة مركزة لجميع أسفار العهد الجديد الـ 27، بمعدل نحو ثلاثة أصحاحات يومياً.',
      totalDays: 90,
      iconName: 'auto_stories_rounded',
    ),
    BibleReadingPlan(
      id: 'plan_psalms_30',
      title: 'سفر المزامير في شهر',
      subtitle: '30 يوماً',
      description: 'مدرسة الصلاة والتسبيح؛ قراءة وتأمل في المزامير الـ 151 كاملة بمعدل 5 مزامير يومياً.',
      totalDays: 30,
      iconName: 'library_music_rounded',
    ),
    BibleReadingPlan(
      id: 'plan_gospels_lent_45',
      title: 'الأناجيل الأربعة في الصوم الكبير',
      subtitle: '45 يوماً',
      description: 'معايشة يومية مع حياة وتعاليم وفداء المخلص عبر الأناجيل الأربعة بمعدل أصحاحين يومياً.',
      totalDays: 45,
      iconName: 'favorite_rounded',
    ),
  ];

  static final Map<int, String> _bookNames = {
    1: 'التكوين',
    2: 'الخروج',
    3: 'اللاويين',
    4: 'العدد',
    5: 'التثنية',
    6: 'يشوع',
    7: 'القضاة',
    8: 'راعوث',
    9: 'صموئيل الأول',
    10: 'صموئيل الثاني',
    11: 'الملوك الأول',
    12: 'الملوك الثاني',
    13: 'أخبار الأيام الأول',
    14: 'أخبار الأيام الثاني',
    15: 'عزرا',
    16: 'نحميا',
    17: 'طوبيا',
    18: 'يهوديت',
    19: 'أستير',
    20: 'أيوب',
    21: 'المزامير',
    22: 'الأمثال',
    23: 'الجامعة',
    24: 'نشيد الأنشاد',
    25: 'حكمة سليمان',
    26: 'يشوع بن سيراخ',
    27: 'إشعياء',
    28: 'إرميا',
    29: 'مراثي إرميا',
    30: 'باروخ',
    31: 'حزقيال',
    32: 'دانيال',
    33: 'هوشع',
    34: 'يوئيل',
    35: 'عاموس',
    36: 'عوبديا',
    37: 'يونان',
    38: 'ميخا',
    39: 'ناحوم',
    40: 'حبقوق',
    41: 'صفنيا',
    42: 'حجي',
    43: 'زكريا',
    44: 'ملاخي',
    45: 'المكابيين الأول',
    46: 'المكابيين الثاني',
    47: 'إنجيل متى',
    48: 'إنجيل مرقس',
    49: 'إنجيل لوقا',
    50: 'إنجيل يوحنا',
    51: 'أعمال الرسل',
    52: 'رومية',
    53: 'كورنثوس الأولى',
    54: 'كورنثوس الثانية',
    55: 'غلاطية',
    56: 'أفسس',
    57: 'فيلبي',
    58: 'كولوسي',
    59: 'تسالونيكي الأولى',
    60: 'تسالونيكي الثانية',
    61: 'تيموثاوس الأولى',
    62: 'تيموثاوس الثانية',
    63: 'تيطس',
    64: 'فليمون',
    65: 'العبرانيين',
    66: 'يعقوب',
    67: 'بطرس الأولى',
    68: 'بطرس الثانية',
    69: 'يوحنا الأولى',
    70: 'يوحنا الثانية',
    71: 'يوحنا الثالثة',
    72: 'يهوذا',
    73: 'سفر الرؤيا',
  };

  static final Map<int, int> _bookChapterCounts = {
    1: 50, 2: 40, 3: 27, 4: 36, 5: 34, 6: 24, 7: 21, 8: 4, 9: 31, 10: 24,
    11: 22, 12: 25, 13: 29, 14: 36, 15: 10, 16: 13, 17: 14, 18: 16, 19: 16, 20: 42,
    21: 151, 22: 31, 23: 12, 24: 8, 25: 19, 26: 51, 27: 66, 28: 52, 29: 5, 30: 6,
    31: 48, 32: 14, 33: 14, 34: 3, 35: 9, 36: 1, 37: 4, 38: 7, 39: 3, 40: 3,
    41: 3, 42: 2, 43: 14, 44: 4, 45: 16, 46: 15,
    47: 28, 48: 16, 49: 24, 50: 21, 51: 28, 52: 16, 53: 16, 54: 13, 55: 6, 56: 6,
    57: 4, 58: 4, 59: 5, 60: 3, 61: 6, 62: 4, 63: 3, 64: 1, 65: 13, 66: 5,
    67: 5, 68: 3, 69: 5, 70: 1, 71: 1, 72: 1, 73: 22,
  };

  /// توليد قراءات اليوم لخطة المزامير في 30 يوماً
  static PlanDay getPsalmsPlanDay(int dayNumber) {
    final day = dayNumber.clamp(1, 30);
    final List<PlanReadingItem> items = [];
    int startPsalm = (day - 1) * 5 + 1;
    int endPsalm = day == 30 ? 151 : (day * 5);

    for (int p = startPsalm; p <= endPsalm; p++) {
      items.add(
        PlanReadingItem(
          bookId: 21,
          bookName: _bookNames[21]!,
          chapter: p,
          notes: 'المزمور $p',
        ),
      );
    }

    return PlanDay(
      dayNumber: day,
      title: 'اليوم $day: المزامير ($startPsalm - $endPsalm)',
      readings: items,
    );
  }

  /// توليد قراءات اليوم لخطة الأناجيل الأربعة في الصوم الكبير (45 يوماً)
  static PlanDay getGospelsPlanDay(int dayNumber) {
    final day = dayNumber.clamp(1, 45);
    final List<PlanReadingItem> allGospelChapters = [];
    for (int b = 47; b <= 50; b++) {
      final totalCh = _bookChapterCounts[b]!;
      for (int c = 1; c <= totalCh; c++) {
        allGospelChapters.add(
          PlanReadingItem(
            bookId: b,
            bookName: _bookNames[b]!,
            chapter: c,
          ),
        );
      }
    }

    final startIndex = (day - 1) * 2;
    final items = <PlanReadingItem>[];
    if (startIndex < allGospelChapters.length) {
      items.add(allGospelChapters[startIndex]);
    }
    if (startIndex + 1 < allGospelChapters.length) {
      items.add(allGospelChapters[startIndex + 1]);
    }
    if (day == 45 && startIndex + 2 < allGospelChapters.length) {
      items.add(allGospelChapters[startIndex + 2]);
    }

    final titleStr = items.map((i) => '${i.bookName} ${i.chapter}').join(' و ');
    return PlanDay(
      dayNumber: day,
      title: 'اليوم $day: $titleStr',
      readings: items,
    );
  }

  /// توليد قراءات اليوم لخطة العهد الجديد في 90 يوماً
  static PlanDay getNewTestamentPlanDay(int dayNumber) {
    final day = dayNumber.clamp(1, 90);
    final List<PlanReadingItem> allNtChapters = [];
    for (int b = 47; b <= 73; b++) {
      final totalCh = _bookChapterCounts[b]!;
      for (int c = 1; c <= totalCh; c++) {
        allNtChapters.add(
          PlanReadingItem(
            bookId: b,
            bookName: _bookNames[b]!,
            chapter: c,
          ),
        );
      }
    }

    // 260 أصحاحاً مقسمة على 90 يوماً
    final int startIdx = ((day - 1) * allNtChapters.length / 90).floor();
    final int endIdx = (day * allNtChapters.length / 90).floor();
    final items = allNtChapters.sublist(
      startIdx,
      endIdx > allNtChapters.length ? allNtChapters.length : endIdx,
    );

    final titleStr = items.map((i) => '${i.bookName} ${i.chapter}').join('، ');
    return PlanDay(
      dayNumber: day,
      title: 'اليوم $day: $titleStr',
      readings: items,
    );
  }

  /// توليد قراءات اليوم لخطة الكتاب المقدس كاملاً في 365 يوماً
  static PlanDay getWholeBiblePlanDay(int dayNumber) {
    final day = dayNumber.clamp(1, 365);
    // تجميع كل أسفار العهد القديم والديوتروكانونيكال ما عدا المزامير
    final List<PlanReadingItem> otChapters = [];
    for (int b = 1; b <= 46; b++) {
      if (b == 21) continue; // المزامير تقرأ على حدة
      final totalCh = _bookChapterCounts[b]!;
      for (int c = 1; c <= totalCh; c++) {
        otChapters.add(PlanReadingItem(bookId: b, bookName: _bookNames[b]!, chapter: c));
      }
    }

    // أسفار العهد الجديد
    final List<PlanReadingItem> ntChapters = [];
    for (int b = 47; b <= 73; b++) {
      final totalCh = _bookChapterCounts[b]!;
      for (int c = 1; c <= totalCh; c++) {
        ntChapters.add(PlanReadingItem(bookId: b, bookName: _bookNames[b]!, chapter: c));
      }
    }

    final items = <PlanReadingItem>[];

    // أصحاحان أو 3 من العهد القديم
    final otStart = ((day - 1) * otChapters.length / 365).floor();
    final otEnd = (day * otChapters.length / 365).floor();
    items.addAll(otChapters.sublist(otStart, otEnd > otChapters.length ? otChapters.length : otEnd));

    // مزمور اليوم (دورة المزامير تتكرر مرتين ونصف في السنة)
    final psalmNum = ((day - 1) % 151) + 1;
    items.add(PlanReadingItem(bookId: 21, bookName: 'المزامير', chapter: psalmNum, notes: 'مزمور اليوم'));

    // أصحاح من العهد الجديد
    final ntIdx = ((day - 1) % ntChapters.length);
    items.add(ntChapters[ntIdx]);

    final titleStr = '${items.first.bookName} ${items.first.chapter} إلى ${items.last.bookName} ${items.last.chapter}';
    return PlanDay(
      dayNumber: day,
      title: 'اليوم $day: $titleStr',
      readings: items,
    );
  }

  /// الحصول على قراءات اليوم لأي خطة
  static PlanDay getPlanDay(String planId, int dayNumber) {
    switch (planId) {
      case 'plan_psalms_30':
        return getPsalmsPlanDay(dayNumber);
      case 'plan_gospels_lent_45':
        return getGospelsPlanDay(dayNumber);
      case 'plan_new_testament_90':
        return getNewTestamentPlanDay(dayNumber);
      case 'plan_whole_bible_365':
      default:
        return getWholeBiblePlanDay(dayNumber);
    }
  }
}
