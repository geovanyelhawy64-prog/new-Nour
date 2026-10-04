import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/utils/scripture_reference_resolver.dart';
import '../../../../data/database/daos/search_dao.dart';
import '../../../../widgets/common/empty_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/common/highlighted_text.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<UnifiedSearchResult> _results = [];
  bool _isLoading = false;
  String? _selectedFilter;
  ResolvedScriptureRef? _directRef;

  final _filters = [
    {'id': null, 'label': 'الكل'},
    {'id': 'bible', 'label': 'الكتاب المقدس'},
    {'id': 'agpeya', 'label': 'الصلوات'},
    {'id': 'liturgy', 'label': 'القداس'},
    {'id': 'hymns', 'label': 'الألحان'},
    {'id': 'synaxarium', 'label': 'التذكارات'},
    {'id': 'saints', 'label': 'القديسين'},
    {'id': 'prayers', 'label': 'المناسبات'},
    {'id': 'theology', 'label': 'العقيدة'},
    {'id': 'emotions', 'label': 'المشاعر'},
    {'id': 'dictionary', 'label': 'القاموس'},
    {'id': 'commentary', 'label': 'التفاسير'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) async {
    final trimmed = query.trim();
    final resolved = ScriptureReferenceResolver.resolve(trimmed);
    setState(() {
      _directRef = resolved;
    });

    if (trimmed.isEmpty) {
      setState(() => _results = []);
      return;
    }

    setState(() => _isLoading = true);
    final results = await DatabaseService.instance.searchDao.globalSearch(
      trimmed,
      filterType: _selectedFilter,
    );
    if (mounted) {
      setState(() {
        _results = results;
        _isLoading = false;
      });
    }
  }

  void _navigateToResult(UnifiedSearchResult item) {
    switch (item.type) {
      case 'bible':
        context.push('/bible/read/${item.id}');
        break;
      case 'agpeya':
        context.push('/agpeya/hour/${item.id}');
        break;
      case 'liturgy':
        context.push('/liturgy/read/${item.id}');
        break;
      case 'hymns':
        context.push('/hymns');
        break;
      case 'synaxarium':
        context.push('/synaxarium/story/${item.id}');
        break;
      case 'saints':
        context.push('/saints/detail/${item.id}');
        break;
      case 'prayers':
        context.push('/prayers/category/${item.id}');
        break;
      case 'theology':
        context.push('/theology/article/${item.id}');
        break;
      case 'emotions':
        context.push('/prayers/emotions?category=${item.id}');
        break;
      case 'dictionary':
        context.push('/dictionary');
        break;
      case 'commentary':
        context.push('/bible/commentary/${item.id}');
        break;
      default:
        break;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'bible':
        return Icons.menu_book_rounded;
      case 'agpeya':
        return Icons.access_time_rounded;
      case 'liturgy':
        return Icons.church_rounded;
      case 'hymns':
        return Icons.music_note_rounded;
      case 'synaxarium':
        return Icons.calendar_today_rounded;
      case 'saints':
        return Icons.person_rounded;
      case 'prayers':
        return Icons.favorite_rounded;
      case 'theology':
        return Icons.psychology_rounded;
      case 'emotions':
        return Icons.healing_rounded;
      case 'dictionary':
        return Icons.translate_rounded;
      case 'commentary':
        return Icons.lightbulb_rounded;
      default:
        return Icons.search_rounded;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'bible':
        return const Color(0xFF1565C0);
      case 'agpeya':
        return const Color(0xFF6A1B9A);
      case 'liturgy':
        return const Color(0xFFB71C1C);
      case 'hymns':
        return const Color(0xFFE65100);
      case 'synaxarium':
        return const Color(0xFF00695C);
      case 'saints':
        return const Color(0xFFC62828);
      case 'prayers':
        return const Color(0xFF2E7D32);
      case 'theology':
        return const Color(0xFF4527A0);
      case 'emotions':
        return const Color(0xFFE91E63);
      case 'dictionary':
        return const Color(0xFF795548);
      case 'commentary':
        return const Color(0xFFD4AF37);
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('البحث الشامل'),
          actions: const [
            AppQuickMenu(),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearch,
                decoration: InputDecoration(
                  hintText: 'ابحث أو اكتب الشاهد (مثل: يو 3:16، مز 51)...',
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _searchController.clear();
                            _onSearch('');
                          },
                        )
                      : null,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // بطاقة الانتقال السريع للشاهد الكتابي المباشر إذا تم التعرف عليه
            if (_directRef != null)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.bolt_rounded, color: AppColors.gold, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'انتقال مباشر للشاهد الكتابي',
                            style: AppTypography.caption,
                          ),
                          Text(
                            _directRef!.displayText,
                            style: AppTypography.bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        context.push(_directRef!.routePath);
                      },
                      child: const Text('فتح الإصحاح'),
                    ),
                  ],
                ),
              ),

            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter['id'];
                  return ChoiceChip(
                    label: Text(filter['label'] as String),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() => _selectedFilter = filter['id']);
                      _onSearch(_searchController.text);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _isLoading
                  ? const LoadingView(message: 'جاري البحث في قاعدة البيانات الكنسية...')
                  : _results.isEmpty && _directRef == null
                      ? EmptyView(
                          message: _searchController.text.isEmpty
                              ? 'البحث الشامل في نور'
                              : 'لا توجد نتائج مطابقة للبحث',
                          subtitle: _searchController.text.isEmpty
                              ? 'ابحث في الكتاب المقدس، الصلوات، القداس، التذكارات، الألحان، والقديسين\nأو اكتب الشاهد مباشرة مثل: يو 3:16 أو مز 51'
                              : 'جرب البحث بكلمة أو مرادف آخر أو بدون تشكيل',
                          icon: _searchController.text.isEmpty
                              ? Icons.search_rounded
                              : Icons.search_off_rounded,
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: _results.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final item = _results[index];
                            final color = _getTypeColor(item.type);
                            final icon = _getTypeIcon(item.type);

                            return Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(14),
                                onTap: () => _navigateToResult(item),
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: color.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Icon(icon, color: color, size: 20),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    item.title,
                                                    style: AppTypography.bodySmall.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: color.withValues(alpha: 0.1),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Text(
                                                    item.typeAr,
                                                    style: AppTypography.caption.copyWith(
                                                      color: color,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 6),
                                            HighlightedText(
                                              text: item.snippet,
                                              query: _searchController.text.trim(),
                                              style: AppTypography.caption.copyWith(
                                                color: Theme.of(context).brightness == Brightness.dark
                                                    ? AppColors.textSecondaryDark
                                                    : AppColors.textSecondaryLight,
                                              ),
                                              highlightStyle: AppTypography.caption.copyWith(
                                                color: AppColors.gold,
                                                fontWeight: FontWeight.bold,
                                                backgroundColor: AppColors.gold.withValues(alpha: 0.15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.chevron_left_rounded,
                                        size: 20,
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
        ),
      );
  }
}
