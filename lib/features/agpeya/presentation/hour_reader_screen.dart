import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/common/empty_view.dart';
import '../../../../widgets/common/error_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/common/auto_scroll_control.dart';
import '../../../../widgets/reader/role_colored_text.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';
import '../providers/agpeya_providers.dart';

class HourReaderScreen extends ConsumerStatefulWidget {
  final String hourId;

  const HourReaderScreen({super.key, required this.hourId});

  @override
  ConsumerState<HourReaderScreen> createState() => _HourReaderScreenState();
}

class _HourReaderScreenState extends ConsumerState<HourReaderScreen> {
  late double _fontSize;
  double _baseFontSize = 18.0;
  bool _showZoomIndicator = false;
  Timer? _zoomIndicatorTimer;
  String _selectedRole = 'all'; // all, priest, deacon, people
  String _selectedMidnightService = 'all'; // all, service_1, service_2, service_3
  final ScrollController _scrollController = ScrollController();
  bool _showAutoScroll = false;
  bool _isBookmarked = false;
  bool _isCandleMode = false;

  void _onScaleStart(ScaleStartDetails details) {
    _baseFontSize = _fontSize;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (details.pointerCount >= 2) {
      final newSize = (_baseFontSize * details.scale).clamp(14.0, 36.0);
      if ((newSize - _fontSize).abs() >= 0.5) {
        setState(() {
          _fontSize = newSize;
          _showZoomIndicator = true;
        });
        _zoomIndicatorTimer?.cancel();
        _zoomIndicatorTimer = Timer(const Duration(milliseconds: 1000), () {
          if (mounted) setState(() => _showZoomIndicator = false);
        });
        PreferencesService.setFontSize(_fontSize);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fontSize = PreferencesService.getFontSize();
    PreferencesService.setLastAgpeyaHour(widget.hourId);
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    final status = await DatabaseService.userData
        .isBookmarked('agpeya', widget.hourId);
    if (mounted) {
      setState(() => _isBookmarked = status);
    }
  }

  Future<void> _toggleBookmark(String title) async {
    HapticFeedback.selectionClick();
    final dao = DatabaseService.userData;
    if (_isBookmarked) {
      final all = await dao.getBookmarksByType('agpeya');
      final target = all.where((b) => b.contentId == widget.hourId).firstOrNull;
      if (target != null) {
        await dao.removeBookmark(target.id);
      }
      if (mounted) {
        setState(() => _isBookmarked = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تمت إزالة الصلاة من المفضلة')),
        );
      }
    } else {
      await dao.addBookmark(
        contentType: 'agpeya',
        contentId: widget.hourId,
        displayTitle: title,
      );
      if (mounted) {
        setState(() => _isBookmarked = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم حفظ الصلاة في المفضلة بنجاح')),
        );
      }
    }
  }

  @override
  void dispose() {
    _zoomIndicatorTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  String _getHourTitle(String id) {
    switch (id) {
      case 'prime':
        return 'صلاة باكر';
      case 'terce':
        return 'صلاة الساعة الثالثة';
      case 'sext':
        return 'صلاة الساعة السادسة';
      case 'none':
        return 'صلاة الساعة التاسعة';
      case 'vespers':
        return 'صلاة الغروب';
      case 'compline':
        return 'صلاة النوم';
      case 'curtain':
        return 'صلاة الستار';
      case 'midnight':
        return 'صلاة نصف الليل';
      default:
        return 'صلاة الأجبية';
    }
  }

  LiturgicalRole _mapRole(String role) {
    switch (role) {
      case 'priest':
        return LiturgicalRole.priest;
      case 'deacon':
        return LiturgicalRole.deacon;
      case 'people':
        return LiturgicalRole.people;
      case 'reader':
      case 'all':
      default:
        return LiturgicalRole.normal;
    }
  }

  void _copySection(AgpeyaSection section) {
    final buffer = StringBuffer();
    if (section.title.isNotEmpty) {
      buffer.writeln(section.title);
    }
    buffer.writeln(section.textAr);
    if (section.textPhonetic != null && section.textPhonetic!.isNotEmpty) {
      buffer.writeln(section.textPhonetic);
    }
    if (section.textCoptic != null && section.textCoptic!.isNotEmpty) {
      buffer.writeln(section.textCoptic);
    }
    Clipboard.setData(ClipboardData(text: buffer.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ النص إلى الحافظة'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = _getHourTitle(widget.hourId);
    final sectionsAsync = ref.watch(hourSectionsProvider(widget.hourId));

    return Scaffold(
      backgroundColor: _isCandleMode ? const Color(0xFF18130E) : null,
      appBar: AppBar(
        backgroundColor: _isCandleMode ? const Color(0xFF130E0A) : null,
        foregroundColor: _isCandleMode ? const Color(0xFFF5ECE0) : null,
        title: Text(title),
        actions: [
          IconButton(
            icon: Icon(
              _isCandleMode ? Icons.wb_incandescent_rounded : Icons.wb_incandescent_outlined,
              color: _isCandleMode ? const Color(0xFFFFB300) : null,
            ),
            tooltip: _isCandleMode ? 'إيقاف وضع الشموع' : 'تشغيل وضع الشموع الهادئ (أجواء الصلاة)',
            onPressed: () {
              HapticFeedback.selectionClick();
              setState(() => _isCandleMode = !_isCandleMode);
            },
          ),
          IconButton(
            icon: Icon(
              _showAutoScroll ? Icons.swap_vert_circle_rounded : Icons.swap_vert_circle_outlined,
              color: _showAutoScroll ? AppColors.primary : null,
            ),
            tooltip: 'تمرير تلقائي',
            onPressed: () {
              setState(() {
                _showAutoScroll = !_showAutoScroll;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.text_increase_rounded),
            tooltip: 'تكبير الخط',
            onPressed: () {
              setState(() {
                _fontSize = (_fontSize + 2).clamp(14.0, 36.0);
              });
              PreferencesService.setFontSize(_fontSize);
            },
          ),
          IconButton(
            icon: const Icon(Icons.text_decrease_rounded),
            tooltip: 'تصغير الخط',
            onPressed: () {
              setState(() {
                _fontSize = (_fontSize - 2).clamp(14.0, 36.0);
              });
              PreferencesService.setFontSize(_fontSize);
            },
          ),
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
              color: _isBookmarked ? AppColors.gold : null,
            ),
            tooltip: _isBookmarked ? 'إزالة الصلاة من المفضلة' : 'حفظ الصلاة في المفضلة',
            onPressed: () => _toggleBookmark(title),
          ),
          const AppQuickMenu(),
        ],
      ),
      bottomSheet: _showAutoScroll
          ? AutoScrollControl(
              scrollController: _scrollController,
              onClose: () => setState(() => _showAutoScroll = false),
            )
          : null,
      body: Stack(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                // Midnight services selector
                _buildMidnightServiceSelector(),

            // Role filtering chips
            _buildRoleFilterChips(),

            // Reader body
            Expanded(
              child: sectionsAsync.when(
                data: (allSections) {
                  var sections = _selectedRole == 'all'
                      ? allSections
                      : allSections.where((s) => s.role == _selectedRole || s.role == 'all').toList();

                  if (widget.hourId == 'midnight') {
                    if (_selectedMidnightService == 'service_1') {
                      sections = sections.where((s) => s.sectionOrder >= 1 && s.sectionOrder <= 26).toList();
                    } else if (_selectedMidnightService == 'service_2') {
                      sections = sections.where((s) => s.sectionOrder >= 27 && s.sectionOrder <= 52).toList();
                    } else if (_selectedMidnightService == 'service_3') {
                      sections = sections.where((s) => s.sectionOrder >= 53 && s.sectionOrder <= 87).toList();
                    }
                  }

                  if (sections.isEmpty) {
                    return EmptyView(
                      message: title,
                      subtitle: 'لا توجد صلوات تطابق الفلتر المحدد.',
                      icon: Icons.menu_book_rounded,
                    );
                  }

                  return GestureDetector(
                    onScaleStart: _onScaleStart,
                    onScaleUpdate: _onScaleUpdate,
                    child: RefreshIndicator(
                      onRefresh: () => ref.refresh(hourSectionsProvider(widget.hourId).future),
                      child: ListView.separated(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        itemCount: sections.length,
                        separatorBuilder: (_, __) => Divider(
                          height: 28,
                          color: _isCandleMode ? const Color(0xFF2C2219) : null,
                        ),
                        itemBuilder: (context, index) {
                        final section = sections[index];
                        final role = _mapRole(section.role);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (section.title.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        section.title,
                                        style: AppTypography.heading3.copyWith(
                                          color: _isCandleMode ? const Color(0xFFD4AF37) : AppColors.primary,
                                          fontSize: _fontSize * 0.9,
                                        ),
                                      ),
                                    ),
                                    if (section.reference != null && section.reference!.isNotEmpty)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          section.reference!,
                                          style: AppTypography.caption.copyWith(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    IconButton(
                                      icon: const Icon(Icons.copy_rounded, size: 18),
                                      tooltip: 'نسخ النص',
                                      color: AppColors.textSecondaryLight,
                                      onPressed: () => _copySection(section),
                                    ),
                                  ],
                                ),
                              ),
                            RoleColoredText(
                              text: section.textAr,
                              role: role,
                              fontSize: _fontSize,
                            ),
                            if (section.textPhonetic != null && section.textPhonetic!.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(
                                section.textPhonetic!,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamily,
                                  fontSize: _fontSize * 0.9,
                                  color: AppColors.accent,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                            if (section.textCoptic != null && section.textCoptic!.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                  section.textCoptic!,
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
                        );
                      },
                    ),
                  ),
                );
              },
                loading: () => const LoadingView(message: 'جاري تحميل صلوات الساعة...'),
                error: (error, stack) => ErrorView(
                  message: 'حدث خطأ أثناء تحميل صلوات الساعة',
                  onRetry: () => ref.refresh(hourSectionsProvider(widget.hourId)),
                ),
              ),
            ),
          ],
        ),
      ),
      if (_showZoomIndicator)
        Positioned(
          top: 24,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.gold, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.35),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.format_size_rounded, color: AppColors.gold, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'حجم الخط: ${_fontSize.toInt()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ],
  ),
);
  }

  Widget _buildRoleFilterChips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: _isCandleMode ? const Color(0xFF1E1712) : Theme.of(context).cardColor,
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

  Widget _buildMidnightServiceSelector() {
    if (widget.hourId != 'midnight') return const SizedBox.shrink();

    final services = [
      {'id': 'all', 'label': 'صلوات نصف الليل كاملة'},
      {'id': 'service_1', 'label': 'الخدمة الأولى (العذارى الحكيمات)'},
      {'id': 'service_2', 'label': 'الخدمة الثانية (المرأة الخاطئة)'},
      {'id': 'service_3', 'label': 'الخدمة الثالثة (كونوا مستعدين)'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.06),
        border: Border(bottom: BorderSide(color: AppColors.primary.withValues(alpha: 0.2))),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: services.map((svc) {
            final isSelected = _selectedMidnightService == svc['id'];
            return Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: ChoiceChip(
                label: Text(svc['label']!),
                selected: isSelected,
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : AppColors.primary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedMidnightService = svc['id']!;
                    });
                    if (_scrollController.hasClients) {
                      _scrollController.jumpTo(0);
                    }
                  }
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
