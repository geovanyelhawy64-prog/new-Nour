import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../data/database/daos/liturgy_dao.dart';
import '../../../../widgets/reader/role_colored_text.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

enum LiturgyViewMode {
  parallel,
  arabicOnly,
  phoneticOnly,
  copticOnly,
}

class LiturgyReaderScreen extends StatefulWidget {
  final String liturgyId;

  const LiturgyReaderScreen({super.key, required this.liturgyId});

  @override
  State<LiturgyReaderScreen> createState() => _LiturgyReaderScreenState();
}

class _LiturgyReaderScreenState extends State<LiturgyReaderScreen> {
  late double _fontSize;
  bool _showSecretPrayers = true;
  String _selectedRole = 'all'; // all, priest, deacon, people
  LiturgyViewMode _viewMode = LiturgyViewMode.parallel;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _fontSize = PreferencesService.getFontSize();
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    final status = await DatabaseService.instance.bookmarksDao
        .isBookmarked('liturgy', widget.liturgyId);
    if (mounted) {
      setState(() => _isBookmarked = status);
    }
  }

  Future<void> _toggleBookmark() async {
    HapticFeedback.selectionClick();
    final dao = DatabaseService.instance.bookmarksDao;
    if (_isBookmarked) {
      final all = await dao.getBookmarksByType('liturgy');
      final target = all.where((b) => b.contentId == widget.liturgyId).firstOrNull;
      if (target != null) {
        await dao.removeBookmark(target.id);
      }
      if (mounted) {
        setState(() => _isBookmarked = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تمت إزالة القداس من المفضلة')),
        );
      }
    } else {
      await dao.addBookmark(
        contentType: 'liturgy',
        contentId: widget.liturgyId,
        displayTitle: _title,
      );
      if (mounted) {
        setState(() => _isBookmarked = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم حفظ القداس في المفضلة بنجاح')),
        );
      }
    }
  }

  String get _title {
    switch (widget.liturgyId) {
      case 'raising_incense':
        return 'رفع بخور عشية وباكر';
      case 'basil':
        return 'القداس الباسيلي';
      case 'gregory':
        return 'القداس الغريغوري';
      case 'cyril':
        return 'القداس الكيرلسي';
      case 'distribution':
        return 'صلوات التوزيع والبركة';
      default:
        return 'القداس الإلهي';
    }
  }

  LiturgicalRole _mapRole(String roleStr) {
    switch (roleStr.toLowerCase()) {
      case 'priest':
        return LiturgicalRole.priest;
      case 'deacon':
        return LiturgicalRole.deacon;
      case 'people':
        return LiturgicalRole.people;
      case 'rubric':
        return LiturgicalRole.rubric;
      default:
        return LiturgicalRole.normal;
    }
  }

  void _copyPart(LiturgyPartWithSection item) {
    final buffer = StringBuffer();
    if (item.part.rubric != null && item.part.rubric!.isNotEmpty) {
      buffer.writeln('[${item.part.rubric}]');
    }
    buffer.writeln(item.part.textAr);
    if (item.part.textPhonetic != null && item.part.textPhonetic!.isNotEmpty) {
      buffer.writeln(item.part.textPhonetic);
    }
    if (item.part.textCoptic != null && item.part.textCoptic!.isNotEmpty) {
      buffer.writeln(item.part.textCoptic);
    }
    Clipboard.setData(ClipboardData(text: buffer.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ النص الطقسي إلى الحافظة'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          IconButton(
            icon: Icon(_showSecretPrayers ? Icons.visibility_rounded : Icons.visibility_off_rounded),
            tooltip: _showSecretPrayers ? 'إخفاء الصلوات السرية' : 'إظهار الصلوات السرية',
            onPressed: () {
              setState(() {
                _showSecretPrayers = !_showSecretPrayers;
              });
            },
          ),
          PopupMenuButton<LiturgyViewMode>(
            icon: const Icon(Icons.translate_rounded),
            tooltip: 'لغة العرض',
            initialValue: _viewMode,
            onSelected: (mode) {
              setState(() {
                _viewMode = mode;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: LiturgyViewMode.parallel,
                child: Text('عرض متوازي (عربي وقبطي)'),
              ),
              const PopupMenuItem(
                value: LiturgyViewMode.arabicOnly,
                child: Text('عربي فقط'),
              ),
              const PopupMenuItem(
                value: LiturgyViewMode.phoneticOnly,
                child: Text('قبطي معرب'),
              ),
              const PopupMenuItem(
                value: LiturgyViewMode.copticOnly,
                child: Text('قبطي أصلي'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.text_increase_rounded),
            tooltip: 'تكبير الخط',
            onPressed: () {
              setState(() => _fontSize = (_fontSize + 2).clamp(14.0, 36.0));
              PreferencesService.setFontSize(_fontSize);
            },
          ),
          IconButton(
            icon: const Icon(Icons.text_decrease_rounded),
            tooltip: 'تصغير الخط',
            onPressed: () {
              setState(() => _fontSize = (_fontSize - 2).clamp(14.0, 36.0));
              PreferencesService.setFontSize(_fontSize);
            },
          ),
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
              color: _isBookmarked ? AppColors.gold : null,
            ),
            tooltip: _isBookmarked ? 'إزالة القداس من المفضلة' : 'حفظ القداس في المفضلة',
            onPressed: _toggleBookmark,
          ),
          const AppQuickMenu(),
        ],
      ),
      body:  Column(
          children: [
            // Clerical Role Selector
            _buildRoleFilterChips(),

            // Liturgy Content
            Expanded(
              child: FutureBuilder<List<LiturgyPartWithSection>>(
                future: DatabaseService.instance.liturgyDao.getFullLiturgyParts(
                  widget.liturgyId == 'distribution' ? 'basil' : widget.liturgyId,
                  includeSecret: _showSecretPrayers,
                  roleFilter: _selectedRole,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final parts = snapshot.data ?? [];
                  if (parts.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.church_rounded, size: 64, color: AppColors.primary.withValues(alpha: 0.5)),
                            const SizedBox(height: 16),
                            Text(_title, style: AppTypography.heading2),
                            const SizedBox(height: 8),
                            Text(
                              'لا توجد صلوات تطابق الفلتر المحدد.',
                              style: AppTypography.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  String? lastSectionId;

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    itemCount: parts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = parts[index];
                      final isNewSection = item.section.id != lastSectionId;
                      lastSectionId = item.section.id;
                      final role = _mapRole(item.part.role);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (isNewSection) ...[
                            if (index > 0) const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.bookmark_border_rounded, size: 18, color: AppColors.primary),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      item.section.nameAr,
                                      style: AppTypography.heading3.copyWith(
                                        color: AppColors.primary,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                          Card(
                            elevation: 0.5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: item.part.isSecret
                                    ? AppColors.roleRubric.withValues(alpha: 0.3)
                                    : Theme.of(context).dividerColor.withValues(alpha: 0.3),
                              ),
                            ),
                            color: item.part.isSecret
                                ? AppColors.roleRubric.withValues(alpha: 0.04)
                                : Theme.of(context).cardColor,
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Rubric header / Secret badge
                                  Row(
                                    children: [
                                      if (item.part.rubric != null && item.part.rubric!.isNotEmpty)
                                        Expanded(
                                          child: Text(
                                            item.part.rubric!,
                                            style: TextStyle(
                                              fontFamily: AppTypography.fontFamily,
                                              fontSize: _fontSize * 0.75,
                                              color: AppColors.roleRubric,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      if (item.part.isSecret)
                                        Container(
                                          margin: const EdgeInsets.only(right: 6),
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.roleRubric.withValues(alpha: 0.15),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            'صلاة سرية',
                                            style: AppTypography.caption.copyWith(
                                              color: AppColors.roleRubric,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      IconButton(
                                        icon: const Icon(Icons.copy_rounded, size: 16),
                                        tooltip: 'نسخ',
                                        color: AppColors.textSecondaryLight,
                                        onPressed: () => _copyPart(item),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),

                                  // Arabic text
                                  if (_viewMode == LiturgyViewMode.parallel || _viewMode == LiturgyViewMode.arabicOnly)
                                    RoleColoredText(
                                      text: item.part.textAr,
                                      role: role,
                                      fontSize: _fontSize,
                                    ),

                                  // Arabized phonetic Coptic
                                  if ((_viewMode == LiturgyViewMode.parallel || _viewMode == LiturgyViewMode.phoneticOnly) &&
                                      item.part.textPhonetic != null &&
                                      item.part.textPhonetic!.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      item.part.textPhonetic!,
                                      style: TextStyle(
                                        fontFamily: AppTypography.fontFamily,
                                        fontSize: _fontSize * 0.9,
                                        color: AppColors.accent,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],

                                  // Coptic text
                                  if ((_viewMode == LiturgyViewMode.parallel || _viewMode == LiturgyViewMode.copticOnly) &&
                                      item.part.textCoptic != null &&
                                      item.part.textCoptic!.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Text(
                                        item.part.textCoptic!,
                                        style: TextStyle(
                                          fontFamily: AppTypography.fontFamilyCoptic,
                                          fontSize: _fontSize * 1.05,
                                          color: Theme.of(context).brightness == Brightness.dark
                                              ? AppColors.textPrimaryDark
                                              : AppColors.textPrimaryLight,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildRoleFilterChips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).cardColor,
      child: Row(
        children: [
          const Text('الدور: ', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _roleChip('all', 'الكل', null),
                  const SizedBox(width: 6),
                  _roleChip('priest', 'الكاهن', AppColors.rolePriest),
                  const SizedBox(width: 6),
                  _roleChip('deacon', 'الشماس', AppColors.roleDeacon),
                  const SizedBox(width: 6),
                  _roleChip('people', 'الشعب', AppColors.rolePeople),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roleChip(String value, String label, Color? color) {
    final isSelected = _selectedRole == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: color?.withValues(alpha: 0.2) ?? AppColors.primary.withValues(alpha: 0.2),
      labelStyle: TextStyle(
        color: isSelected ? (color ?? AppColors.primary) : null,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 13,
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedRole = value;
          });
        }
      },
    );
  }
}
