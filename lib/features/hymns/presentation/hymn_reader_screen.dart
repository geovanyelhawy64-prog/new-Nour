import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/database_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../data/models/osama_lotfy_structure.dart';
import '../../../../widgets/common/empty_view.dart';
import '../../../../widgets/common/error_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';
import 'widgets/coptic_rhythm_helper.dart';
import 'widgets/hymn_viewer.dart';

class HymnReaderScreen extends StatefulWidget {
  final String categoryId;
  final String? initialHymnId;

  const HymnReaderScreen({
    super.key,
    required this.categoryId,
    this.initialHymnId,
  });

  @override
  State<HymnReaderScreen> createState() => _HymnReaderScreenState();
}

class _HymnReaderScreenState extends State<HymnReaderScreen> {
  late Future<List<Hymn>> _hymnsFuture;
  Hymn? _selectedHymn;
  Future<List<HymnSegment>>? _segmentsFuture;

  @override
  void initState() {
    super.initState();
    _loadHymns();
  }

  void _loadHymns() {
    _hymnsFuture = _fetchHymnsForCategory(widget.categoryId);
  }

  Future<List<Hymn>> _fetchHymnsForCategory(String catId) async {
    final dao = DatabaseService.instance.hymnsDao;
    List<Hymn> hymns = [];

    final chapter = OsamaLotfyCatalog.getChapterById(catId);
    if (chapter != null) {
      if (chapter.isAvailable) {
        hymns = await dao.getHymnsByIds(chapter.hymnIds);
      }
    } else if (catId == 'osama_lotfy_part_1' || catId == 'part_1') {
      final partChapters = OsamaLotfyCatalog.getChaptersForPart(OsamaLotfyPart.annual);
      final allIds = partChapters.expand((c) => c.hymnIds).toList();
      hymns = await dao.getHymnsByIds(allIds);
    } else if (catId == 'osama_lotfy_part_2' || catId == 'part_2') {
      final partChapters = OsamaLotfyCatalog.getChaptersForPart(OsamaLotfyPart.festive);
      final allIds = partChapters.expand((c) => c.hymnIds).toList();
      hymns = await dao.getHymnsByIds(allIds);
    } else if (catId == 'osama_lotfy_part_3' || catId == 'part_3') {
      final partChapters = OsamaLotfyCatalog.getChaptersForPart(OsamaLotfyPart.sorrowful);
      final allIds = partChapters.expand((c) => c.hymnIds).toList();
      hymns = await dao.getHymnsByIds(allIds);
    } else if (catId == 'osama_lotfy_part_4' || catId == 'part_4') {
      final partChapters = OsamaLotfyCatalog.getChaptersForPart(OsamaLotfyPart.kiahk);
      final allIds = partChapters.expand((c) => c.hymnIds).toList();
      hymns = await dao.getHymnsByIds(allIds);
    } else {
      hymns = await dao.getHymnsForCategory(catId);
      if (hymns.isEmpty) {
        hymns = await dao.getHymnsForBook(catId);
      }
    }

    if (hymns.isEmpty) {
      final ch = OsamaLotfyCatalog.chapters.first;
      hymns = await dao.getHymnsByIds(ch.hymnIds);
    }
    if (hymns.isNotEmpty) {
      if (widget.initialHymnId != null) {
        _selectedHymn = hymns.firstWhere(
          (h) => h.id == widget.initialHymnId,
          orElse: () => hymns.first,
        );
      } else {
        _selectedHymn = hymns.first;
      }
      _loadSegmentsForSelected();
    }
    return hymns;
  }

  void _loadSegmentsForSelected() {
    if (_selectedHymn != null) {
      _segmentsFuture = DatabaseService.instance.hymnsDao.getSegmentsForHymn(_selectedHymn!.id);
    }
  }

  void _onSelectHymn(Hymn hymn) {
    setState(() {
      _selectedHymn = hymn;
      _loadSegmentsForSelected();
    });
  }

  String _getCategoryTitle(String catId) {
    final chapter = OsamaLotfyCatalog.getChapterById(catId);
    if (chapter != null) {
      return '${chapter.partNameAr} • ${chapter.title}';
    }
    switch (catId) {
      case 'osama_lotfy_part_1':
      case 'part_1':
        return 'الجزء الأول: الألحان السنوية (آدام وواطس وباكر والقداس)';
      case 'osama_lotfy_part_2':
      case 'part_2':
        return 'الجزء الثاني: الألحان الفرايحي (أعياد المسيح والعذراء والرسل)';
      case 'osama_lotfy_part_3':
      case 'part_3':
        return 'الجزء الثالث: الألحان الحزايني (الصوم الكبير والبصخة والتجنيز)';
      case 'osama_lotfy_part_4':
      case 'part_4':
        return 'الجزء الرابع: تسبحة وألحان شهر كيهك المبارك';
      case 'osama_lotfy_01':
        return 'المجلد ١: رفع بخور عشية وباكر والتسبحة';
      case 'osama_lotfy_02':
        return 'المجلد ٢: القداس الباسيلي السنوي';
      case 'osama_lotfy_03':
        return 'المجلد ٣: شهر كيهك والتسبحة الكيهكية';
      case 'osama_lotfy_04':
        return 'المجلد ٤: عيدي الميلاد والغطاس';
      case 'osama_lotfy_05':
        return 'المجلد ٥: صوم يونان والصوم الكبير';
      case 'osama_lotfy_06':
        return 'المجلد ٦: ختام الصوم وسبت لعازر والشعانين';
      case 'osama_lotfy_07':
        return 'المجلد ٧: أسبوع الآلام والبصخة المقدسة';
      case 'osama_lotfy_08':
        return 'المجلد ٨: خميس العهد والجمعة العظيمة وسبت النور';
      case 'osama_lotfy_09':
        return 'المجلد ٩: عيد القيامة والخماسين المقدسة';
      case 'osama_lotfy_10':
        return 'المجلد ١٠: الصعود والعنصرة وصوم الرسل';
      case 'osama_lotfy_11':
        return 'المجلد ١١: صوم وعيد العذراء والشهداء';
      case 'annual':
        return 'الألحان السنوية';
      case 'kiahk':
        return 'ألحان كيهك المبهجة';
      case 'lent':
        return 'ألحان الصوم الكبير';
      case 'pascha':
        return 'ألحان أسبوع الآلام';
      case 'resurrection':
        return 'ألحان القيامة المجيدة';
      case 'tasbeha':
        return 'تسبحة نصف الليل';
      default:
        return 'مجلد ألحان أسامة لطفي';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Hymn>>(
      future: _hymnsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text(_getCategoryTitle(widget.categoryId))),
            body: const LoadingView(message: 'جاري تحميل الألحان...'),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text(_getCategoryTitle(widget.categoryId))),
            body: ErrorView(
              message: 'حدث خطأ أثناء تحميل الألحان',
              onRetry: () => setState(() => _loadHymns()),
            ),
          );
        }

        final hymns = snapshot.data ?? [];
        if (hymns.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(_getCategoryTitle(widget.categoryId))),
            body: EmptyView(
              message: _getCategoryTitle(widget.categoryId),
              subtitle: 'لا توجد ألحان متاحة لهذا القسم حالياً',
              icon: Icons.music_note_rounded,
            ),
          );
        }

        final currentHymn = _selectedHymn ?? hymns.first;

        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentHymn.nameAr,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                if (currentHymn.nameCoptic != null)
                  Text(
                    currentHymn.nameCoptic!,
                    style: AppTypography.coptic.copyWith(fontSize: 13, color: AppColors.goldLight),
                  ),
              ],
            ),
            actions: [
              if (hymns.length > 1)
                PopupMenuButton<Hymn>(
                  icon: const Icon(Icons.playlist_play_rounded),
                  tooltip: 'اختر لحناً آخر',
                  onSelected: _onSelectHymn,
                  itemBuilder: (context) {
                    return hymns.map((h) {
                      final isSelected = h.id == currentHymn.id;
                      return PopupMenuItem<Hymn>(
                        value: h,
                        child: Row(
                          children: [
                            if (isSelected)
                              const Icon(Icons.check_rounded, size: 18, color: AppColors.primary)
                            else
                              const SizedBox(width: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                h.nameAr,
                                style: TextStyle(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList();
                  },
                ),
              IconButton(
                icon: const Icon(Icons.music_note_rounded),
                tooltip: 'محاكي الدف والمثلث',
                onPressed: () => CopticRhythmHelperDialog.show(context),
              ),
              const AppQuickMenu(),
            ],
            bottom: hymns.length > 1
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(48),
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: hymns.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, idx) {
                          final h = hymns[idx];
                          final isSelected = h.id == currentHymn.id;
                          return ChoiceChip(
                            label: Text(
                              h.nameAr,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (_) => _onSelectHymn(h),
                            selectedColor: AppColors.primary.withValues(alpha: 0.2),
                            labelStyle: TextStyle(
                              color: isSelected ? AppColors.primary : null,
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : null,
          ),
          body: FutureBuilder<List<HymnSegment>>(
            future: _segmentsFuture,
            builder: (context, segSnapshot) {
              if (segSnapshot.connectionState == ConnectionState.waiting) {
                return const LoadingView(message: 'جاري تحميل أرباع وهزات اللحن...');
              }
              if (segSnapshot.hasError) {
                return ErrorView(
                  message: 'حدث خطأ أثناء تحميل أرباع اللحن',
                  onRetry: () => setState(() => _loadSegmentsForSelected()),
                );
              }
              final segments = segSnapshot.data ?? [];
              if (segments.isEmpty) {
                return const EmptyView(
                  message: 'لا توجد أرباع متاحة لهذا اللحن حالياً',
                  icon: Icons.music_note_rounded,
                );
              }
              return HymnViewer(
                hymn: currentHymn,
                segments: segments,
              );
            },
          ),
        );
      },
    );
  }
}
