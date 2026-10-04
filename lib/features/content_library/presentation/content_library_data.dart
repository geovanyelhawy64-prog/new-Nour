import 'package:flutter/material.dart';

enum GrandPillar {
  all('الكل (٢٢)', Icons.auto_awesome_rounded, Color(0xFFC49B3C)),
  liturgy('الصلوات والطقوس', Icons.church_rounded, Color(0xFFBA3838)),
  scripture('الكلمة والتراث', Icons.menu_book_rounded, Color(0xFF2069B4)),
  hymns('الألحان واللغة', Icons.music_note_rounded, Color(0xFFD46C20)),
  family('الأسرة والروحيات', Icons.family_restroom_rounded, Color(0xFF2E7D48));

  final String title;
  final IconData icon;
  final Color themeColor;
  const GrandPillar(this.title, this.icon, this.themeColor);
}

  const List<LibraryCategoryItem> allCategories = [
    // ==========================================
    // البوابة 1: ⛪ الصلوات والطقوس (Liturgical Life)
    // ==========================================
    LibraryCategoryItem(
      id: 'agpeya',
      title: 'الأجبية وصلوات السواعي',
      subtitle: 'الصلوات السبع القانونية مع المزامير والأناجيل والقطع وصلاة الستار',
      icon: Icons.access_time_filled_rounded,
      primaryColor: Color(0xFF6A1B9A),
      secondaryColor: Color(0xFF4A148C),
      route: '/agpeya',
      badge: '٨ سواعي كاملة',
      pillar: GrandPillar.liturgy,
    ),
    LibraryCategoryItem(
      id: 'liturgy',
      title: 'القداسات الإلهية (الخولاجي)',
      subtitle: 'صلوات القداسات الثلاثة (الباسيلي، الغريغوري، الكيرلسي) ورفع بخور عشية وباكر',
      icon: Icons.church_rounded,
      primaryColor: Color(0xFFBA3838),
      secondaryColor: Color(0xFF880E4F),
      route: '/liturgy',
      badge: '٣ قداسات وبخور',
      pillar: GrandPillar.liturgy,
    ),
    LibraryCategoryItem(
      id: 'katameros',
      title: 'القطمارس وقراءات الكنيسة',
      subtitle: 'قراءات الكنيسة اليومية والآحاد والأعياد والصوم الكبير والخماسين',
      icon: Icons.auto_stories_rounded,
      primaryColor: Color(0xFF00695C),
      secondaryColor: Color(0xFF004D40),
      route: '/katameros',
      badge: '٤,٧٤٨ قراءة',
      pillar: GrandPillar.liturgy,
    ),
    LibraryCategoryItem(
      id: 'pascha',
      title: 'البصخة المقدسة وأسبوع الآلام',
      subtitle: 'صلوات السواعي النهارية والمسائية وعظات الآباء وألحان الجمعة العظيمة',
      icon: Icons.dark_mode_rounded,
      primaryColor: Color(0xFF37474F),
      secondaryColor: Color(0xFF263238),
      route: '/pascha',
      badge: '٦١٥ قراءة وترتيلة',
      pillar: GrandPillar.liturgy,
    ),
    LibraryCategoryItem(
      id: 'church_mode',
      title: 'وضع الكنيسة لايف (Live Mode)',
      subtitle: 'المتابع الطقسي التفاعلي خطوة بخطوة وإعتام الشاشة لراحة المصلي',
      icon: Icons.fullscreen_rounded,
      primaryColor: Color(0xFFC49B3C),
      secondaryColor: Color(0xFF9E7227),
      route: '/church-mode',
      badge: 'متابع تفاعلي',
      pillar: GrandPillar.liturgy,
    ),

    // ==========================================
    // البوابة 2: 📖 الكلمة والتراث (Scriptures & Heritage)
    // ==========================================
    LibraryCategoryItem(
      id: 'bible',
      title: 'الكتاب المقدس الكامل والتفاسير',
      subtitle: 'العهدان والأسفار القانونية الثانية (٧٣ سفراً مشكولة) وتفاسير فكري وتادرس',
      icon: Icons.menu_book_rounded,
      primaryColor: Color(0xFF1565C0),
      secondaryColor: Color(0xFF0D47A1),
      route: '/bible',
      badge: '٧٣ سفراً كاملاً',
      pillar: GrandPillar.scripture,
    ),
    LibraryCategoryItem(
      id: 'synaxarium',
      title: 'السنكسار وسير الشهداء',
      subtitle: 'سير القديسين والشهداء وتذكارات أعياد السنة القبطية الـ ١٣ شهراً كاملة',
      icon: Icons.calendar_today_rounded,
      primaryColor: Color(0xFF5D4037),
      secondaryColor: Color(0xFF3E2723),
      route: '/synaxarium',
      badge: '٨٥٩ سيرة وتذكار',
      pillar: GrandPillar.scripture,
    ),
    LibraryCategoryItem(
      id: 'difnar',
      title: 'الدفنار والتسابيح اليومية',
      subtitle: 'مدائح وتسابيح قديسي الأيام باللغتين القبطية والعربية بنغمات واطس وآدام',
      icon: Icons.collections_bookmark_rounded,
      primaryColor: Color(0xFF4E342E),
      secondaryColor: Color(0xFF3E2723),
      route: '/difnar',
      badge: '٢٧٩ مديحاً وتسبحة',
      pillar: GrandPillar.scripture,
    ),
    LibraryCategoryItem(
      id: 'saints',
      title: 'بستان الرهبان وسير الآباء',
      subtitle: 'أقوال وتداريب قديسي البرية وتاريخ الرهبنة القبطية العريقة وتأملاتها',
      icon: Icons.person_search_rounded,
      primaryColor: Color(0xFF455A64),
      secondaryColor: Color(0xFF263238),
      route: '/saints',
      badge: '٧٤٩ سيرة وأقوال',
      pillar: GrandPillar.scripture,
    ),
    LibraryCategoryItem(
      id: 'theology',
      title: 'العقيدة والتعليم واللاهوت',
      subtitle: 'مقالات وأبحاث في اللاهوت المقارن والعقيدة الأرثوذكسية وتاريخ المجامع',
      icon: Icons.school_rounded,
      primaryColor: Color(0xFF283593),
      secondaryColor: Color(0xFF1A237E),
      route: '/theology',
      badge: 'عقيدة وتاريخ',
      pillar: GrandPillar.scripture,
    ),

    // ==========================================
    // البوابة 3: 🎶 الألحان واللغة (Hymns, Rites & Coptic)
    // ==========================================
    LibraryCategoryItem(
      id: 'hymns',
      title: 'الألحان والتسبحة (الأبصلمودية)',
      subtitle: 'الأبصلمودية السنوية والكيهكية بالهزات الصوتية ومردات الشمامسة',
      icon: Icons.music_note_rounded,
      primaryColor: Color(0xFFE65100),
      secondaryColor: Color(0xFFBF360C),
      route: '/psali',
      badge: 'تسبحة وهزات كاملة',
      pillar: GrandPillar.hymns,
    ),
    LibraryCategoryItem(
      id: 'dictionary',
      title: 'مدرسة وقاموس اللغة القبطية',
      subtitle: 'تعلم حروف وقواعد ونطق اللغة القبطية الأصيلة مع قاموس شامل وفوري',
      icon: Icons.translate_rounded,
      primaryColor: Color(0xFF795548),
      secondaryColor: Color(0xFF4E342E),
      route: '/dictionary',
      badge: '١,٥٠٠+ كلمة وقاعدة',
      pillar: GrandPillar.hymns,
    ),
    LibraryCategoryItem(
      id: 'rituals',
      title: 'الطقوس والصلوات الكنسية',
      subtitle: 'طقس المعمودية، الإكليل، الجنازات، اللقان، وتدشين الكنائس والمذابح',
      icon: Icons.church_outlined,
      primaryColor: Color(0xFFC49B3C),
      secondaryColor: Color(0xFF8D6E1A),
      route: '/rites',
      badge: '١٠ طقوس كاملة',
      pillar: GrandPillar.hymns,
    ),
    LibraryCategoryItem(
      id: 'sacraments',
      title: 'أسرار الكنيسة السبعة',
      subtitle: 'شرح لاهوتي وطقسي عميق لأسرار الكنيسة مع الشواهد الكتابية والصلوات',
      icon: Icons.water_drop_rounded,
      primaryColor: Color(0xFF00838F),
      secondaryColor: Color(0xFF006064),
      route: '/sacraments',
      badge: 'الأسرار السبعة',
      pillar: GrandPillar.hymns,
    ),
    LibraryCategoryItem(
      id: 'feasts',
      title: 'الأعياد والمناسبات والتقويم',
      subtitle: 'تقويم الأعياد السيدية وحساب عيد القيامة لـ ١٠٠ عام وتحديد الطقس',
      icon: Icons.celebration_rounded,
      primaryColor: Color(0xFFD81B60),
      secondaryColor: Color(0xFF880E4F),
      route: '/feasts',
      badge: 'تقويم ١٠٠ عام',
      pillar: GrandPillar.hymns,
    ),

    // ==========================================
    // البوابة 4: 🌿 الأسرة والحياة الروحية (Family & Spiritual Life)
    // ==========================================
    LibraryCategoryItem(
      id: 'reading_plan',
      title: 'خطة قراءة الكتاب المقدس',
      subtitle: 'خطط سنوية وموسمية لختم العهدين مع تتبع نسبة الإنجاز والتشجيع اليومي',
      icon: Icons.checklist_rtl_rounded,
      primaryColor: Color(0xFF00897B),
      secondaryColor: Color(0xFF004D40),
      route: '/reading-plan',
      badge: 'ختمة سنوية وتتبع',
      pillar: GrandPillar.family,
    ),
    LibraryCategoryItem(
      id: 'prayer_tracker',
      title: 'سجل الصلوات ومنبه الأجبية',
      subtitle: 'متابعة أداء صلوات السواعي يومياً مع تنبيهات مريحة وتذكيرات ذكية',
      icon: Icons.timer_outlined,
      primaryColor: Color(0xFF5E35B1),
      secondaryColor: Color(0xFF311B92),
      route: '/prayer-tracker',
      badge: 'منبه وإحصائيات',
      pillar: GrandPillar.family,
    ),
    LibraryCategoryItem(
      id: 'kids',
      title: 'ركن الأطفال والأسرة (Kids Mode)',
      subtitle: 'قصص الكتاب المقدس المبسطة، صلوات الأطفال اليومية، وركن تلوين كنسي',
      icon: Icons.child_care_rounded,
      primaryColor: Color(0xFF0288D1),
      secondaryColor: Color(0xFF01579B),
      route: '/kids',
      badge: 'قصص • صلوات • تلوين',
      pillar: GrandPillar.family,
    ),
    LibraryCategoryItem(
      id: 'monasteries',
      title: 'دليل الأديرة ومسار العائلة المقدسة',
      subtitle: 'خريطة تفاعلية وإحداثيات GPS ومواعيد الزيارة لـ ٢٠ مزاراً وديراً عامراً',
      icon: Icons.place_rounded,
      primaryColor: Color(0xFF6D4C41),
      secondaryColor: Color(0xFF3E2723),
      route: '/holy-places',
      badge: '٢٠ مزاراً ومسار الرحلة',
      pillar: GrandPillar.family,
    ),
    LibraryCategoryItem(
      id: 'feelings',
      title: 'صلوات حسب المشاعر والمعزيات',
      subtitle: 'صلوات معزية من قلوب الآباء والمزامير لكل شعور (قلق، حزن، فرح، توبة)',
      icon: Icons.sentiment_satisfied_alt_rounded,
      primaryColor: Color(0xFFE91E63),
      secondaryColor: Color(0xFFAD1457),
      route: '/prayers/feelings',
      badge: 'بلسم ومعزيات',
      pillar: GrandPillar.family,
    ),
    LibraryCategoryItem(
      id: 'emotions',
      title: 'صيدلية المشاعر والحاجة',
      subtitle: 'صلوات وآيات ومزامير وتأملات مخصصة لكل حالة روحية (ضيق، قلق، سلام، توبة)',
      icon: Icons.favorite_rounded,
      primaryColor: Color(0xFFBA3838),
      secondaryColor: Color(0xFF8E24AA),
      route: '/prayers/emotions',
      badge: '٢٢ صلاة معزية',
      pillar: GrandPillar.family,
    ),
    LibraryCategoryItem(
      id: 'simple',
      title: 'الوضع المبسط لكبار السن',
      subtitle: 'واجهة خاصة بكروت عملاقة وخطوط عريضة وأهم ٦ ممارسات يومية بلمسة واحدة',
      icon: Icons.accessibility_new_rounded,
      primaryColor: Color(0xFF4527A0),
      secondaryColor: Color(0xFF283593),
      route: '/simple',
      badge: 'فائق البساطة',
      pillar: GrandPillar.family,
    ),
  ];

class LibraryCategoryItem {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color primaryColor;
  final Color secondaryColor;
  final String route;
  final String badge;
  final GrandPillar pillar;

  const LibraryCategoryItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.primaryColor,
    required this.secondaryColor,
    required this.route,
    required this.badge,
    required this.pillar,
  });
}
