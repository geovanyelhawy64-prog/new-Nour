import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../data/models/osama_lotfy_structure.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';
import 'widgets/coptic_rhythm_helper.dart';

class HymnsHomeScreen extends StatefulWidget {
  const HymnsHomeScreen({super.key});

  @override
  State<HymnsHomeScreen> createState() => _HymnsHomeScreenState();
}

class _HymnsHomeScreenState extends State<HymnsHomeScreen> {
  OsamaLotfyPart _selectedPart = OsamaLotfyPart.all;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // خريطة أسماء الألحان للـ ٦٣ لحناً للعرض والبحث الفوري
  static const Map<String, String> _hymnDisplayNames = {
    // الجزء الأول: السنوية
    'ol01_01': 'مزمور العشية وباكر (سبحوا الرب يا جميع الأمم - ني إثنوس تيرو)',
    'ol01_02': 'لحن نسجد لك أيها المسيح (تين أوؤشت إموك)',
    'ol01_03': 'لحن باسم الآب والابن والروح القدس السنوي (خين إفران سنوي)',
    'ol01_04': 'لحن هلم نسجد ونطلب من المسيح ملكنا (أمويني مارين أوؤشت)',
    'ol01_05': 'الهوس الأول (حينئذ سبح موسى وبنو إسرائيل - توتي أف هوس)',
    'ol01_06': 'الهوس الثاني (اشكروا الرب لأنه صالح - أو أونه إيفول)',
    'ol01_07': 'الهوس الثالث (سبحوا الرب في قديسيه - أري هوس إيروف)',
    'ol01_08': 'الهوس الرابع (سبحوا الرب من السموات - إسمو إي إبشويس)',
    'ol01_09': 'مقدمة الثيؤطوكيات السنوية (نعظمك باستحقاق يا أم النور)',
    'ol02_01': 'لحن يا ملك السلام (إبؤرو إنتي تي هيريني)',
    'ol02_02': 'الليلـويا هذا هو اليوم الذي صنعه الرب (فاي بي بي إيهو أو)',
    'ol02_03': 'بهيتين شفاعات والدة الإله القديسة مريم (هيتين ني إفكي)',
    'ol02_04': 'استجابة الإبركسيس السنوية (السلام لك يا مريم)',
    'ol02_05': 'لحن قدوس الله قدوس القوي السنوي (أجيوس أو ثيئوس)',
    'ol02_06': 'إسباسموس سنوي (قبلوا بعضكم بعضاً - أسبازيسثي)',
    'ol02_07': 'الرحمة والسلام وذبيحة التسبيح (بي إخمات)',
    'ol02_08': 'لحن الشاروبيم يسجدون لك (أجيوس أجيوس كيريوس صباؤوت)',
    'ol02_09': 'مرد الاعتراف بموت الرب وقيامته (آمين آمين بموتك)',
    'ol02_10': 'لحن بي أويك (هذا الخبز يجعله جسداً مقدساً له)',

    // الجزء الثاني: الفرايحي
    'ol04_01': 'مزمور الميلاد الفرايحي (الليلويا جي آف ماس)',
    'ol04_02': 'لحن ميلاد المخلص البهيج (بي جين ميسي إن أوموت)',
    'ol04_03': 'لحن أوران سيف إن رومبي (اسم شريف مبارك)',
    'ol04_04': 'الليلـويا جي إن دان (توزيع طقس الغطاس المجيد)',
    'ol04_05': 'لحن اعتمد من يوحنا في الأردن (إيفول هيتين يوحانس)',
    'ol06_01': 'مبارك الآتي باسم الرب الشعانيني (إفلوجيمينوس أوصنا)',
    'ol06_02': 'لحن أوصنا في الأعالي هذا هو ملك إسرائيل',
    'ol06_03': 'لحن سبت إقامة لعازر (فاي بي بي إيهو أو إم فاي)',
    'ol09_01': 'لحن يا كل الصفوف السمائيين (آني خوروس تيرو)',
    'ol09_02': 'لحن المسيح قام من بين الأموات (إخرستوس آنيستي)',
    'ol09_03': 'توزيع القيامة والخمسين المقدسة (كاطا ني خوروس)',
    'ol09_04': 'لحن رآه الرسل وهو صاعد (أراف إيروف إنجي ني أبوستولوس)',
    'ol09_05': 'لحن باكر عيد القيامة المجيد (طو منيما)',
    'ol10_01': 'لحن طأطأ السموات ونزل (أفريك إتفي - عيد الصعود)',
    'ol10_02': 'لحن الروح القدس المعزي المنبثق من الآب (العنصرة)',
    'ol10_03': 'لحن فلنسبح الرب لأنه بالمجد تمجد (أسومين طو كيريو)',
    'ol10_04': 'لحن السلام لرسل فادينا الأطهار (شيري ني أبوستولوس)',
    'ol11_01': 'لحن هذه المجمرة الذهب النقي (طاي شوري)',
    'ol11_02': 'بهيتين والدة الإله القديسة مريم (تذكارات العذراء)',
    'ol11_03': 'لحن افرحي يا مريم العبدة والأم (شيري ثيؤطوكي)',
    'ol11_04': 'مستحق بالحقيقة أن نطوبك يا والدة الإله (أكسيون إستين)',
    'ol11_05': 'ذوكصولوجية الشهيد مارمرقس والشهداء (شيري ني أفا ماركوس)',

    // الجزء الثالث: الحزايني
    'ol05_01': 'لحن أنت هي المجمرة الذهب الصيامية (إنثوك تي تي شوري)',
    'ol05_02': 'مرد الإنجيل الكبير للصوم المقدس (ميغالو إيبروسبين)',
    'ol05_03': 'لحن رتلوا للذي صلب على عود الصليب (أري بسالين الصيامي)',
    'ol05_04': 'ألحان التوبة والتذلل (ني سوس ني فا إفنوتي)',
    'ol05_05': 'مبارك الآتي باسم الرب الصيامي (جي إفماروؤوت)',
    'ol06_04': 'لحن قنديل جمعة ختام الصوم (شيري ني ماريا)',
    'ol07_01': 'لحن لك القوة والمجد والبركة (ثوك تي تي جوم بالهزات)',
    'ol07_02': 'كيرياليصون باللحن الحزايني البصخي (كي إيبير)',
    'ol07_03': 'مرد البصخة (من أجل قيامتك المقدسة نطلب إليك)',
    'ol07_04': 'لحن أيها الابن الوحيد الجنس والكلمة الأزلي (أومونو جينيس)',
    'ol07_05': 'قدوس الله الحزايني البصخي (أجيوس أسبوع الآلام)',
    'ol08_01': 'مرد إنجيل خميس العهد (يهوذا بارادوتيس)',
    'ol08_02': 'لحن كرسيك يا الله إلى دهر الدهور (بيك إثرونوس)',
    'ol08_03': 'لحن فاي إيتاف إنف (ذبيحة الصليب)',
    'ol08_04': 'لحن دفنة المخلص الصالح في القبر (غولغوثا بالهزات الكاملة)',
    'ol08_05': 'مقدمة سفر الرؤيا سبت الفرح والنور (الليلويا بي هوس)',

    // الجزء الرابع: كيهك
    'ol03_01': 'لحن اللهم ارحمنا الكيهكي الكبير (إفنوتي ناي نان)',
    'ol03_02': 'لحن خين إفران الكيهكي المبهج (باسم الآب والابن)',
    'ol03_03': 'لحن نمدحك ونباركك ونسجد لك (تين إن هوس إيروك)',
    'ol03_04': 'لحن المسيح ولد في بيت لحم (آ بي إخرستوس ميسي)',
    'ol03_05': 'إبصالية كيهكية (رتلوا للرب ترتيلاً جديداً - أري بسالين)',
    'ol03_06': 'لحن أم النور المكرمة وفخر جنسنا (ماف إن أونو في)',
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<OsamaLotfyChapter> get _filteredChapters {
    final list = OsamaLotfyCatalog.getChaptersForPart(_selectedPart);
    if (_searchQuery.isEmpty) return list;

    return list.where((chap) {
      final inTitle = chap.title.contains(_searchQuery);
      final inSub = chap.subtitle.contains(_searchQuery);
      final inHymns = chap.hymnIds.any((hid) {
        final name = _hymnDisplayNames[hid] ?? '';
        return name.contains(_searchQuery);
      });
      return inTitle || inSub || inHymns;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final accentGold = isDark ? AppColors.primaryLight : AppColors.primary;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'مختارات من موسوعة أسامة لطفي',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Cairo'),
              ),
              Text(
                'الألحان الكنسية بالهزات (الأجزاء الأربعة الكبرى)',
                style: TextStyle(fontSize: 11, color: accentGold, fontWeight: FontWeight.w600, fontFamily: 'Cairo'),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.speed_rounded, color: accentGold),
              tooltip: 'محاكي الدف والمثلث',
              onPressed: () => CopticRhythmHelperDialog.show(context),
            ),
            const AppQuickMenu(),
          ],
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // كارت التسبحة (الأبصلمودية)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.music_note, color: Color(0xFFC49B3C)),
                    title: const Text('التسبحة (الأبصلمودية)'),
                    subtitle: const Text('هوسات + تئوطوكيات + مديحات + إبصلمودية'),
                    trailing: const Icon(Icons.chevron_left),
                    onTap: () => context.push('/psali'),
                  ),
                ),
              ),
            ),

            // بطاقة رأس الصفحة الفخمة مع بيان المرجع الرسمي
            SliverToBoxAdapter(
              child: _buildHeaderReferenceCard(context, isDark, accentGold),
            ),

            // حقل البحث الذكي في الألحان والأبواب
            SliverToBoxAdapter(
              child: _buildSearchBar(context, isDark, accentGold),
            ),

            // شرائح تصنيف الأجزاء الأربعة لكتاب أسامة لطفي
            SliverToBoxAdapter(
              child: _buildPartFilterBar(context, isDark, accentGold),
            ),

            // قائمة الأبواب الكنسية (المتاحة وقيد الإضافة)
            _filteredChapters.isEmpty
                ? SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.music_off_rounded, size: 50, color: isDark ? Colors.white38 : Colors.black26),
                          const SizedBox(height: 10),
                          const Text(
                            'لم يتم العثور على ألحان أو أبواب مطابقة',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final chapter = _filteredChapters[index];
                          return _buildChapterCard(context, chapter, isDark, accentGold);
                        },
                        childCount: _filteredChapters.length,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderReferenceCard(BuildContext context, bool isDark, Color accentGold) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accentGold.withValues(alpha: isDark ? 0.22 : 0.12),
            accentGold.withValues(alpha: isDark ? 0.08 : 0.03),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accentGold.withValues(alpha: 0.35), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: accentGold.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: accentGold.withValues(alpha: 0.5), width: 1.5),
                ),
                child: Center(
                  child: Icon(Icons.library_music_rounded, color: accentGold, size: 26),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'مختارات من موسوعة أسامة لطفي',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'المرجع: كتاب الألحان بالهزات الموسيقية — الدياكون أسامة لطفي',
                      style: TextStyle(
                        fontSize: 11,
                        color: accentGold,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'مختارات كنسية تضم ٦٣ لحناً مدوناً بالهزات الصوتية ومقسمة للأجزاء الأربعة الكبرى، مع إظهار كافة أبواب الموسوعة تمهيداً للتوسع وإدراج باقي الألحان تدريجياً.',
            style: TextStyle(
              fontSize: 11.5,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              fontFamily: 'Cairo',
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _buildBadgePill('٦٣ لحناً مدوناً', accentGold, isDark),
              _buildBadgePill('٤ أجزاء كبرى', const Color(0xFF2E7D32), isDark),
              _buildBadgePill('١٩ باباً كنسياً', const Color(0xFF1565C0), isDark),
              _buildBadgePill('اهتزاز لمسي للإيقاع', const Color(0xFFD84315), isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadgePill(String text, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : color,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isDark, Color accentGold) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? Colors.white12 : Colors.black12,
            width: 1,
          ),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (val) {
            setState(() {
              _searchQuery = val.trim();
            });
          },
          style: const TextStyle(fontSize: 13, fontFamily: 'Cairo'),
          decoration: InputDecoration(
            hintText: 'ابحث عن لحن أو باب (إبؤرو، غولغوثا، الهوس، ني إثنوس، أجيوس، كيهك)...',
            hintStyle: TextStyle(
              fontSize: 11.5,
              color: isDark ? Colors.white54 : Colors.black45,
              fontFamily: 'Cairo',
            ),
            prefixIcon: Icon(Icons.search_rounded, color: accentGold, size: 20),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear_rounded, size: 18),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildPartFilterBar(BuildContext context, bool isDark, Color accentGold) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        itemCount: OsamaLotfyPart.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final part = OsamaLotfyPart.values[index];
          final isSelected = _selectedPart == part;

          // حساب عدد الألحان في هذا الجزء
          String badgeText = '';
          if (part == OsamaLotfyPart.all) {
            badgeText = '٦٣';
          } else {
            final stats = OsamaLotfyCatalog.getPartStats(part);
            badgeText = '${stats.hymnsCount}';
          }

          return InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() {
                _selectedPart = part;
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? accentGold.withValues(alpha: isDark ? 0.35 : 0.18)
                    : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? accentGold : (isDark ? Colors.white12 : Colors.black12),
                  width: isSelected ? 1.5 : 1.0,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    part.icon,
                    size: 15,
                    color: isSelected ? accentGold : (isDark ? Colors.white70 : Colors.black54),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    part.title,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected
                          ? (isDark ? Colors.white : AppColors.primary)
                          : (isDark ? Colors.white70 : Colors.black87),
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? accentGold
                          : (isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      badgeText,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Colors.black
                            : (isDark ? Colors.white70 : Colors.black54),
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChapterCard(
    BuildContext context,
    OsamaLotfyChapter chapter,
    bool isDark,
    Color accentGold,
  ) {
    final isAvailable = chapter.isAvailable;
    final cardColor = isAvailable
        ? (isDark ? AppColors.surfaceDark : AppColors.surfaceLight)
        : (isDark ? const Color(0xFF1E1D1B) : const Color(0xFFF9F7F5));

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isAvailable
              ? (isDark ? Colors.white12 : Colors.black12)
              : (isDark ? Colors.white.withValues(alpha: 0.06) : Colors.black.withValues(alpha: 0.06)),
          width: isAvailable ? 1.2 : 1.0,
        ),
        boxShadow: isAvailable
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            HapticFeedback.lightImpact();
            if (isAvailable) {
              context.push('/hymns/category/${chapter.id}');
            } else {
              _showEmptyChapterDialog(context, chapter, isDark, accentGold);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: chapter.color.withValues(alpha: isAvailable ? (isDark ? 0.25 : 0.12) : 0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: chapter.color.withValues(alpha: isAvailable ? 0.4 : 0.15),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          chapter.icon,
                          color: isAvailable ? chapter.color : chapter.color.withValues(alpha: 0.5),
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1.5),
                                decoration: BoxDecoration(
                                  color: chapter.color.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  chapter.partNameAr,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: chapter.color,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1.5),
                                decoration: BoxDecoration(
                                  color: isAvailable
                                      ? accentGold.withValues(alpha: 0.12)
                                      : Colors.grey.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  isAvailable
                                      ? '${chapter.count} ألحان بالهزات'
                                      : 'قيد الإضافة من المرجع • ٠ لحن',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w600,
                                    color: isAvailable ? accentGold : Colors.grey,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            chapter.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                              color: isAvailable ? null : (isDark ? Colors.white60 : Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  chapter.subtitle,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: isDark ? const Color(0xFFA69E92) : const Color(0xFF6E655B),
                    fontFamily: 'Cairo',
                    height: 1.4,
                  ),
                ),
                if (isAvailable && chapter.hymnIds.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: chapter.hymnIds.take(4).map((hid) {
                      final title = _hymnDisplayNames[hid] ?? hid;
                      // استخراج الاسم المختصر
                      final shortTitle = title.split('(').first.trim();
                      return InkWell(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          context.push('/hymns/category/${chapter.id}?hymnId=$hid');
                        },
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : Colors.black.withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : Colors.black.withValues(alpha: 0.06),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.music_note_rounded, size: 11, color: Colors.grey),
                              const SizedBox(width: 3),
                              Text(
                                shortTitle,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isDark ? Colors.white70 : Colors.black87,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      isAvailable ? 'عرض وترتيل ألحان الباب' : 'تفاصيل الباب بالمرجع',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isAvailable ? accentGold : Colors.grey,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      isAvailable ? Icons.arrow_forward_rounded : Icons.info_outline_rounded,
                      size: 14,
                      color: isAvailable ? accentGold : Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEmptyChapterDialog(
    BuildContext context,
    OsamaLotfyChapter chapter,
    bool isDark,
    Color accentGold,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: chapter.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(chapter.icon, color: chapter.color, size: 24),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chapter.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          Text(
                            chapter.partNameAr,
                            style: TextStyle(
                              fontSize: 11,
                              color: chapter.color,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: isDark ? 0.15 : 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline_rounded, color: Colors.amber, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'باب معتمد في موسوعة المعلم أسامة لطفي',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'المرجع المعتمد: كتاب الألحان بالهزات الموسيقية (الدياكون أسامة لطفي).\nهذا الباب مدرج في الهيكل الكنسي الكامل وسيتم تدوين نصوصه وتفريغ هزاته الصوتية تباعاً في التحديثات القادمة لضمان الدقة والأصالة الطقسية.',
                              style: TextStyle(
                                fontSize: 11,
                                height: 1.5,
                                color: isDark ? Colors.white70 : Colors.black87,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentGold,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('حسناً، فهمت', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
