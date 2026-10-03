import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/common/empty_view.dart';
import '../../../../widgets/common/error_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class FeelingDefinition {
  final String id;
  final String categoryKey;
  final String name;
  final IconData icon;
  final Color color;
  final String verse;
  final String reference;

  const FeelingDefinition({
    required this.id,
    required this.categoryKey,
    required this.name,
    required this.icon,
    required this.color,
    required this.verse,
    required this.reference,
  });
}

class FeelingsScreen extends StatefulWidget {
  final String? initialFeeling;

  const FeelingsScreen({super.key, this.initialFeeling});

  @override
  State<FeelingsScreen> createState() => _FeelingsScreenState();
}

class _FeelingsScreenState extends State<FeelingsScreen> {
  static const List<FeelingDefinition> feelings = [
    FeelingDefinition(
      id: 'anxiety',
      categoryKey: 'feeling_anxiety',
      name: 'قلق',
      icon: Icons.air_rounded,
      color: Color(0xFFE65100),
      verse: '«سَلاَمًا أَتْرُكُ لَكُمْ. سَلاَمِي أُعْطِيكُمْ. لاَ تَضْطَرِبْ قُلُوبُكُمْ وَلاَ تَرْهَبْ»',
      reference: 'إنجيل يوحنا ١٤ : ٢٧',
    ),
    FeelingDefinition(
      id: 'sadness',
      categoryKey: 'feeling_sadness',
      name: 'حزن',
      icon: Icons.water_drop_outlined,
      color: Color(0xFF1565C0),
      verse: '«طُوبَى لِلْحَزَانَى، لأَنَّهُمْ يُتَعَزَّوْنَ»',
      reference: 'إنجيل متى ٥ : ٤',
    ),
    FeelingDefinition(
      id: 'joy',
      categoryKey: 'feeling_joy',
      name: 'فرح',
      icon: Icons.light_mode_outlined,
      color: Color(0xFFF9A825),
      verse: '«افْرَحُوا فِي الرَّبِّ كُلَّ حِينٍ، وَأَقُولُ أَيْضًا: افْرَحُوا»',
      reference: 'رسالة فيلبي ٤ : ٤',
    ),
    FeelingDefinition(
      id: 'repentance',
      categoryKey: 'feeling_repentance',
      name: 'توبة',
      icon: Icons.favorite_border_rounded,
      color: Color(0xFF7B1FA2),
      verse: '«قَلْبًا نَقِيًّا اخْلُقْ فِيَّ يَا اَللهُ، وَرُوحًا مُسْتَقِيمًا جَدِّدْ فِي دَاخِلِي»',
      reference: 'مزمور ٥١ : ١٠',
    ),
    FeelingDefinition(
      id: 'sickness',
      categoryKey: 'feeling_sickness',
      name: 'مرض',
      icon: Icons.local_hospital_outlined,
      color: Color(0xFF00897B),
      verse: '«يَا رَبُّ إِلَهِي، اسْتَغَثْتُ بِكَ فَشَفَيْتَنِي»',
      reference: 'مزمور ٣٠ : ٢',
    ),
  ];

  late int _selectedFeelingIndex;
  late Future<List<OccasionalPrayer>> _prayersFuture;
  late double _fontSize;

  @override
  void initState() {
    super.initState();
    _fontSize = PreferencesService.getFontSize();

    final foundIndex = feelings.indexWhere((f) => f.id == widget.initialFeeling);
    _selectedFeelingIndex = foundIndex != -1 ? foundIndex : 0;
    _loadPrayers();
  }

  void _loadPrayers() {
    final activeFeeling = feelings[_selectedFeelingIndex];
    setState(() {
      _prayersFuture = DatabaseService.instance.prayersDao
          .getPrayersByCategory(activeFeeling.categoryKey);
    });
  }

  void _selectFeeling(int index) {
    if (_selectedFeelingIndex != index) {
      HapticFeedback.selectionClick();
      setState(() {
        _selectedFeelingIndex = index;
      });
      _loadPrayers();
    }
  }

  void _copyPrayer(OccasionalPrayer prayer) {
    HapticFeedback.lightImpact();
    final text = '« ${prayer.title} »\n\n${prayer.content}\n\n[من صلوات تطبيق نور]';
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ نص الصلاة إلى الحافظة بنجاح'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _sharePrayer(OccasionalPrayer prayer) async {
    HapticFeedback.lightImpact();
    final text = '« ${prayer.title} »\n\n${prayer.content}\n\n من صلوات تطبيق نور الأرثوذكسي ';
    await SharePlus.instance.share(ShareParams(text: text, subject: prayer.title));
  }

  @override
  Widget build(BuildContext context) {
    final active = feelings[_selectedFeelingIndex];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('صلاة حسب المشاعر'),
          actions: [
            IconButton(
              icon: const Icon(Icons.text_decrease_rounded),
              tooltip: 'تصغير الخط',
              onPressed: () {
                if (_fontSize > 14) {
                  setState(() => _fontSize -= 2.0);
                  PreferencesService.setFontSize(_fontSize);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.text_increase_rounded),
              tooltip: 'تكبير الخط',
              onPressed: () {
                if (_fontSize < 36) {
                  setState(() => _fontSize += 2.0);
                  PreferencesService.setFontSize(_fontSize);
                }
              },
            ),
            const AppQuickMenu(),
          ],
        ),
        body: Column(
          children: [
            // 1. شريط اختيار المشاعر الخمسة
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
                  ),
                ),
              ),
              child: SizedBox(
                height: 52,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: feelings.length,
                  itemBuilder: (context, index) {
                    final item = feelings[index];
                    final isSelected = index == _selectedFeelingIndex;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: InkWell(
                        onTap: () => _selectFeeling(index),
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? item.color.withValues(alpha: isDark ? 0.25 : 0.15)
                                : isDark
                                    ? Colors.white.withValues(alpha: 0.04)
                                    : Colors.black.withValues(alpha: 0.03),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? item.color
                                  : isDark
                                      ? Colors.white10
                                      : Colors.black.withValues(alpha: 0.08),
                              width: isSelected ? 1.8 : 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                item.icon,
                                size: 20,
                                color: item.color,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item.name,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  color: isSelected
                                      ? (isDark ? Colors.white : item.color)
                                      : (isDark
                                          ? AppColors.textSecondaryDark
                                          : AppColors.textSecondaryLight),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // 2. بطاقة الشاهد المعزي الخاص بالشعور المختار
            Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 6),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: active.color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: active.color.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(Icons.format_quote_rounded, color: active.color, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        'وعد كتابي لقلبك في الـ${active.name}:',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: active.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    active.verse,
                    style: AppTypography.scripture.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      height: 1.7,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    active.reference,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: active.color,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),

            // 3. قائمة الصلوات الخاصة بالشعور المختار
            Expanded(
              child: FutureBuilder<List<OccasionalPrayer>>(
                future: _prayersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingView(message: 'جاري تحميل الصلوات...');
                  }

                  if (snapshot.hasError) {
                    return ErrorView(
                      message: 'حدث خطأ أثناء تحميل الصلوات',
                      onRetry: _loadPrayers,
                    );
                  }

                  final prayers = snapshot.data ?? [];
                  if (prayers.isEmpty) {
                    return const EmptyView(
                      message: 'لا توجد صلوات متاحة لهذا الشعور',
                      subtitle: 'سيتم إضافة المزيد من الصلوات قريباً',
                      icon: Icons.volunteer_activism_rounded,
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: prayers.length,
                    itemBuilder: (context, index) {
                      final prayer = prayers[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: active.color.withValues(alpha: 0.2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // رأس الصلاة
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: active.color.withValues(alpha: 0.08),
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: active.color,
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      prayer.title,
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // نص الصلاة
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                prayer.content,
                                style: AppTypography.scripture.copyWith(
                                  fontSize: _fontSize,
                                  height: 1.85,
                                  color: isDark
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textPrimaryLight,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),

                            // ذيل البطاقة: أزرار النسخ والمشاركة
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                              child: Row(
                                children: [
                                  OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: active.color,
                                      side: BorderSide(
                                        color: active.color.withValues(alpha: 0.4),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    icon: const Icon(Icons.copy_rounded, size: 16),
                                    label: const Text('نسخ'),
                                    onPressed: () => _copyPrayer(prayer),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: active.color,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    icon: const Icon(Icons.share_rounded, size: 16),
                                    label: const Text('مشاركة'),
                                    onPressed: () => _sharePrayer(prayer),
                                  ),
                                  const Spacer(),
                                  Text(
                                    ' آمين',
                                    style: TextStyle(
                                      color: active.color.withValues(alpha: 0.7),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
