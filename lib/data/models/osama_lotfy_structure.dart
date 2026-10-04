import 'package:flutter/material.dart';

/// الأجزاء الأربعة الكبرى المعتمدة لموسوعة أسامة لطفي للألحان الكنسية
enum OsamaLotfyPart {
  all('الكل (٤ أجزاء)', Icons.library_books_rounded),
  annual('الجزء ١: السنوية', Icons.calendar_today_rounded),
  festive('الجزء ٢: الفرايحي', Icons.celebration_rounded),
  sorrowful('الجزء ٣: الحزايني', Icons.dark_mode_rounded),
  kiahk('الجزء ٤: كيهك', Icons.star_rounded);

  final String title;
  final IconData icon;
  const OsamaLotfyPart(this.title, this.icon);
}

/// باب كنسي من أبواب موسوعة المعلم أسامة لطفي
class OsamaLotfyChapter {
  final String id;
  final String title;
  final String subtitle;
  final OsamaLotfyPart part;
  final String partNameAr;
  final List<String> hymnIds;
  final IconData icon;
  final Color color;

  const OsamaLotfyChapter({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.part,
    required this.partNameAr,
    required this.hymnIds,
    required this.icon,
    required this.color,
  });

  bool get isAvailable => hymnIds.isNotEmpty;
  int get count => hymnIds.length;
}

/// الفهرس الكنسي المعتمد لموسوعة المعلم أسامة لطفي (الأجزاء الأربعة والأبواب)
class OsamaLotfyCatalog {
  static const String encyclopediaName = 'موسوعة أسامة لطفي للألحان الكنسية';
  static const String currentSelectionTitle = 'مختارات من موسوعة أسامة لطفي';
  static const String referenceBookTitle = 'كتاب الألحان بالهزات الموسيقية — الدياكون أسامة لطفي';

  static const List<OsamaLotfyChapter> chapters = [
    // ========================================================
    // الجزء الأول: السنوية (آدام واطس + باكر وعشية + قداس + مزامير) — ١٩ لحناً
    // ========================================================
    OsamaLotfyChapter(
      id: 'ch_annual_tasbeha',
      title: 'ألحان الآدام والواطس والتسبحة السنوية',
      subtitle: 'الهوسات الأربعة بالهزات ومقدمة الثيؤطوكيات السنوية',
      part: OsamaLotfyPart.annual,
      partNameAr: 'الجزء الأول: السنوية',
      icon: Icons.auto_awesome_rounded,
      color: Color(0xFF2E7D32),
      hymnIds: [
        'ol01_05', // الهوس الأول (توتي أف هوس)
        'ol01_06', // الهوس الثاني (أو أونه إيفول)
        'ol01_07', // الهوس الثالث (أري هوس إيروف)
        'ol01_08', // الهوس الرابع (إسمو إي إبشويس)
        'ol01_09', // مقدمة الثيؤطوكيات السنوية
      ],
    ),
    OsamaLotfyChapter(
      id: 'ch_annual_vespers_matins',
      title: 'رفع بخور عشية وباكر والمزامير',
      subtitle: 'مزمور ني إثنوس تيرو، تين أوؤشت، خين إفران، وأمويني مارين أوؤشت',
      part: OsamaLotfyPart.annual,
      partNameAr: 'الجزء الأول: السنوية',
      icon: Icons.wb_twilight_rounded,
      color: Color(0xFF388E3C),
      hymnIds: [
        'ol01_01', // مزمور العشية وباكر (ني إثنوس تيرو)
        'ol01_02', // لحن نسجد لك أيها المسيح (تين أوؤشت إموك)
        'ol01_03', // لحن خين إفران السنوي
        'ol01_04', // لحن أمويني مارين أوؤشت
      ],
    ),
    OsamaLotfyChapter(
      id: 'ch_annual_liturgy',
      title: 'ألحان وطقس القداس الإلهي الباسيلي السنوي',
      subtitle: 'إبؤرو، فاي بي بي إيهو أو، الهيتينيات، أجيوس، الإسباسموس، وبي أويك',
      part: OsamaLotfyPart.annual,
      partNameAr: 'الجزء الأول: السنوية',
      icon: Icons.church_rounded,
      color: Color(0xFF1B5E20),
      hymnIds: [
        'ol02_01', // إبؤرو
        'ol02_02', // فاي بي بي إيهو أو
        'ol02_03', // هيتين ني إفكي
        'ol02_04', // استجابة الإبركسيس
        'ol02_05', // أجيوس السنوي
        'ol02_06', // إسباسموس سنوي
        'ol02_07', // بي إخمات
        'ol02_08', // الشاروبيم يسجدون لك
        'ol02_09', // آمين آمين بموتك يارب نبشر
        'ol02_10', // بي أويك
      ],
    ),

    // ========================================================
    // الجزء الثاني: الفرايحي (أعياد السيد المسيح والعذراء والرسل) — ٢٢ لحناً
    // ========================================================
    OsamaLotfyChapter(
      id: 'ch_festive_nativity_theophany',
      title: 'ألحان عيدي الميلاد والغطاس المجيدين',
      subtitle: 'مزمور الميلاد الفرايحي، بي جين ميسي، أوران سيف، والليلويا جي إن دان',
      part: OsamaLotfyPart.festive,
      partNameAr: 'الجزء الثاني: الفرايحي',
      icon: Icons.child_care_rounded,
      color: Color(0xFFC49B3C),
      hymnIds: [
        'ol04_01', // مزمور الميلاد الفرايحي
        'ol04_02', // لحن ميلاد المخلص (بي جين ميسي)
        'ol04_03', // لحن أوران سيف إن رومبي
        'ol04_04', // الليلويا جي إن دان (الغطاس)
        'ol04_05', // اعتمد من يوحنا في الأردن
      ],
    ),
    OsamaLotfyChapter(
      id: 'ch_festive_resurrection',
      title: 'ألحان عيد القيامة المجيد والخماسين المقدسة',
      subtitle: 'يا كل الصفوف السمائيين، إخرستوس آنيستي، وتوزيع كاطا ني خوروس',
      part: OsamaLotfyPart.festive,
      partNameAr: 'الجزء الثاني: الفرايحي',
      icon: Icons.light_mode_rounded,
      color: Color(0xFFD4AF37),
      hymnIds: [
        'ol09_01', // آني خوروس تيرو
        'ol09_02', // إخرستوس آنيستي
        'ol09_03', // كاطا ني خوروس
        'ol09_04', // رآه الرسل وهو صاعد (أراف إيروف)
        'ol09_05', // باكر عيد القيامة (طو منيما)
      ],
    ),
    OsamaLotfyChapter(
      id: 'ch_festive_ascension_pentecost',
      title: 'ألحان عيدي الصعود وحلول الروح القدس (العنصرة)',
      subtitle: 'طأطأ السموات ونزل (أفريك إتفي)، ولحن الروح القدس المعزي',
      part: OsamaLotfyPart.festive,
      partNameAr: 'الجزء الثاني: الفرايحي',
      icon: Icons.cloud_upload_rounded,
      color: Color(0xFFB8860B),
      hymnIds: [
        'ol10_01', // أفريك إتفي (الصعود)
        'ol10_02', // الروح القدس المعزي (العنصرة)
      ],
    ),
    OsamaLotfyChapter(
      id: 'ch_festive_palm_sunday',
      title: 'ألحان أحد الشعانين وسبت إقامة لعازر',
      subtitle: 'مبارك الآتي باسم الرب، أوصنا في الأعالي، ولحن سبت لعازر',
      part: OsamaLotfyPart.festive,
      partNameAr: 'الجزء الثاني: الفرايحي',
      icon: Icons.spa_rounded,
      color: Color(0xFF9E7D2B),
      hymnIds: [
        'ol06_01', // مبارك الآتي باسم الرب الشعانيني
        'ol06_02', // أوصنا خين ني إتتشوسي
        'ol06_03', // لحن سبت لعازر
      ],
    ),
    OsamaLotfyChapter(
      id: 'ch_festive_apostles',
      title: 'ألحان وطقس صوم وعيد الرسل الأطهار',
      subtitle: 'فلنسبح الرب لأنه بالمجد تمجد (أسومين)، وسلام لرسل فادينا',
      part: OsamaLotfyPart.festive,
      partNameAr: 'الجزء الثاني: الفرايحي',
      icon: Icons.groups_rounded,
      color: Color(0xFFA67C00),
      hymnIds: [
        'ol10_03', // أسومين طو كيريو
        'ol10_04', // شيري ني أبوستولوس
      ],
    ),
    OsamaLotfyChapter(
      id: 'ch_festive_st_mary_saints',
      title: 'ألحان صوم وتذكارات السيدة العذراء والشهداء',
      subtitle: 'طاي شوري الذهبية، هيتين العذراء، شيري ثيؤطوكي، وذوكصولوجية مارمرقس',
      part: OsamaLotfyPart.festive,
      partNameAr: 'الجزء الثاني: الفرايحي',
      icon: Icons.favorite_rounded,
      color: Color(0xFFC5A059),
      hymnIds: [
        'ol11_01', // طاي شوري
        'ol11_02', // هيتين مريم
        'ol11_03', // شيري ثيؤطوكي
        'ol11_04', // أكسيون إستين
        'ol11_05', // ذوكصولوجية مارمرقس
      ],
    ),
    OsamaLotfyChapter(
      id: 'ch_festive_nayrouz',
      title: 'ألحان عيد النيروز ورأس السنة وعيد الصليب',
      subtitle: 'ألحان طقس النيروز والتسابيح الفرايحية الكنسية',
      part: OsamaLotfyPart.festive,
      partNameAr: 'الجزء الثاني: الفرايحي',
      icon: Icons.event_note_rounded,
      color: Color(0xFFD4AF37),
      hymnIds: [], // باب هيكلي من الكتاب - قيد الإضافة
    ),

    // ========================================================
    // الجزء الثالث: الحزايني (الصوم الكبير والبصخة والتجنيز) — ١٦ لحناً
    // ========================================================
    OsamaLotfyChapter(
      id: 'ch_sorrowful_lent',
      title: 'ألحان صوم يونان والصوم الكبير وختام الصوم',
      subtitle: 'إنثوك تي تي شوري الصيامية، ميغالو، أري بسالين الصيامي، وقنديل ختام الصوم',
      part: OsamaLotfyPart.sorrowful,
      partNameAr: 'الجزء الثالث: الحزايني',
      icon: Icons.hourglass_top_rounded,
      color: Color(0xFF5D4037),
      hymnIds: [
        'ol05_01', // إنثوك تي تي شوري
        'ol05_02', // ميغالو إيبروسبين
        'ol05_03', // أري بسالين الصيامي
        'ol05_04', // ني سوس ني فا إفنوتي
        'ol05_05', // مبارك الآتي الصيامي
        'ol06_04', // قنديل جمعة ختام الصوم
      ],
    ),
    OsamaLotfyChapter(
      id: 'ch_sorrowful_pascha',
      title: 'ألحان أسبوع الآلام والبصخة المقدسة',
      subtitle: 'ثوك تي تي جوم بالهزات، كي إيبير، مرد البصخة، وأجيوس الحزايني',
      part: OsamaLotfyPart.sorrowful,
      partNameAr: 'الجزء الثالث: الحزايني',
      icon: Icons.nightlight_round,
      color: Color(0xFF4E342E),
      hymnIds: [
        'ol07_01', // ثوك تي تي جوم
        'ol07_02', // كي إيبير
        'ol07_03', // مرد البصخة (إثفي تيف أناستاسيس)
        'ol07_04', // أومونو جينيس
        'ol07_05', // قدوس الله الحزايني
      ],
    ),
    OsamaLotfyChapter(
      id: 'ch_sorrowful_holy_week_end',
      title: 'خميس العهد والجمعة العظيمة وسبت الفرح',
      subtitle: 'يهوذا تلميذ الغدر، بيك إثرونوس، فاي إيتاف إنف، غولغوثا، والليلويا بي هوس',
      part: OsamaLotfyPart.sorrowful,
      partNameAr: 'الجزء الثالث: الحزايني',
      icon: Icons.brightness_medium_rounded,
      color: Color(0xFF3E2723),
      hymnIds: [
        'ol08_01', // يهوذا تلميذ الغدر
        'ol08_02', // بيك إثرونوس
        'ol08_03', // فاي إيتاف إنف
        'ol08_04', // غولغوثا الحزاينية الكاملة
        'ol08_05', // مقدمة سفر الرؤيا سبت النور
      ],
    ),
    OsamaLotfyChapter(
      id: 'ch_sorrowful_pascha_psalms',
      title: 'مزامير البصخة باللحن الإدريبي الحزايني',
      subtitle: 'مزامير ساعات البصخة النهارية والمسائية بالنغمة الإدريبية العريقة',
      part: OsamaLotfyPart.sorrowful,
      partNameAr: 'الجزء الثالث: الحزايني',
      icon: Icons.menu_book_rounded,
      color: Color(0xFF424242),
      hymnIds: [], // باب هيكلي من الكتاب - قيد الإضافة
    ),
    OsamaLotfyChapter(
      id: 'ch_sorrowful_burials',
      title: 'ألحان وطقوس التجنيز الحزايني الكاملة',
      subtitle: 'ألحان صلوات التجنيز للرجال والنساء والشمامسة والرهبان',
      part: OsamaLotfyPart.sorrowful,
      partNameAr: 'الجزء الثالث: الحزايني',
      icon: Icons.airline_seat_flat_rounded,
      color: Color(0xFF212121),
      hymnIds: [], // باب هيكلي من الكتاب - قيد الإضافة
    ),

    // ========================================================
    // الجزء الرابع: شهر كيهك المبارك — ٦ ألحان
    // ========================================================
    OsamaLotfyChapter(
      id: 'ch_kiahk_tasbeha',
      title: 'تسبحة ورفع بخور كيهك (السبعة والأربعة)',
      subtitle: 'إفنوتي ناي نان الكيهكي، خين إفران المبهج، ولحن تين إن هوس',
      part: OsamaLotfyPart.kiahk,
      partNameAr: 'الجزء الرابع: كيهك',
      icon: Icons.star_rounded,
      color: Color(0xFF1565C0),
      hymnIds: [
        'ol03_01', // إفنوتي ناي نان الكيهكي
        'ol03_02', // خين إفران الكيهكي
        'ol03_03', // تين إن هوس إيروك
      ],
    ),
    OsamaLotfyChapter(
      id: 'ch_kiahk_liturgies',
      title: 'ألحان وطقس قداسات آحاد شهر كيهك',
      subtitle: 'آ بي إخرستوس ميسي، إبصالية أري بسالين، ولحن ماف إن أونو في',
      part: OsamaLotfyPart.kiahk,
      partNameAr: 'الجزء الرابع: كيهك',
      icon: Icons.wb_sunny_rounded,
      color: Color(0xFF0D47A1),
      hymnIds: [
        'ol03_04', // آ بي إخرستوس ميسي
        'ol03_05', // أري بسالين الكيهكية
        'ol03_06', // ماف إن أونو في
      ],
    ),
    OsamaLotfyChapter(
      id: 'ch_kiahk_theotokias',
      title: 'الثيؤطوكيات الكيهكية والإبصاليات الكاملة',
      subtitle: 'إبصاليات وثيؤطوكيات الأيام السبعة وقطع شيرات كيهك الموسيقية',
      part: OsamaLotfyPart.kiahk,
      partNameAr: 'الجزء الرابع: كيهك',
      icon: Icons.auto_stories_rounded,
      color: Color(0xFF1A237E),
      hymnIds: [], // باب هيكلي من الكتاب - قيد الإضافة
    ),
    OsamaLotfyChapter(
      id: 'ch_kiahk_doxologies',
      title: 'المدائح والترانيم الكيهكية التراثية',
      subtitle: 'المدائح المعربة والقبطية لليالي كيهك المباركة',
      part: OsamaLotfyPart.kiahk,
      partNameAr: 'الجزء الرابع: كيهك',
      icon: Icons.music_note_rounded,
      color: Color(0xFF283593),
      hymnIds: [], // باب هيكلي من الكتاب - قيد الإضافة
    ),
  ];

  /// جلب كافة الأبواب التابعة لجزء معين
  static List<OsamaLotfyChapter> getChaptersForPart(OsamaLotfyPart part) {
    if (part == OsamaLotfyPart.all) return chapters;
    return chapters.where((c) => c.part == part).toList();
  }

  /// جلب باب محدد بالمعرف
  static OsamaLotfyChapter? getChapterById(String id) {
    try {
      return chapters.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  /// إحصائيات جزء
  static ({int hymnsCount, int availableChapters, int totalChapters}) getPartStats(OsamaLotfyPart part) {
    final list = getChaptersForPart(part);
    int hCount = 0;
    int availChap = 0;
    for (final c in list) {
      hCount += c.hymnIds.length;
      if (c.isAvailable) availChap++;
    }
    return (
      hymnsCount: hCount,
      availableChapters: availChap,
      totalChapters: list.length,
    );
  }
}
