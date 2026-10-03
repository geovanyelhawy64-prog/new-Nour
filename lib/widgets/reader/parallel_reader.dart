import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';
import '../../core/services/preferences_service.dart';
import 'role_colored_text.dart';

class ParallelVerseItem {
  final String? coptic;
  final String? arabized;
  final String? arabic;
  final LiturgicalRole role;
  final String? musicalNotation; // هزات الشماس أسامة لطفي

  const ParallelVerseItem({
    this.coptic,
    this.arabized,
    this.arabic,
    this.role = LiturgicalRole.normal,
    this.musicalNotation,
  });
}

enum ParallelDisplayMode {
  all,
  arabicOnly,
  copticOnly,
  arabizedOnly,
}

class ParallelReader extends StatefulWidget {
  final String title;
  final String? subtitle;
  final List<ParallelVerseItem> items;
  final VoidCallback? onBookmarkToggle;
  final bool isBookmarked;

  const ParallelReader({
    super.key,
    required this.title,
    this.subtitle,
    required this.items,
    this.onBookmarkToggle,
    this.isBookmarked = false,
  });

  @override
  State<ParallelReader> createState() => _ParallelReaderState();
}

class _ParallelReaderState extends State<ParallelReader> {
  late double _fontSize;
  ParallelDisplayMode _mode = ParallelDisplayMode.all;

  @override
  void initState() {
    super.initState();
    _fontSize = PreferencesService.getFontSize();
  }

  void _increaseFont() {
    setState(() {
      _fontSize = (_fontSize + 2).clamp(14.0, 36.0);
    });
    PreferencesService.setFontSize(_fontSize);
  }

  void _decreaseFont() {
    setState(() {
      _fontSize = (_fontSize - 2).clamp(14.0, 36.0);
    });
    PreferencesService.setFontSize(_fontSize);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title),
            if (widget.subtitle != null)
              Text(
                widget.subtitle!,
                style: AppTypography.caption.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.text_increase_rounded),
            tooltip: 'تكبير الخط',
            onPressed: _increaseFont,
          ),
          IconButton(
            icon: const Icon(Icons.text_decrease_rounded),
            tooltip: 'تصغير الخط',
            onPressed: _decreaseFont,
          ),
          if (widget.onBookmarkToggle != null)
            IconButton(
              icon: Icon(widget.isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded),
              tooltip: 'حفظ',
              color: widget.isBookmarked ? AppColors.primary : null,
              onPressed: widget.onBookmarkToggle,
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SegmentedButton<ParallelDisplayMode>(
              segments: const [
                ButtonSegment(
                  value: ParallelDisplayMode.all,
                  label: Text('متزامن'),
                ),
                ButtonSegment(
                  value: ParallelDisplayMode.arabicOnly,
                  label: Text('عربي'),
                ),
                ButtonSegment(
                  value: ParallelDisplayMode.copticOnly,
                  label: Text('قبطي'),
                ),
                ButtonSegment(
                  value: ParallelDisplayMode.arabizedOnly,
                  label: Text('معرب'),
                ),
              ],
              selected: {_mode},
              onSelectionChanged: (selected) {
                setState(() {
                  _mode = selected.first;
                });
              },
            ),
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          itemCount: widget.items.length,
          separatorBuilder: (_, __) => const Divider(height: 24, thickness: 0.5),
          itemBuilder: (context, index) {
            final item = widget.items[index];
            return _buildItem(context, item, isDark);
          },
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, ParallelVerseItem item, bool isDark) {
    switch (_mode) {
      case ParallelDisplayMode.all:
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (item.coptic != null && item.coptic!.isNotEmpty) ...[
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: RoleColoredText(
                    text: item.coptic!,
                    role: item.role,
                    fontSize: _fontSize * 1.05,
                    isCoptic: true,
                  ),
                ),
                const SizedBox(height: 4),
              ],
              if (item.arabized != null && item.arabized!.isNotEmpty) ...[
                Text(
                  item.arabized!,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: _fontSize * 0.95,
                    color: isDark ? AppColors.accent : AppColors.primaryDark,
                    fontWeight: FontWeight.w600,
                    height: 1.8,
                  ),
                ),
                const SizedBox(height: 4),
              ],
              if (item.arabic != null && item.arabic!.isNotEmpty) ...[
                RoleColoredText(
                  text: item.arabic!,
                  role: item.role,
                  fontSize: _fontSize,
                ),
              ],
              if (item.musicalNotation != null && item.musicalNotation!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'هزات: ${item.musicalNotation}',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: _fontSize * 0.8,
                      color: AppColors.primary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );

      case ParallelDisplayMode.arabicOnly:
        return item.arabic != null
            ? RoleColoredText(
                text: item.arabic!,
                role: item.role,
                fontSize: _fontSize,
              )
            : const SizedBox.shrink();

      case ParallelDisplayMode.copticOnly:
        return item.coptic != null
            ? Directionality(
                textDirection: TextDirection.ltr,
                child: RoleColoredText(
                  text: item.coptic!,
                  role: item.role,
                  fontSize: _fontSize * 1.1,
                  isCoptic: true,
                ),
              )
            : const SizedBox.shrink();

      case ParallelDisplayMode.arabizedOnly:
        return item.arabized != null
            ? SelectableText(
                item.arabized!,
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: _fontSize,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  height: 1.8,
                ),
              )
            : const SizedBox.shrink();
    }
  }
}
