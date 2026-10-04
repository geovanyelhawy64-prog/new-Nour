import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/database_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class TheologyHomeScreen extends StatefulWidget {
  const TheologyHomeScreen({super.key});

  @override
  State<TheologyHomeScreen> createState() => _TheologyHomeScreenState();
}

class _TheologyHomeScreenState extends State<TheologyHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<TheologyArticle> _searchResults = [];
  bool _isSearching = false;
  bool _isLoadingSearch = false;

  static const _topics = [
    _TheologyTopic(
      'trinity',
      'عقيدة الثالوث القدوس',
      'وحدانية الجوهر وتثليث الأقانيم: الآب الينبوع، والابن المولود أزلياً، والروح القدس المنبثق',
      Icons.stars_rounded,
      Color(0xFF00695C),
    ),
    _TheologyTopic(
      'nature_of_christ',
      'طبيعة السيد المسيح',
      'التجسد الإلهي: طبيعة واحدة متجسدة لله الكلمة بغير اختلاط ولا امتزاج ولا تغيير ولا انفصال',
      Icons.psychology_rounded,
      Color(0xFF1565C0),
    ),
    _TheologyTopic(
      'redemption',
      'الفداء: الصليب والقيامة',
      'ذبيحة الصليب الكفارية، النزول إلى الجحيم، باكورة القيامة المجيدة، والصعود الإلهي للأعالي',
      Icons.favorite_rounded,
      Color(0xFFC62828),
    ),
    _TheologyTopic(
      'church',
      'الكنيسة: طبيعتها ورسالتها',
      'جسد المسيح السري، سمات الكنيسة في قانون الإيمان، شركة القديسين، والخلافة الرسولية والكهنوت',
      Icons.church_rounded,
      Color(0xFF5D4037),
    ),
    _TheologyTopic(
      'sacraments',
      'الأسرار الكنسية: شرح لاهوتي',
      'النعمة غير المنظورة، مفاعيل المعمودية والميرون، حقيقة الإفخارستيا، وسلطان مغفرة الخطايا',
      Icons.account_balance_rounded,
      Color(0xFF7B1FA2),
    ),
    _TheologyTopic(
      'theotokos',
      'العذراء مريم: والدة الإله',
      'عقيدة الثيؤطوكوس بمجمع أفسس، دوام البتولية، حواء الجديدة، والشفاعة التوسلية لأم النور',
      Icons.auto_awesome_rounded,
      Color(0xFFE65100),
    ),
    _TheologyTopic(
      'angels',
      'عالم الملائكة والأجناد السماوية',
      'طبيعة الملائكة، الطغمات السمائية التسع، رؤساء الملائكة السبعة، وحراسة المؤمنين',
      Icons.diversity_3_rounded,
      Color(0xFF0288D1),
    ),
    _TheologyTopic(
      'salvation',
      'مفهوم الخلاص والجهاد',
      'الخلاص مسيرة حياة، عقيدة التأله بالنعمة، الإيمان الحي العامل بالمحبة، والحرية الإنسانية',
      Icons.shield_rounded,
      Color(0xFF2E7D32),
    ),
    _TheologyTopic(
      'ecumenical_councils',
      'المجامع المسكونية وقانون الإيمان',
      'مجمع نيقية ٣٢٥م، مجمع القسطنطينية ٣٨١م، مجمع أفسس ٤٣١م، وشرح بنود الإيمان الأرثوذكسي',
      Icons.groups_rounded,
      Color(0xFF6A1B9A),
    ),
    _TheologyTopic(
      'heresies',
      'الهرطقات والردود العقائدية',
      'دحض البدع التاريخية: الردود الآبائية المفحمة على بدع أريوس، مقدونيوس، نسطور، وأوطاخي',
      Icons.verified_user_rounded,
      Color(0xFFC2185B),
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

    final results = await DatabaseService.instance.theologyDao.searchArticles(trimmed);
    if (mounted) {
      setState(() {
        _searchResults = results;
        _isLoadingSearch = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('العقيدة واللاهوت الأرثوذكسي'),
          actions: const [
            AppQuickMenu(),
          ],
        ),
        body: Column(
          children: [
            // شريط البحث في المقالات اللاهوتية
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'ابحث في العقيدة واللاهوت والردود...',
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
                  : _buildTopicsList(),
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
            Text('لا توجد نتائج مطابقة لبحثك العقائدي', style: AppTypography.heading3),
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
                'النتائج: ${_searchResults.length} مقال',
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
              final article = _searchResults[index];
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => context.push('/theology/article/${article.id}'),
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
                            Icons.psychology_rounded,
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
                                article.title,
                                style: AppTypography.heading3.copyWith(fontSize: 15),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                article.categoryAr,
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.gold,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                article.content.replaceAll('\n', ' '),
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textSecondaryLight,
                                  height: 1.4,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
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

  Widget _buildTopicsList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _topics.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final t = _topics[index];
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => context.push('/theology/topic/${t.id}'),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: t.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(t.icon, color: t.color, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.title, style: AppTypography.heading3.copyWith(fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(t.description, style: AppTypography.caption, maxLines: 2),
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

class _TheologyTopic {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _TheologyTopic(this.id, this.title, this.description, this.icon, this.color);
}
