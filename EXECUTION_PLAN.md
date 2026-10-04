# الخطة التنفيذية الكاملة — 6 محاور
## من سينيور Flutter 30 سنة + مصمم + عالم لاهوت

---

## المحور الأول: ملء المحتوى ومقارنته بالكتب الرسمية

### الخطوة 1.1: الكتاب المقدس (73 سفر)

**المصدر الرسمي:** نسخة الفانديك SVD (Smith & Van Dyck 1865)

**طريقة الملء:**
```
1. حمّل ملف bible_svd.json من مصدر موثوق
2. حوّله للهيكل المطلوب:
   - bible_books: 73 صف (id, nameAr, nameEn, testament, category, chapterCount)
   - bible_verses: ~31,000 صف (bookId, chapter, verseNumber, text)
3. تأكد من:
   - الأسفار الديوتروكانونيكال السبعة موجودة:
     * طوبيا
     * يهوديت
     * حكمة سليمان
     * يشوع بن سيراخ
     * باروخ
     * رسالة إرميا
     * 1 مكابيين + 2 مكابيين
   - المزامير = 151 مزمور (المزمور 151 موجود في السبعينية)
   - كل سفر فيه العدد الصح من الفصول
   - كل فصل فيه العدد الصح من الآيات
4. قارن 10 أسفار عشوائياً مع st-takla.org
5. أضف التشكيل (الحركات) لكل الآيات
6. أضف cross-references (الآيات المترابطة)
```

**ملف المراجعة:**
```
test/data/bible_integrity_test.dart
- test: عدد الأسفار = 73
- test: عدد المزامير = 151
- test: كل سفر فيه فصول > 0
- test: كل فصل فيه آيات > 0
- test: مفيش آية فاضية
- test: مفيش آية فيها HTML tags
- test: كل آية فيها أكتر من 5 حروف
```

---

### الخطوة 1.2: الأجبية (7 ساعات × 4 مواسم)

**المصدر الرسمي:** أجبية القديس مارمرقس — الطبعة المعتمدة من دير الأنبا مقار

**طريقة الملء:**
```
1. كل ساعة فيها:
   - مقدمة (اللحن + الصلاة)
   - المزامير (مع الأعداد الصحيحة)
   - الإنجيل (المرجع + النص)
   - القطع (حسب الموسم)
   - الأواشي
   - التحليل
   - الختام

2. السبع ساعات بالمزامير:
   - باكر: 50, 62, 89, 148, 149, 150
   - الثالثة: 116, 117
   - السادسة: 53, 54, 55, 56, 57, 58
   - التاسعة: 83, 84, 85, 86, 87, 88
   - الغروب: 114, 115, 116, 117
   - النوم: 4, 6, 12, 13
   - نصف الليل: 119 (3 خدمات: ألف باء تاء)

3. المواسم الأربعة للقطع:
   - سنوي (الأيام العادية)
   - صوم كبير
   - خمسين
   - كيهك

4. كل قطعة فيها:
   - الدور (كاهن / شماس / شعب / الكل)
   - النص العربي كامل
   - النص القبطي (لو موجود)
   - النص الصوتي (لو موجود)
   - المرجع الكتابي (لو موجود)
```

**ملف المراجعة:**
```
test/data/agpeya_integrity_test.dart
- test: عدد الساعات = 7
- test: كل ساعة فيها مزامير
- test: مزامير باكر = [50, 62, 89, 148, 149, 150]
- test: نصف الليل فيها 3 خدمات
- test: كل قطعة فيها دور + نص
- test: مفيش قطعة فاضية
```

---

### الخطوة 1.3: الخولاجي (3 قداسات)

**المصدر الرسمي:** الخولاجي المقدس — طبعة دير الأنبا مقار + خولاجي البابا كيرلس السادس

**طريقة الملء:**
```
1. الأجزاء المشتركة (في كل قداس):
   - رفع بخور باكر
   - تقديم الحمل
   - صلاة الصلح
   - الأواشي (الكبيرة + الصغيرة)
   - قانون الإيمان
   - القسمة
   - الاعتراف
   - التناول
   - الشكر

2. الأجزاء الخاصة بكل قداس:
   - الباسيلي: الأنافورا الباسيلية
   - الغريغوري: الأنافورا الغريغورية
   - الكيرلسي: الأنافورا الكيرلسية

3. كل جزء فيه:
   - الدور (كاهن / كاهن سراً / شماس / شعب / الكل)
   - النص العربي كامل
   - النص القبطي
   - النص الصوتي
   - Rubric (التعليمات الطقسية)
   - isSecret (هل الصلاة سرية؟)
   - الشرح المبسط (للمستخدم العادي)
```

---

### الخطوة 1.4: السنكسار (365 يوم)

**المصدر الرسمي:** السنكسار القبطي — طبعة دير السريان + st-takla.org/Synaxarium/

**طريقة الملء:**
```
1. 13 شهر × 30 يوم + 5-6 نسيء = 365-366 يوم
2. كل يوم فيه 1-5 تذكارات
3. كل تذكار فيه:
   - العنوان
   - النوع (شهيد / معترف / راهب / بطريرك / أسقف / حدث / عيد)
   - النص القصير (2-3 سطور)
   - النص الكامل (فقرة أو فقرتين)
4. قارن الأسماء والتواريخ مع المصدر المطبوع
```

---

### الخطوة 1.5: القطمارس (8 مواسم)

**المصدر الرسمي:** القطمارس المطبوع المعتمد

**طريقة الملء:**
```
1. 8 مواسم:
   - أيام عادية (~240 يوم)
   - صوم كبير (55 يوم)
   - أسبوع الآلام (7 أيام)
   - خمسين (50 يوم)
   - كيهك (30 يوم)
   - صوم الميلاد (43 يوم)
   - صوم الرسل (متغير)
   - صوم العذراء (15 يوم)

2. كل يوم في كل موسم فيه:
   - عشية: بولس + كاثوليكون + إبركسيس + مزمور + إنجيل
   - باكر: بولس + كاثوليكون + إبركسيس + مزمور + إنجيل
   - قداس: بولس + كاثوليكون + إبركسيس + مزمور + إنجيل

3. كل قراءة فيها:
   - المرجع (السفر + الإصحاح + الآيات)
   - النص الكامل
   - نوع القراءة
   - نوع الخدمة
```

---

### الخطوة 1.6: باقي المحتوى

```
الدفنار: 365 يوم × 2 نص (عشية + باكر) × 3 لغات
البصخة: 7 أيام × 12 ساعة × قراءات
الأعياد: 14 عيد سيدي + 7 أصوام
الأسرار: 7 أسرار × أقسام
اللاهوت: 10 تصنيفات × 5-10 مقالات
تاريخ الكنيسة: 4 عصور × 10-15 مقال
القديسين: 300+ قديس × سيرة
الأديرة: 20+ دير وكنيسة × معلومات
الصلوات: 8 تصنيفات × 3-8 صلوات
أقوال الآباء: 500-1000 قول
تأملات: 365 تأمل
أسئلة شائعة: 50-100 سؤال
شرح القداس: 15-20 مقال
دليل الإيمان: هيكل + آداب + معجم
```

---

## المحور الثاني: الألحان — كتاب أسامة لطفي الكامل

### الخطوة 2.1: هيكل الكتاب

**احذف كل ملفات الألحان القديمة** واستبدلها بـ:

```
assets/hymns/
├── part_1_annual/          (الجزء الأول: السنوية)
│   ├── chapter_1_adam_watos.json
│   ├── chapter_2_matins_vespers.json
│   ├── chapter_3_liturgy.json
│   └── chapter_4_psalms.json
├── part_2_festive/         (الجزء الثاني: الفرايحي)
│   ├── chapter_1_christ_feasts.json
│   ├── chapter_2_virgin_feasts.json
│   ├── chapter_3_angels_apostles.json
│   └── chapter_4_saints.json
├── part_3_mournful/        (الجزء الثالث: الحزايني)
│   ├── chapter_1_great_lent.json
│   ├── chapter_2_holy_week.json
│   └── chapter_3_funeral.json
└── part_4_kiahki/          (الجزء الرابع: كيهك)
    ├── chapter_1_kiahki_praise.json
    ├── chapter_2_madihat.json
    └── chapter_3_hymns.json
```

### الخطوة 2.2: شكل ملف اللحن الواحد

```json
{
  "id": "golgotha_good_friday",
  "part": 3,
  "chapter": 2,
  "nameAr": "غولغوثا",
  "nameCoptic": "ⲅⲟⲗⲅⲟⲑⲁ",
  "namePhonetic": "غولغوثا",
  "occasion": "الجمعة الكبير",
  "tone": "حزاني",
  "specialTone": null,
  "segments": [
    {
      "order": 1,
      "coptic": "ⲅⲟⲗⲅⲟⲑⲁ ⲅⲟⲗⲅⲟⲑⲁ",
      "phonetic": "غولغوثا غولغوثا",
      "arabic": "الجولجثة الجولجثة",
      "syllables": [
        {"text": "غول", "accent": "long_rise", "hold": false},
        {"text": "غو", "accent": "trill", "hold": true},
        {"text": "ثا", "accent": "long_fall", "hold": false}
      ]
    }
  ]
}
```

### الخطوة 2.3: الهزات السبعة

| الرمز | الاسم | الوصف | مثال |
|-------|-------|-------|------|
| (بدون) | قصير | نطق عادي | ⲁ |
| ↗ | طويل صاعد | مد + ارتفاع | ⲁ↗ |
| ↘ | طويل هابط | مد + انخفاض | ⲁ↘ |
| 〰 | هزة | ترجيع | ⲁ〰 |
| — | مد | إطالة | ⲁ— |
| ═ | مد مضاعف | إطالة طويلة | ⲁ═ |
| ♪ | ربع تون | نغمة قبطية | ⲁ♪ |

### الخطوة 2.4: الـ DAO الجديد

```dart
@DriftAccessor(tables: [HymnParts, HymnChapters, Hymns, HymnSegments])
class HymnsDao extends DatabaseAccessor<AppDatabase>
    with _$HymnsDaoMixin {
  HymnsDao(super.db);

  // 4 أجزاء
  Future<List<HymnPart>> getAllParts() {
    return (select(hymnParts)
          ..orderBy([(p) => OrderingTerm.asc(p.partOrder)]))
        .get();
  }

  // أبواب الجزء
  Future<List<HymnChapter>> getPartChapters(int partId) {
    return (select(hymnChapters)
          ..where((c) => c.partId.equals(partId))
          ..orderBy([(c) => OrderingTerm.asc(c.chapterOrder)]))
        .get();
  }

  // ألحان الباب
  Future<List<Hymn>> getChapterHymns(String chapterId) {
    return (select(hymns)
          ..where((h) => h.chapterId.equals(chapterId))
          ..orderBy([(h) => OrderingTerm.asc(h.hymnOrder)]))
        .get();
  }

  // مقاطع اللحن مع الهزات
  Future<List<HymnSegment>> getHymnSegments(String hymnId) {
    return (select(hymnSegments)
          ..where((s) => s.hymnId.equals(hymnId))
          ..orderBy([(s) => OrderingTerm.asc(s.segmentOrder)]))
        .get();
  }
}
```

---

## المحور الثالث: أوضاع النص (عربي / قبطي / قبطي معرب)

### الخطوة 3.1: الـ Widget الجديد

```dart
// lib/core/widgets/text_mode_switcher.dart

enum TextMode { arabic, coptic, copticArabic, all }

class TextModeSwitcher extends StatefulWidget {
  final String arabicText;
  final String? copticText;
  final String? phoneticText;
  final TextStyle? style;
  final bool showHymnLayout; // للألحان: 4 أسطر

  const TextModeSwitcher({
    super.key,
    required this.arabicText,
    this.copticText,
    this.phoneticText,
    this.style,
    this.showHymnLayout = false,
  });

  @override
  State<TextModeSwitcher> createState() => _TextModeSwitcherState();
}

class _TextModeSwitcherState extends State<TextModeSwitcher> {
  TextMode _mode = TextMode.arabic;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // أزرار التبديل
        SegmentedButton<TextMode>(
          segments: [
            ButtonSegment(value: TextMode.arabic, label: Text('عربي')),
            if (widget.copticText != null)
              ButtonSegment(value: TextMode.coptic, label: Text('قبطي')),
            if (widget.phoneticText != null)
              ButtonSegment(value: TextMode.copticArabic, label: Text('قبطي معرب')),
            if (widget.showHymnLayout)
              ButtonSegment(value: TextMode.all, label: Text('كل')),
          ],
          selected: {_mode},
          onSelectionChanged: (modes) => setState(() => _mode = modes.first),
        ),
        const SizedBox(height: 16),
        // النص حسب الوضع
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _buildText(),
        ),
      ],
    );
  }

  Widget _buildText() {
    switch (_mode) {
      case TextMode.arabic:
        return Text(widget.arabicText, style: widget.style);
      case TextMode.coptic:
        return Text(widget.copticText ?? '', style: widget.style);
      case TextMode.copticArabic:
        return Text(widget.phoneticText ?? '', style: widget.style);
      case TextMode.all:
        return Column(children: [
          if (widget.copticText != null)
            Text(widget.copticText!, style: _copticStyle),
          if (widget.phoneticText != null)
            Text(widget.phoneticText!, style: _phoneticStyle),
          Text(widget.arabicText, style: widget.style),
        ]);
    }
  }
}
```

### الخطوة 3.2: حفظ الوضع المفضل

```dart
// في reading_preferences.dart
enum TextMode { arabic, coptic, copticArabic, all }

class ReadingPreferences {
  final TextMode defaultTextMode; // الوضع الافتراضي
  // ... باقي الإعدادات
}
```

### الخطوة 3.3: الاستخدام في كل شاشة

```dart
// في أي شاشة فيها نصوص:
TextModeSwitcher(
  arabicText: section.textAr,
  copticText: section.textCoptic,
  phoneticText: section.textPhonetic,
  showHymnLayout: isHymnScreen,
)
```

---

## المحور الرابع والخامس: الألوان والثيم (مريح للعين)

### الخطوة 4.1: ملف الثيم الكامل

```dart
// lib/core/theme/app_theme.dart

class NoorColors {
  // الفاتح
  static const lightBackground = Color(0xFFFAF6F0);    // كريمي دافئ
  static const lightSurface = Color(0xFFFFFFFF);        // أبيض
  static const lightPrimary = Color(0xFF1B2A4A);        // أزرق داكن قبطي
  static const lightGold = Color(0xFFC49B3C);           // ذهبي قبطي
  static const lightText = Color(0xFF2D2D2D);           // أسود ناعم
  static const lightTextSecondary = Color(0xFF6B6B6B);  // رمادي دافئ
  static const lightBorder = Color(0xFFE8E0D4);         // بيج
  static const lightPriest = Color(0xFF8B2500);         // أحمر قبطي
  static const lightDeacon = Color(0xFF1B4F72);         // أزرق هادئ
  static const lightPeople = Color(0xFF1E6B3A);         // أخضر هادئ
  static const lightFast = Color(0xFF5B2C6F);           // بنفسجي

  // الغامق
  static const darkBackground = Color(0xFF141821);      // أزرق/أسود
  static const darkSurface = Color(0xFF1E2433);          // أزرق داكن
  static const darkPrimary = Color(0xFF0D1117);          // أسود مائل للأزرق
  static const darkGold = Color(0xFFD4A843);             // ذهبي فاتح
  static const darkText = Color(0xFFE8DFD0);             // كريمي
  static const darkTextSecondary = Color(0xFF9B9484);    // بيج
  static const darkBorder = Color(0xFF2A3040);           // أزرق داكن
  static const darkPriest = Color(0xFFD4574A);           // أحمر فاتح
  static const darkDeacon = Color(0xFF5B9BD5);           // أزرق فاتح
  static const darkPeople = Color(0xFF5CB85C);           // أخضر فاتح
  static const darkFast = Color(0xFF9B59B6);             // بنفسجي فاتح
}

class NoorTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: NoorColors.lightBackground,
    colorScheme: ColorScheme.light(
      primary: NoorColors.lightPrimary,
      secondary: NoorColors.lightGold,
      surface: NoorColors.lightSurface,
      onSurface: NoorColors.lightText,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: NoorColors.lightPrimary,
      foregroundColor: NoorColors.lightGold,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      color: NoorColors.lightSurface,
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.06),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: NoorColors.lightBorder, width: 0.5),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: NoorColors.lightPrimary,
        height: 1.6,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: NoorColors.lightPrimary,
        height: 1.5,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Amiri',
        fontSize: 20,
        color: NoorColors.lightText,
        height: 2.0,  // مسافة بين السطور مريحة
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Amiri',
        fontSize: 18,
        color: NoorColors.lightText,
        height: 1.9,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14,
        color: NoorColors.lightTextSecondary,
        height: 1.6,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: NoorColors.lightSurface,
      indicatorColor: NoorColors.lightGold.withOpacity(0.2),
      elevation: 0,
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: NoorColors.darkBackground,
    colorScheme: ColorScheme.dark(
      primary: NoorColors.darkGold,
      secondary: NoorColors.darkGold,
      surface: NoorColors.darkSurface,
      onSurface: NoorColors.darkText,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: NoorColors.darkPrimary,
      foregroundColor: NoorColors.darkGold,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      color: NoorColors.darkSurface,
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: NoorColors.darkBorder, width: 0.5),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: NoorColors.darkGold,
        height: 1.6,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: NoorColors.darkGold,
        height: 1.5,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Amiri',
        fontSize: 20,
        color: NoorColors.darkText,
        height: 2.0,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Amiri',
        fontSize: 18,
        color: NoorColors.darkText,
        height: 1.9,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14,
        color: NoorColors.darkTextSecondary,
        height: 1.6,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: NoorColors.darkSurface,
      indicatorColor: NoorColors.darkGold.withOpacity(0.15),
      elevation: 0,
    ),
  );
}
```

### الخطوة 4.2: قواعد التصميم

```
القاعدة 1: مفيش أبيض ناصع (#FFFFFF) كخلفية → استخدم #FAF6F0
القاعدة 2: مفيش أسود ناصع (#000000) كنص → استخدم #2D2D2D
القاعدة 3: مفيش أسود ناصع كخلفية غامقة → استخدم #141821
القاعدة 4: مفيش أبيض ناصع كنص غامق → استخدم #E8DFD0
القاعدة 5: المسافة بين السطور ≥ 1.8 للقراءة الطويلة
القاعدة 6: حجم الخط الأساسي ≥ 18
القاعدة 7: الـ padding الداخلي ≥ 16
القاعدة 8: الـ border radius = 12 للكروت
القاعدة 9: الـ shadows خفيفة جداً (opacity ≤ 0.08)
القاعدة 10: الألوان الدافئة (كريمي + ذهبي + بيج) هي الأساس
```

---

## المحور السادس: تقسيم التطبيق + أنيميشن + أيقونات

### الخطوة 6.1: التقسيم الجديد (6 مجموعات)

```
شريط التنقل: 🏠 اليوم | 📖 الكتاب | 🎵 الألحان | ⋮

صفحة المحتوى (تفتح من 🏠 أو من ⋮):

┌─────────────────────────────────────┐
│  📕 الصلوات والطقوس                  │
│  ┌───────┐ ┌───────┐ ┌───────┐    │
│  │  ⛪   │ │  🏛️   │ │  🙏   │    │
│  │الأجبية │ │القداس  │ │الصلوات │    │
│  │       │ │والطقوس │ │       │    │
│  └───────┘ └───────┘ └───────┘    │
├─────────────────────────────────────┤
│  📅 القراءات اليومية                 │
│  ┌───────┐ ┌───────┐ ┌───────┐    │
│  │  📚   │ │  📜   │ │  🕯️   │    │
│  │القطمارس│ │السنكسار│ │البصخة  │    │
│  │       │ │والدفنار│ │       │    │
│  └───────┘ └───────┘ └───────┘    │
├─────────────────────────────────────┤
│  ✝️ المعرفة                          │
│  ┌───────┐ ┌───────┐ ┌───────┐    │
│  │  📅   │ │  💧   │ │  📜   │    │
│  │التقويم │ │الأسرار │ │التاريخ │    │
│  │       │ │       │ │       │    │
│  └───────┘ └───────┘ └───────┘    │
│  ┌───────┐ ┌───────┐              │
│  │  📕   │ │  ❓   │              │
│  │اللاهوت │ │دليل   │              │
│  │       │ │الإيمان │              │
│  └───────┘ └───────┘              │
├─────────────────────────────────────┤
│  👤 القديسين والأماكن                │
│  ┌───────┐ ┌───────┐              │
│  │  ✝️   │ │  🏛️   │              │
│  │القديسين│ │الأديرة │              │
│  │       │ │       │              │
│  └───────┘ └───────┘              │
└─────────────────────────────────────┘
```

### الخطوة 6.2: الأزرار الزيادة اللي لازم تتشال

```
❌ شال: زر المفضلة المنفصل في الشريط السفلي
   السبب: موجود أصلاً في ⋮ menu

❌ شال: زر "أكثر" المنفصل
   السبب: موجود أصلاً في ⋮ menu

❌ شال: أي زر "رجوع" في الشريط العلوي لو فيه زر في الـ AppBar
   السبب: تكرار

❌ شال: أي زر "مشاركة" منفصل في الشريط السفلي
   السبب: موجود أصلاً في ⋮ menu

❌ شال: أي زر "إعدادات" منفصل في أي شاشة
   السبب: موجود أصلاً في ⋮ menu

❌ شال: أي زر "بحث" منفصل في أي شاشة
   السبب: موجود أصلاً في ⋮ menu + في شريط التنقل
```

### الخطوة 6.3: الأزرار اللي لازم تتضاف

```
✅ أضف: زر [عربي | قبطي | قبطي معرب] في كل شاشة نصية
   المكان: تحت الـ AppBar مباشرة

✅ أضف: زر ⚠️ صغير في أسفل كل شاشة محتوى
   الوظيفة: إبلاغ عن خطأ

✅ أضف: زر 🔊 في كل شاشة صلاة/لحن
   الوظيفة: استماع (TTS)

✅ أضف: زر ▶ صغير في شاشات القراءة الطويلة
   الوظيفة: تمرير تلقائي
```

### الخطوة 6.4: الأنيميشن

```dart
// lib/core/theme/app_animations.dart

class NoorAnimations {
  // فتح الشاشة
  static const pageTransition = Duration(milliseconds: 250);
  static const pageCurve = Curves.easeOutCubic;

  // فتح كارت
  static const cardAppear = Duration(milliseconds: 200);
  static const cardCurve = Curves.easeOut;

  // الضغط على زر
  static const buttonPress = Duration(milliseconds: 100);

  // تبديل وضع النص
  static const textModeSwitch = Duration(milliseconds: 200);

  // Dark/Light mode
  static const themeSwitch = Duration(milliseconds: 400);

  // Fade in للعناصر
  static const fadeIn = Duration(milliseconds: 300);

  // Scroll سلس
  static const smoothScroll = Duration(milliseconds: 500);
  static const scrollCurve = Curves.easeInOut;
}

// الاستخدام في الـ Router:
GoRouter(
  pageBuilder: (context, state) => CustomTransitionPage(
    child: state.pageBuilder(context),
    transitionsBuilder: (context, animation, secondary, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.3, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: NoorAnimations.pageCurve,
        )),
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
    transitionDuration: NoorAnimations.pageTransition,
  ),
)
```

### الخطوة 6.5: الأيقونات

```dart
// lib/core/theme/app_icons.dart

class NoorIcons {
  // الصلوات والطقوس
  static const agpeya = Icons.access_time_rounded;
  static const liturgy = Icons.church_rounded;
  static const prayers = Icons.hands_praying;  // أو Icons.favorite

  // القراءات
  static const katameros = Icons.menu_book_rounded;
  static const synaxarium = Icons.auto_stories_rounded;
  static const pascha = Icons.local_fire_department_rounded;

  // المعرفة
  static const calendar = Icons.calendar_month_rounded;
  static const sacraments = Icons.water_drop_rounded;
  static const theology = Icons.school_rounded;
  static const history = Icons.history_edu_rounded;
  static const faith = Icons.help_outline_rounded;

  // القديسين والأماكن
  static const saints = Icons.person_rounded;
  static const monasteries = Icons.account_balance_rounded;

  // عام
  static const bible = Icons.auto_stories_rounded;
  static const hymns = Icons.music_note_rounded;
  static const search = Icons.search_rounded;
  static const bookmark = Icons.bookmark_rounded;
  static const settings = Icons.settings_rounded;
  static const darkMode = Icons.dark_mode_rounded;
  static const lightMode = Icons.light_mode_rounded;
}
```

---

## خطة التنفيذ النهائية (بالترتيب)

| # | المهمة | الأيام | معيار النجاح |
|---|--------|--------|-------------|
| 1 | الثيم والألوان الجديدة | 2 | فاتح + غامق مريحين للعين |
| 2 | الأيقونات والأنيميشن | 2 | سلسة + واضحة |
| 3 | تقسيم التطبيق الجديد | 3 | 6 مجموعات + 3 أزرار + ⋮ |
| 4 | حذف الأزرار الزيادة | 1 | صفر تكرار |
| 5 | إضافة الأزرار الجديدة | 1 | عربي/قبطي/معرب + إبلاغ + استماع |
| 6 | TextModeSwitcher widget | 2 | 3 أوضاع + حفظ التفضيل |
| 7 | هيكل الألحان الجديد | 3 | 4 أجزاء حسب أسامة لطفي |
| 8 | HymnsDao الجديد | 2 | CRUD كامل + هزات |
| 9 | ملء الكتاب المقدس | 5 | 73 سفر + 151 مزمور + مراجعة |
| 10 | ملء الأجبية | 4 | 7 ساعات × 4 مواسم + مراجعة |
| 11 | ملء الخولاجي | 4 | 3 قداسات + طقوس + مراجعة |
| 12 | ملء الألحان | 5 | كتاب أسامة لطفي كامل + هزات |
| 13 | ملء السنكسار + الدفنار | 4 | 365 يوم + مراجعة |
| 14 | ملء القطمارس | 5 | 8 مواسم + مراجعة |
| 15 | ملء الباقي | 5 | كل الكاتيجوريز + مراجعة |
| 16 | المراجعة النهائية | 3 | 10 Agents + تقرير |
| 17 | النشر | 2 | Play Store + App Store |

**المجموع: 57 يوم ≈ 8 أسابيع**
