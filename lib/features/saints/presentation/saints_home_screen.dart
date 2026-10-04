import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/coptic_calendar/coptic_date.dart';
import '../../../../core/services/database_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class SaintsHomeScreen extends StatefulWidget {
  const SaintsHomeScreen({super.key});

  @override
  State<SaintsHomeScreen> createState() => _SaintsHomeScreenState();
}

class _SaintsHomeScreenState extends State<SaintsHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Saint> _searchResults = [];
  bool _isSearching = false;
  bool _isLoadingSearch = false;

  static const _categories = [
    _SaintCategory(
      'all',
      'جميع سير القديسين والشهداء',
      'فهرس شامل يضم أكثر من ٧٠٠ قديس وشهيد عبر تاريخ الكنيسة القبطية',
      Icons.auto_stories_rounded,
      Color(0xFF6A1B9A),
    ),
    _SaintCategory(
      'martyrs',
      'الشهداء الأبرار',
      'مارجرجس، مارمينا، أبانوب، الشهيدة دميانة والأربعين عذراء وشهداء الإيمان',
      Icons.military_tech_rounded,
      Color(0xFFC62828),
    ),
    _SaintCategory(
      'monks',
      'آباء الرهبنة والنساك',
      'الأنبا أنطونيوس كوكب البرية، الأنبا بولا، الأنبا مكاريوس، الأنبا باخوميوس',
      Icons.terrain_rounded,
      Color(0xFF5D4037),
    ),
    _SaintCategory(
      'patriarchs',
      'البطاركة والأساقفة حماة الإيمان',
      'أثناسيوس الرسولي، كيرلس عمود الدين، ديسقورس بطل الأرثوذكسية',
      Icons.church_rounded,
      Color(0xFF1565C0),
    ),
    _SaintCategory(
      'archangel',
      'رؤساء الملائكة والأجناد السمائية',
      'ميخائيل، غبريال المبشر، رافائيل طبيب الأوجاع، وسائر الطغمات النورانية',
      Icons.flight_rounded,
      Color(0xFF00838F),
    ),
    _SaintCategory(
      'virgin',
      'العذارى والشهيدات القديسات',
      'السيدة العذراء مريم، دميانة والأربعين عذراء، مارينا، فيرينا، وأربسيما',
      Icons.favorite_rounded,
      Color(0xFFE91E63),
    ),
    _SaintCategory(
      'modern',
      'قديسو العصر الحديث',
      'البابا كيرلس السادس، الأرشيدياكون حبيب جرجس، القمص بيشوي كامل',
      Icons.auto_awesome_rounded,
      Color(0xFFF57F17),
    ),
    _SaintCategory(
      'women',
      'القديسات والأمهات البارات',
      'القديسة حنة والدة العذراء، القديسة مونيكا، سارة وبائيسة والأمهات القديسات',
      Icons.diversity_1_rounded,
      Color(0xFFAD1457),
    ),
    _SaintCategory(
      'saints',
      'القديسون والمعترفون',
      'رسل المسيح الأطهار، المعترفون، والآباء المعلمون',
      Icons.stars_rounded,
      Color(0xFF00695C),
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = [];
        _isLoadingSearch = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _isLoadingSearch = true;
    });

    final results = await DatabaseService.instance.saintsDao.searchSaints(trimmed);
    if (mounted) {
      setState(() {
        _searchResults = results;
        _isLoadingSearch = false;
      });
    }
  }

  String _formatFeastDate(int? month, int? day) {
    if (month == null || day == null) return '';
    if (month < 1 || month > 13) return '';
    return '$day ${CopticDate.monthNames[month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('سير القديسين والشهداء'),
          actions: const [
            AppQuickMenu(),
          ],
        ),
        body: Column(
          children: [
            // شريط البحث المباشر
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'ابحث في كافة سير القديسين...',
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 20),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),

            Expanded(
              child: _isSearching
                  ? _buildSearchResults()
                  : _buildCategoriesList(),
            ),
          ],
        ),
      );
  }

  Widget _buildSearchResults() {
    if (_isLoadingSearch) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off_rounded, size: 48, color: AppColors.textSecondaryLight),
            const SizedBox(height: 12),
            Text('لا توجد نتائج مطابقة للبحث', style: AppTypography.heading3),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Row(
            children: [
              Text(
                'النتائج: ${_searchResults.length} قديس',
                style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _searchResults.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final saint = _searchResults[index];
              final feastText = _formatFeastDate(saint.feastMonth, saint.feastDay);

              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => context.push('/saints/detail/${saint.id}'),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person_rounded,
                            color: AppColors.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                saint.nameAr,
                                style: AppTypography.heading3.copyWith(fontSize: 16),
                              ),
                              if (feastText.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  'التذكار: $feastText',
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.gold,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                              if (saint.shortBio.isNotEmpty) ...[
                                const SizedBox(height: 6),
                                Text(
                                  saint.shortBio,
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.textSecondaryLight,
                                    height: 1.4,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: AppColors.textSecondaryLight,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _categories.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final cat = _categories[index];
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => context.push('/saints/category/${cat.id}'),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: cat.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(cat.icon, color: cat.color, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cat.title, style: AppTypography.heading3.copyWith(fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(cat.description, style: AppTypography.caption, maxLines: 2),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textSecondaryLight),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SaintCategory {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _SaintCategory(this.id, this.title, this.description, this.icon, this.color);
}
