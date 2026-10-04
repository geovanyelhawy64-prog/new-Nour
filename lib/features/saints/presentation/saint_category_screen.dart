import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/coptic_calendar/coptic_date.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/utils/search_normalizer.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class SaintCategoryScreen extends StatefulWidget {
  final String categoryId;

  const SaintCategoryScreen({super.key, required this.categoryId});

  @override
  State<SaintCategoryScreen> createState() => _SaintCategoryScreenState();
}

class _SaintCategoryScreenState extends State<SaintCategoryScreen> {
  late Future<List<Saint>> _saintsFuture;
  final TextEditingController _searchController = TextEditingController();
  List<Saint> _allCategorySaints = [];
  List<Saint> _filteredSaints = [];
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadSaints();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadSaints() {
    final dao = DatabaseService.instance.saintsDao;
    if (widget.categoryId == 'all') {
      _saintsFuture = dao.getAllSaints();
    } else {
      _saintsFuture = dao.getSaintsByType(widget.categoryId);
    }

    _saintsFuture.then((list) {
      if (mounted) {
        setState(() {
          _allCategorySaints = list;
          _filteredSaints = list;
          _isLoaded = true;
        });
      }
    });
  }

  void _onSearchChanged(String query) {
    if (query.trim().isEmpty) {
      setState(() => _filteredSaints = _allCategorySaints);
      return;
    }

    setState(() {
      _filteredSaints = _allCategorySaints.where((s) {
        return SearchNormalizer.matches(s.nameAr, query) ||
            SearchNormalizer.matches(s.shortBio, query) ||
            SearchNormalizer.matches(s.biography, query);
      }).toList();
    });
  }

  String _getCategoryTitle(String id) {
    switch (id) {
      case 'martyrs':
        return 'الشهداء الأبرار';
      case 'monks':
        return 'آباء الرهبنة والنساك';
      case 'patriarchs':
        return 'البطاركة والأساقفة حماة الإيمان';
      case 'archangel':
        return 'رؤساء الملائكة والأجناد السمائية';
      case 'virgin':
        return 'العذارى والشهيدات القديسات';
      case 'modern':
        return 'قديسو العصر الحديث';
      case 'women':
        return 'القديسات والأمهات البارات';
      case 'saints':
        return 'القديسون والمعترفون';
      case 'all':
        return 'جميع سير القديسين والشهداء';
      default:
        return 'سير القديسين';
    }
  }

  String _formatFeastDate(int? month, int? day) {
    if (month == null || day == null) return '';
    if (month < 1 || month > 13) return '';
    return '$day ${CopticDate.monthNames[month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    final title = _getCategoryTitle(widget.categoryId);

    return  Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: const [
            AppQuickMenu(),
          ],
        ),
        body: Column(
          children: [
            // شريط البحث داخل الفئة
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'ابحث عن اسم قديس...',
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

            // عدد النتائج
            if (_isLoaded)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Row(
                  children: [
                    Text(
                      'العدد: ${_filteredSaints.length} قديس',
                      style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
                    ),
                  ],
                ),
              ),

            // قائمة القديسين
            Expanded(
              child: !_isLoaded
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredSaints.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.search_off_rounded, size: 48, color: AppColors.textSecondaryLight),
                              const SizedBox(height: 12),
                              Text('لا توجد نتائج مطابقة للبحث', style: AppTypography.heading3),
                            ],
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredSaints.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final saint = _filteredSaints[index];
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
        ),
      );
  }
}
