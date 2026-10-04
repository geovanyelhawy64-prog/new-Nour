import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';
import '../../core/services/preferences_service.dart';

class TextReader extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String content;
  final Widget? headerWidget;
  final VoidCallback? onBookmarkToggle;
  final bool isBookmarked;
  final List<Widget>? customWidgets;

  const TextReader({
    super.key,
    required this.title,
    this.subtitle,
    required this.content,
    this.headerWidget,
    this.onBookmarkToggle,
    this.isBookmarked = false,
    this.customWidgets,
  });

  @override
  State<TextReader> createState() => _TextReaderState();
}

class _TextReaderState extends State<TextReader> {
  late double _fontSize;
  late bool _bookmarked;

  @override
  void initState() {
    super.initState();
    _fontSize = PreferencesService.getFontSize();
    _bookmarked = widget.isBookmarked;
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

  void _copyContent() {
    Clipboard.setData(ClipboardData(text: widget.content));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ النص إلى الحافظة', textAlign: TextAlign.center),
        duration: Duration(seconds: 2),
      ),
    );
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
          IconButton(
            icon: const Icon(Icons.copy_rounded),
            tooltip: 'نسخ النص',
            onPressed: _copyContent,
          ),
          if (widget.onBookmarkToggle != null)
            IconButton(
              icon: Icon(_bookmarked ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded),
              tooltip: _bookmarked ? 'إزالة من المحفوظات' : 'حفظ في المفضلة',
              color: _bookmarked ? AppColors.primary : null,
              onPressed: () {
                setState(() {
                  _bookmarked = !_bookmarked;
                });
                widget.onBookmarkToggle?.call();
              },
            ),
        ],
      ),
      body:  ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            if (widget.headerWidget != null) ...[
              widget.headerWidget!,
              const SizedBox(height: 16),
            ],
            if (widget.customWidgets != null)
              ...widget.customWidgets!
            else
              SelectableText(
                widget.content,
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: _fontSize,
                  height: 2.0,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
          ],
        ),
    );
  }
}
