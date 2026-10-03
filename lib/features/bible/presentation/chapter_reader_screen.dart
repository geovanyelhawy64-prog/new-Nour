import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/database_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../data/database/content_key.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../core/utils/string_extensions.dart';
import '../../../../widgets/common/empty_view.dart';
import '../../../../widgets/common/error_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';
import '../providers/bible_providers.dart';
import 'widgets/verse_actions_modal.dart';
import 'widgets/verse_with_commentary.dart';
import 'widgets/cross_references_widget.dart';

class ChapterReaderScreen extends ConsumerStatefulWidget {
  final int bookId;
  final int chapter;

  const ChapterReaderScreen({
    super.key,
    required this.bookId,
    required this.chapter,
  });

  @override
  ConsumerState<ChapterReaderScreen> createState() => _ChapterReaderScreenState();
}

class _ChapterReaderScreenState extends ConsumerState<ChapterReaderScreen> {
  double _fontSize = PreferencesService.getFontSize();
  double _baseFontSize = 18.0;
  bool _showZoomIndicator = false;
  Timer? _zoomIndicatorTimer;
  final ScrollController _scrollController = ScrollController();
  bool _isFocusMode = false;
  bool _isAutoScrolling = false;
  Timer? _autoScrollTimer;
  double _scrollSpeed = 1.0; // 1x or 2x
  bool _isChapterBookmarked = false;
  bool _isCandleMode = false;

  String get _chapterContentId => ContentKey.bibleChapter(
        bookId: widget.bookId,
        chapter: widget.chapter,
      );

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

  void _onHorizontalDragEnd(DragEndDetails details, int totalChapters) {
    final velocity = details.primaryVelocity ?? 0;
    // In RTL: Swipe left (velocity < -300) moves to next chapter
    // Swipe right (velocity > 300) moves to previous chapter
    if (velocity < -300) {
      if (widget.chapter < totalChapters) {
        HapticFeedback.lightImpact();
        context.pushReplacement('/bible/read/${widget.bookId}/${widget.chapter + 1}');
      }
    } else if (velocity > 300) {
      if (widget.chapter > 1) {
        HapticFeedback.lightImpact();
        context.pushReplacement('/bible/read/${widget.bookId}/${widget.chapter - 1}');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    PreferencesService.setLastBibleRead(widget.bookId, widget.chapter);
    _checkChapterBookmark();
  }

  Future<void> _checkChapterBookmark() async {
    final status = await DatabaseService.userData
        .isBookmarked('bible', _chapterContentId);
    if (mounted) {
      setState(() => _isChapterBookmarked = status);
    }
  }

  Future<void> _toggleChapterBookmark(String bookName) async {
    HapticFeedback.selectionClick();
    final dao = DatabaseService.userData;
    if (_isChapterBookmarked) {
      final all = await dao.getBookmarksByType('bible');
      final target = all.where((b) => b.contentId == _chapterContentId).firstOrNull;
      if (target != null) {
        await dao.removeBookmark(target.id);
      }
      if (mounted) {
        setState(() => _isChapterBookmarked = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تمت إزالة الإصحاح من المفضلة')),
        );
      }
    } else {
      await dao.addBookmark(
        contentType: 'bible',
        contentId: _chapterContentId,
        displayTitle: '$bookName - الإصحاح ${widget.chapter.arabicDigits}',
      );
      if (mounted) {
        setState(() => _isChapterBookmarked = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم حفظ الإصحاح في المفضلة بنجاح')),
        );
      }
    }
  }

  @override
  void dispose() {
    _zoomIndicatorTimer?.cancel();
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleAutoScroll() {
    if (_isAutoScrolling) {
      _autoScrollTimer?.cancel();
      setState(() => _isAutoScrolling = false);
    } else {
      setState(() => _isAutoScrolling = true);
      _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
        if (!_scrollController.hasClients) return;
        final maxScroll = _scrollController.position.maxScrollExtent;
        final current = _scrollController.offset;
        final delta = 1.5 * _scrollSpeed;
        if (current + delta >= maxScroll) {
          _scrollController.jumpTo(maxScroll);
          _toggleAutoScroll();
        } else {
          _scrollController.jumpTo(current + delta);
        }
      });
    }
  }

  Color? _getHighlightBackgroundColor(String? colorKey, bool isDark) {
    if (colorKey == null) return null;
    switch (colorKey) {
      case 'yellow':
        return isDark
            ? const Color(0xFFFBC02D).withValues(alpha: 0.28)
            : const Color(0xFFFFF59D).withValues(alpha: 0.65);
      case 'green':
        return isDark
            ? const Color(0xFF43A047).withValues(alpha: 0.28)
            : const Color(0xFFA5D6A7).withValues(alpha: 0.65);
      case 'blue':
        return isDark
            ? const Color(0xFF1E88E5).withValues(alpha: 0.28)
            : const Color(0xFF90CAF9).withValues(alpha: 0.65);
      case 'red':
        return isDark
            ? const Color(0xFFE53935).withValues(alpha: 0.28)
            : const Color(0xFFEF9A9A).withValues(alpha: 0.65);
      default:
        return null;
    }
  }

  Color? _getHighlightBorderColor(String? colorKey) {
    if (colorKey == null) return null;
    switch (colorKey) {
      case 'yellow':
        return const Color(0xFFFBC02D).withValues(alpha: 0.6);
      case 'green':
        return const Color(0xFF43A047).withValues(alpha: 0.6);
      case 'blue':
        return const Color(0xFF1E88E5).withValues(alpha: 0.6);
      case 'red':
        return const Color(0xFFE53935).withValues(alpha: 0.6);
      default:
        return null;
    }
  }

  void _showQuickHighlightPicker(BibleBook book, BibleVerse verse, String? currentColor) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'تمييز الآية ${verse.verseNumber.arabicDigits} بلون',
                  style: AppTypography.heading3.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildQuickColorBtn(ctx, verse, 'yellow', const Color(0xFFFBC02D), 'أصفر', currentColor),
                    _buildQuickColorBtn(ctx, verse, 'green', const Color(0xFF43A047), 'أخضر', currentColor),
                    _buildQuickColorBtn(ctx, verse, 'blue', const Color(0xFF1E88E5), 'أزرق', currentColor),
                    _buildQuickColorBtn(ctx, verse, 'red', const Color(0xFFE53935), 'أحمر', currentColor),
                    if (currentColor != null)
                      IconButton.filledTonal(
                        icon: const Icon(Icons.highlight_off_rounded, color: Colors.red),
                        tooltip: 'إزالة التمييز',
                        onPressed: () async {
                          Navigator.pop(ctx);
                          await ref.read(bibleRepositoryProvider).removeVerseHighlight(
                            widget.bookId,
                            widget.chapter,
                            verse.verseNumber,
                          );
                          ref.invalidate(chapterHighlightsProvider((bookId: widget.bookId, chapter: widget.chapter)));
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickColorBtn(
    BuildContext ctx,
    BibleVerse verse,
    String colorKey,
    Color color,
    String name,
    String? current,
  ) {
    final isSelected = current == colorKey;
    return InkWell(
      onTap: () async {
        Navigator.pop(ctx);
        HapticFeedback.selectionClick();
        await ref.read(bibleRepositoryProvider).setVerseHighlight(
          widget.bookId,
          widget.chapter,
          verse.verseNumber,
          colorKey,
        );
        ref.invalidate(chapterHighlightsProvider((bookId: widget.bookId, chapter: widget.chapter)));
      },
      borderRadius: BorderRadius.circular(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.white : Colors.black26,
                width: isSelected ? 3.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: isSelected ? const Icon(Icons.check_rounded, color: Colors.white, size: 24) : null,
          ),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(fontSize: 11, fontFamily: 'Cairo', fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookAsync = ref.watch(bookInfoProvider(widget.bookId));
    final versesAsync = ref.watch(
      chapterVersesProvider((bookId: widget.bookId, chapter: widget.chapter)),
    );
    final highlightsAsync = ref.watch(
      chapterHighlightsProvider((bookId: widget.bookId, chapter: widget.chapter)),
    );
    final highlights = highlightsAsync.value ?? <int, String>{};

    return bookAsync.when(
      data: (book) => Scaffold(
        backgroundColor: _isCandleMode ? const Color(0xFF18130E) : null,
        appBar: _isFocusMode
            ? null
            : AppBar(
                backgroundColor: _isCandleMode ? const Color(0xFF130E0A) : null,
                foregroundColor: _isCandleMode ? const Color(0xFFF5ECE0) : null,
                title: Text('${book.nameAr} - الإصحاح ${widget.chapter.arabicDigits}'),
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
                    icon: const Icon(Icons.lightbulb_outline),
                    tooltip: 'تفسير الإصحاح',
                    onPressed: () {
                      context.push('/bible/commentary/${widget.bookId}/${widget.chapter}?bookName=${Uri.encodeComponent(book.nameAr)}');
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      _isChapterBookmarked
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_outline_rounded,
                      color: _isChapterBookmarked ? AppColors.gold : null,
                    ),
                    tooltip: _isChapterBookmarked
                        ? 'إزالة الإصحاح من المفضلة'
                        : 'حفظ الإصحاح في المفضلة',
                    onPressed: () => _toggleChapterBookmark(book.nameAr),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_rounded),
                    tooltip: 'تكبير الخط',
                    onPressed: () {
                      setState(() {
                        _fontSize = (_fontSize + 2).clamp(14, 34);
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_rounded),
                    tooltip: 'تصغير الخط',
                    onPressed: () {
                      setState(() {
                        _fontSize = (_fontSize - 2).clamp(14, 34);
                      });
                    },
                  ),
                  const AppQuickMenu(),
                ],
              ),
        body: Stack(
          children: [
            versesAsync.when(
              data: (verses) {
                if (verses.isEmpty) {
                  return const EmptyView(
                    message: 'لا توجد آيات متاحة',
                    subtitle: 'سيتم إضافة نص هذا الإصحاح قريباً',
                    icon: Icons.menu_book_rounded,
                  );
                }
                return GestureDetector(
                  onScaleStart: _onScaleStart,
                  onScaleUpdate: _onScaleUpdate,
                  onHorizontalDragEnd: (details) => _onHorizontalDragEnd(details, book.chapterCount),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(bookInfoProvider(widget.bookId));
                      ref.invalidate(
                        chapterVersesProvider((bookId: widget.bookId, chapter: widget.chapter)),
                      );
                      ref.invalidate(
                        chapterHighlightsProvider((bookId: widget.bookId, chapter: widget.chapter)),
                      );
                      _checkChapterBookmark();
                    },
                    child: ListView.separated(
                      controller: _scrollController,
                      padding: EdgeInsets.fromLTRB(
                        16,
                        _isFocusMode ? 40 : 16,
                        16,
                        100,
                      ),
                      itemCount: verses.length + 1,
                      separatorBuilder: (_, __) => const SizedBox(height: 6),
                      itemBuilder: (context, index) {
                        if (index == verses.length) {
                          return _buildChapterNavigationFooter(book);
                        }
                        final verse = verses[index];
                        final highlightColor = highlights[verse.verseNumber];
                        final isDark = Theme.of(context).brightness == Brightness.dark;
                        final bgColor = _getHighlightBackgroundColor(highlightColor, isDark);
                        final borderColor = _getHighlightBorderColor(highlightColor);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () => VerseActionsModal.show(
                                context,
                                book: book,
                                verse: verse,
                                chapter: widget.chapter,
                                initialHighlightColor: highlightColor,
                                onHighlightChanged: (color) {
                                  ref.invalidate(chapterHighlightsProvider(
                                    (bookId: widget.bookId, chapter: widget.chapter),
                                  ));
                                },
                              ),
                              onLongPress: () => _showQuickHighlightPicker(book, verse, highlightColor),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: borderColor != null
                                      ? Border.all(color: borderColor, width: 1.2)
                                      : null,
                                ),
                                child: VerseWithCommentary(
                                  bookId: widget.bookId,
                                  chapter: widget.chapter,
                                  verseNumber: verse.verseNumber,
                                  verseText: verse.displayText,
                                  isCandleMode: _isCandleMode,
                                  verseStyle: TextStyle(
                                    fontFamily: AppTypography.fontFamily,
                                    fontSize: _fontSize,
                                    height: 1.9,
                                    color: _isCandleMode ? const Color(0xFFF5ECE0) : null,
                                  ),
                                ),
                              ),
                            ),
                            CrossReferencesWidget(
                              bookId: widget.bookId,
                              chapter: widget.chapter,
                              verse: verse.verseNumber,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
              loading: () => const LoadingView(message: 'جاري تحميل الآيات...'),
              error: (error, stack) => ErrorView(
                message: 'حدث خطأ أثناء تحميل آيات الإصحاح',
                onRetry: () => ref.refresh(
                  chapterVersesProvider((bookId: widget.bookId, chapter: widget.chapter)),
                ),
              ),
            ),

            // مؤشر تكبير الخط العائم عند الـ Pinch-to-Zoom
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

              // شريط أدوات القراءة المريحة العائم
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: AnimatedOpacity(
                  opacity: _isFocusMode ? 0.35 : 1.0,
                  duration: const Duration(milliseconds: 250),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? AppColors.surfaceDark
                                : Colors.white)
                            .withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: AppColors.divider.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // زر التمرير التلقائي
                          InkWell(
                            onTap: _toggleAutoScroll,
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              child: Row(
                                children: [
                                  Icon(
                                    _isAutoScrolling
                                        ? Icons.pause_circle_filled_rounded
                                        : Icons.play_circle_fill_rounded,
                                    color: _isAutoScrolling ? Colors.red : AppColors.primary,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _isAutoScrolling ? 'إيقاف' : 'تمرير تلقائي',
                                    style: AppTypography.caption.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: _isAutoScrolling ? Colors.red : AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (_isAutoScrolling) ...[
                            const SizedBox(width: 6),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _scrollSpeed = _scrollSpeed == 1.0 ? 2.0 : 1.0;
                                });
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${_scrollSpeed.toInt()}x',
                                  style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(width: 8),
                          Container(height: 18, width: 1, color: AppColors.divider),
                          const SizedBox(width: 8),
                          // أزرار تكبير وتصغير سريعة
                          IconButton(
                            icon: const Icon(Icons.text_decrease_rounded, size: 20),
                            tooltip: 'تصغير',
                            visualDensity: VisualDensity.compact,
                            onPressed: () {
                              setState(() {
                                _fontSize = (_fontSize - 2).clamp(14, 34);
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.text_increase_rounded, size: 20),
                            tooltip: 'تكبير',
                            visualDensity: VisualDensity.compact,
                            onPressed: () {
                              setState(() {
                                _fontSize = (_fontSize + 2).clamp(14, 34);
                              });
                            },
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            icon: Icon(
                              _isFocusMode
                                  ? Icons.fullscreen_exit_rounded
                                  : Icons.fullscreen_rounded,
                              size: 20,
                            ),
                            tooltip: _isFocusMode ? 'إلغاء وضع القراءة المركزة' : 'وضع القراءة المركزة',
                            visualDensity: VisualDensity.compact,
                            onPressed: () {
                              setState(() {
                                _isFocusMode = !_isFocusMode;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('الكتاب المقدس')),
        body: const LoadingView(message: 'جاري تحميل بيانات السفر...'),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(title: const Text('الكتاب المقدس')),
        body: ErrorView(
          message: 'حدث خطأ أثناء تحميل بيانات السفر',
          onRetry: () => ref.refresh(bookInfoProvider(widget.bookId)),
        ),
      ),
    );
  }

  Widget _buildChapterNavigationFooter(BibleBook book) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasPrev = widget.chapter > 1;
    final hasNext = widget.chapter < book.chapterCount;

    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2433) : const Color(0xFFF2ECE1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.gold.withValues(alpha: isDark ? 0.35 : 0.25),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          if (hasPrev)
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                  side: BorderSide(color: AppColors.gold.withValues(alpha: 0.7)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                label: Text(
                  'الإصحاح ${(widget.chapter - 1).arabicDigits}',
                  style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  context.pushReplacement('/bible/read/${widget.bookId}/${widget.chapter - 1}');
                },
              ),
            )
          else
            const Spacer(),
          const SizedBox(width: 12),
          if (hasNext)
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                icon: Text(
                  'الإصحاح ${(widget.chapter + 1).arabicDigits}',
                  style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                ),
                label: const Icon(Icons.arrow_back_ios_new_rounded, size: 14),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  context.pushReplacement('/bible/read/${widget.bookId}/${widget.chapter + 1}');
                },
              ),
            )
          else
            const Spacer(),
        ],
      ),
    );
  }
}
