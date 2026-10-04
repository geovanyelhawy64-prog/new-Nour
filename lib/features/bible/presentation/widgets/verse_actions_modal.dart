import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../core/utils/string_extensions.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/common/quote_card_dialog.dart';

class VerseActionsModal extends StatefulWidget {
  final BibleBook book;
  final BibleVerse verse;
  final int chapter;
  final String? initialHighlightColor;
  final ValueChanged<String?>? onHighlightChanged;

  const VerseActionsModal({
    super.key,
    required this.book,
    required this.verse,
    required this.chapter,
    this.initialHighlightColor,
    this.onHighlightChanged,
  });

  static Future<void> show(
    BuildContext context, {
    required BibleBook book,
    required BibleVerse verse,
    required int chapter,
    String? initialHighlightColor,
    ValueChanged<String?>? onHighlightChanged,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => VerseActionsModal(
        book: book,
        verse: verse,
        chapter: chapter,
        initialHighlightColor: initialHighlightColor,
        onHighlightChanged: onHighlightChanged,
      ),
    );
  }

  @override
  State<VerseActionsModal> createState() => _VerseActionsModalState();
}

class _VerseActionsModalState extends State<VerseActionsModal> {
  bool _isBookmarked = false;
  bool _isLoadingBookmark = true;
  String? _currentColor;

  String get _verseContentId =>
      '${widget.book.id}/${widget.chapter}/${widget.verse.verseNumber}';

  @override
  void initState() {
    super.initState();
    _currentColor = widget.initialHighlightColor;
    _checkBookmarkStatus();
  }

  Future<void> _updateHighlight(String? color) async {
    HapticFeedback.selectionClick();
    if (color == null) {
      await DatabaseService.userStore.removeVerseHighlight(
        widget.book.id,
        widget.chapter,
        widget.verse.verseNumber,
      );
    } else {
      await DatabaseService.userStore.setVerseHighlight(
        widget.book.id,
        widget.chapter,
        widget.verse.verseNumber,
        color,
      );
    }
    if (mounted) {
      setState(() => _currentColor = color);
      widget.onHighlightChanged?.call(color);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(color == null ? 'تمت إزالة تمييز الآية' : 'تم تمييز الآية بنجاح'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Widget _buildColorDot(String colorKey, Color color, String label) {
    final isSelected = _currentColor == colorKey;
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: () => _updateHighlight(isSelected ? null : colorKey),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.white : Colors.black26,
              width: isSelected ? 3 : 1,
            ),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: color.withValues(alpha: 0.6),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: isSelected
              ? const Icon(Icons.check_rounded, size: 18, color: Colors.white)
              : null,
        ),
      ),
    );
  }

  Future<void> _checkBookmarkStatus() async {
    final status = await DatabaseService.bookmarksDao
        .isBookmarked('bible', _verseContentId);
    if (mounted) {
      setState(() {
        _isBookmarked = status;
        _isLoadingBookmark = false;
      });
    }
  }

  Future<void> _toggleBookmark() async {
    HapticFeedback.selectionClick();
    final dao = DatabaseService.bookmarksDao;
    if (_isBookmarked) {
      final all = await dao.getBookmarksByType('bible');
      final target = all.where((b) => b.contentId == _verseContentId).firstOrNull;
      if (target != null) {
        await dao.removeBookmark(target.id);
      }
      if (mounted) {
        setState(() => _isBookmarked = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تمت إزالة الآية من المفضلة')),
        );
      }
    } else {
      await dao.addBookmark(
        contentType: 'bible',
        contentId: _verseContentId,
        displayTitle:
            '${widget.book.nameAr} ${widget.chapter.arabicDigits}:${widget.verse.verseNumber.arabicDigits}',
        note: widget.verse.text,
      );
      if (mounted) {
        setState(() => _isBookmarked = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم حفظ الآية في المفضلة بنجاح')),
        );
      }
    }
  }

  void _copyVerse() {
    HapticFeedback.lightImpact();
    final ref =
        '${widget.book.nameAr} ${widget.chapter.arabicDigits}:${widget.verse.verseNumber.arabicDigits}';
    final textToCopy = '«${widget.verse.displayText}» [$ref - تطبيق نور]';
    Clipboard.setData(ClipboardData(text: textToCopy));
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم نسخ الآية والشاهد إلى الحافظة')),
    );
  }

  void _setAsReadingMarker() {
    HapticFeedback.lightImpact();
    PreferencesService.setLastBibleRead(widget.book.id, widget.chapter);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم تعيين ${widget.book.nameAr} - الإصحاح ${widget.chapter.arabicDigits} كموضع القراءة الحالي',
        ),
      ),
    );
  }

  void _showShareCard() {
    Navigator.of(context).pop();
    final ref =
        '${widget.book.nameAr} ${widget.chapter.arabicDigits}:${widget.verse.verseNumber.arabicDigits}';
    QuoteCardDialog.show(
      context,
      text: widget.verse.displayText,
      reference: ref,
      subtitle: widget.book.nameAr,
    );
  }

  @override
  Widget build(BuildContext context) {
    final title =
        '${widget.book.nameAr} - الإصحاح ${widget.chapter.arabicDigits} : الآية ${widget.verse.verseNumber.arabicDigits}';

    return  SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // مقبض السحب العلوي
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // العنوان
              Text(
                title,
                style: AppTypography.heading3.copyWith(
                  fontSize: 16,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // نص الآية
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.15),
                  ),
                ),
                child: Text(
                  '« ${widget.verse.displayText} »',
                  style: AppTypography.scripture.copyWith(
                    fontSize: 17,
                    height: 1.8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 14),

              // شريط تمييز الآية بألوان 4 (أصفر، أخضر، أزرق، أحمر)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withValues(alpha: 0.04)
                      : Colors.black.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white12
                        : Colors.black.withValues(alpha: 0.08),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.palette_rounded, size: 20, color: AppColors.primary),
                    const SizedBox(width: 8),
                    const Text(
                      'تمييز الآية:',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    _buildColorDot('yellow', const Color(0xFFFBC02D), 'أصفر'),
                    const SizedBox(width: 8),
                    _buildColorDot('green', const Color(0xFF43A047), 'أخضر'),
                    const SizedBox(width: 8),
                    _buildColorDot('blue', const Color(0xFF1E88E5), 'أزرق'),
                    const SizedBox(width: 8),
                    _buildColorDot('red', const Color(0xFFE53935), 'أحمر'),
                    if (_currentColor != null) ...[
                      const SizedBox(width: 6),
                      IconButton(
                        icon: const Icon(Icons.highlight_off_rounded, size: 22, color: Colors.grey),
                        tooltip: 'إزالة التمييز',
                        visualDensity: VisualDensity.compact,
                        onPressed: () => _updateHighlight(null),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // خيارات الإجراءات
              // 1. المفضلة
              ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                leading: _isLoadingBookmark
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        _isBookmarked
                            ? Icons.bookmark_added_rounded
                            : Icons.bookmark_add_outlined,
                        color: _isBookmarked ? AppColors.gold : AppColors.primary,
                      ),
                title: Text(
                  _isBookmarked ? 'إزالة من المفضلة' : 'حفظ الآية في المفضلة',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _isBookmarked ? AppColors.goldDark : null,
                  ),
                ),
                onTap: _isLoadingBookmark ? null : _toggleBookmark,
              ),

              // 2. نسخ الآية مع الشاهد
              ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                leading: const Icon(Icons.copy_rounded, color: AppColors.primary),
                title: const Text('نسخ الآية مع الشاهد'),
                onTap: _copyVerse,
              ),

              // 3. مشاركة كبطاقة مصممة
              ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                leading: const Icon(Icons.image_rounded, color: AppColors.gold),
                title: const Text('مشاركة كبطاقة مصممة'),
                subtitle: const Text('تصميم كنسي للمشاركة على واتساب ومنصات التواصل'),
                onTap: _showShareCard,
              ),

              // 4. تعيين موضع القراءة الحالي
              ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                leading: const Icon(Icons.pin_drop_rounded, color: AppColors.accent),
                title: const Text('تثبيت كموضع قراءة حالي'),
                onTap: _setAsReadingMarker,
              ),
            ],
          ),
        ),
      );
  }
}
