import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// أوضاع عرض النصوص الكنسية
enum TextDisplayMode {
  arabic('عربي'),
  coptic('قبطي'),
  copticArabic('قبطي معرب'),
  all('الكل (٤ أسطر)');

  final String label;
  const TextDisplayMode(this.label);
}

/// مبدل أوضاع النص الموحد (يعمل كمنتقي وضع النص، أو كعارض نصوص متعدد اللغات)
class TextModeSwitcher extends StatefulWidget {
  final String? arabicText;
  final String? copticText;
  final String? phoneticText;
  final bool showHymnLayout;

  final TextDisplayMode? currentMode;
  final List<TextDisplayMode> availableModes;
  final ValueChanged<TextDisplayMode>? onChanged;
  final ValueChanged<TextDisplayMode>? onModeChanged;

  const TextModeSwitcher({
    super.key,
    this.arabicText,
    this.copticText,
    this.phoneticText,
    this.showHymnLayout = false,
    this.currentMode,
    this.availableModes = const [
      TextDisplayMode.arabic,
      TextDisplayMode.coptic,
      TextDisplayMode.copticArabic,
    ],
    this.onChanged,
    this.onModeChanged,
  });

  @override
  State<TextModeSwitcher> createState() => _TextModeSwitcherState();
}

class _TextModeSwitcherState extends State<TextModeSwitcher> {
  late TextDisplayMode _activeMode;

  @override
  void initState() {
    super.initState();
    _activeMode = widget.currentMode ?? TextDisplayMode.arabic;
  }

  @override
  void didUpdateWidget(TextModeSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentMode != null && widget.currentMode != _activeMode) {
      _activeMode = widget.currentMode!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final callback = widget.onModeChanged ?? widget.onChanged;

    // إذا كان المكون مستخدماً كزر منبثق لاختيار الوضع
    if (callback != null && widget.arabicText == null) {
      final gold = AppTheme.gold(context);
      return PopupMenuButton<TextDisplayMode>(
        icon: Icon(Icons.text_fields_rounded, color: gold),
        tooltip: 'وضع النص',
        onSelected: callback,
        itemBuilder: (_) => widget.availableModes.map((mode) {
          final isActive = (widget.currentMode ?? _activeMode) == mode;
          return PopupMenuItem<TextDisplayMode>(
            value: mode,
            child: Row(
              children: [
                Icon(
                  isActive ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: isActive ? gold : Colors.grey,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  mode.label,
                  style: TextStyle(
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isActive ? gold : null,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }

    // إذا كان المكون مستخدماً كعارض نصوص ثلاثي اللغات (تسبحة / طقس / ألحان)
    final hasCoptic = widget.copticText != null && widget.copticText!.isNotEmpty;
    final hasPhonetic = widget.phoneticText != null && widget.phoneticText!.isNotEmpty;
    final hasArabic = widget.arabicText != null && widget.arabicText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (hasCoptic || hasPhonetic)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (hasArabic)
                  _buildTabChip('عربي', TextDisplayMode.arabic),
                if (hasCoptic)
                  _buildTabChip('قبطي', TextDisplayMode.coptic),
                if (hasPhonetic)
                  _buildTabChip('معرب', TextDisplayMode.copticArabic),
                if (widget.showHymnLayout)
                  _buildTabChip('الكل', TextDisplayMode.all),
              ],
            ),
          ),
        _buildContent(),
      ],
    );
  }

  Widget _buildTabChip(String label, TextDisplayMode mode) {
    final isSelected = _activeMode == mode;
    final gold = AppTheme.gold(context);

    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 6),
      child: ChoiceChip(
        label: Text(label, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        selected: isSelected,
        selectedColor: gold.withValues(alpha: 0.2),
        onSelected: (_) => setState(() => _activeMode = mode),
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  Widget _buildContent() {
    if (_activeMode == TextDisplayMode.all) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.copticText != null)
            SelectableText(
              widget.copticText!,
              style: AppTypography.coptic.copyWith(fontSize: 16, height: 1.8),
              textDirection: TextDirection.ltr,
            ),
          if (widget.phoneticText != null) ...[
            const SizedBox(height: 6),
            SelectableText(
              widget.phoneticText!,
              style: AppTypography.caption.copyWith(fontSize: 14, height: 1.6, color: AppColors.primary),
            ),
          ],
          if (widget.arabicText != null) ...[
            const SizedBox(height: 6),
            SelectableText(
              widget.arabicText!,
              style: AppTypography.scripture.copyWith(fontSize: 16, height: 1.8),
            ),
          ],
        ],
      );
    }

    if (_activeMode == TextDisplayMode.coptic && widget.copticText != null) {
      return SelectableText(
        widget.copticText!,
        style: AppTypography.coptic.copyWith(fontSize: 16, height: 1.8),
        textDirection: TextDirection.ltr,
      );
    }

    if (_activeMode == TextDisplayMode.copticArabic && widget.phoneticText != null) {
      return SelectableText(
        widget.phoneticText!,
        style: AppTypography.scripture.copyWith(fontSize: 16, height: 1.8, color: AppColors.primary),
      );
    }

    return SelectableText(
      widget.arabicText ?? '',
      style: AppTypography.scripture.copyWith(fontSize: 16, height: 1.8),
    );
  }
}
