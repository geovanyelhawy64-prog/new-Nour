import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// ويدجت ذكية لتمييز وتظليل الكلمات المطابقة لبحث المستخدم في النصوص
class HighlightedText extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle? style;
  final TextStyle? highlightStyle;
  final int? maxLines;
  final TextOverflow? overflow;

  const HighlightedText({
    super.key,
    required this.text,
    required this.query,
    this.style,
    this.highlightStyle,
    this.maxLines,
    this.overflow,
  });

  /// تجريد الحروف لتطابق أدق في اللغة العربية
  static String _normalize(String input) {
    return input
        .replaceAll(RegExp(r'[\u064B-\u065F\u0670]'), '') // التشكيل
        .replaceAll(RegExp(r'[إأآا]'), 'ا') // توحيد الألف
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي')
        .toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty || text.isEmpty) {
      return Text(
        text,
        style: style,
        maxLines: maxLines,
        overflow: overflow,
      );
    }

    final defaultHighlightStyle = highlightStyle ??
        (style ?? const TextStyle()).copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          backgroundColor: AppColors.primary.withValues(alpha: 0.18),
        );

    final normalizedText = _normalize(text);
    final queryWords = trimmedQuery
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .map(_normalize)
        .toList();

    if (queryWords.isEmpty) {
      return Text(
        text,
        style: style,
        maxLines: maxLines,
        overflow: overflow,
      );
    }

    // بناء قائمة بمواضع التطابق في النص
    final spans = <TextSpan>[];
    int currentIndex = 0;

    // البحث عن الكلمات في النص الطبيعي
    final pattern = RegExp(
      queryWords.map(RegExp.escape).join('|'),
      caseSensitive: false,
    );

    final matches = pattern.allMatches(normalizedText).toList();

    if (matches.isEmpty) {
      return Text(
        text,
        style: style,
        maxLines: maxLines,
        overflow: overflow,
      );
    }

    for (final match in matches) {
      // تطابق الموقع تقريبياً مع النص الأصلي
      final start = match.start.clamp(0, text.length);
      final end = match.end.clamp(0, text.length);

      if (start > currentIndex) {
        spans.add(TextSpan(
          text: text.substring(currentIndex, start),
          style: style,
        ));
      }

      if (end > start) {
        spans.add(TextSpan(
          text: text.substring(start, end),
          style: defaultHighlightStyle,
        ));
        currentIndex = end;
      }
    }

    if (currentIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(currentIndex),
        style: style,
      ));
    }

    return Text.rich(
      TextSpan(children: spans),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
