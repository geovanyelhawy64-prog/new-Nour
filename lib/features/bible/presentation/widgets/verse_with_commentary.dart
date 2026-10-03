import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../providers/commentary_providers.dart';

class VerseWithCommentary extends ConsumerWidget {
  final int bookId;
  final int chapter;
  final int verseNumber;
  final String verseText;
  final TextStyle? verseStyle;
  final bool isCandleMode;

  const VerseWithCommentary({
    super.key,
    required this.bookId,
    required this.chapter,
    required this.verseNumber,
    required this.verseText,
    this.verseStyle,
    this.isCandleMode = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentaryAsync = ref.watch(
      verseCommentaryProvider((
        bookId: bookId,
        chapter: chapter,
        verse: verseNumber,
      )),
    );

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الآية
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$verseNumber ',
                  style: (verseStyle ?? theme.textTheme.bodyLarge)?.copyWith(
                    fontSize: (verseStyle?.fontSize ?? 18) * 0.75,
                    color: isCandleMode
                        ? const Color(0xFFD4AF37)
                        : (isDark
                            ? const Color(0xFF9B9484)
                            : const Color(0xFF6B6B6B)),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: verseText,
                  style: verseStyle ?? theme.textTheme.bodyLarge,
                ),
              ],
            ),
            textDirection: TextDirection.rtl,
          ),
        ),

        // التفسير (لو موجود)
        commentaryAsync.whenOrNull(
          data: (commentaries) {
            if (commentaries.isEmpty) return const SizedBox.shrink();

            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isCandleMode
                    ? const Color(0xFF231B15)
                    : (isDark
                        ? AppColors.surfaceDark
                        : AppColors.surfaceLight),
                borderRadius: BorderRadius.circular(8),
                border: Border(
                  right: BorderSide(
                    color: isCandleMode
                        ? const Color(0xFFD4AF37)
                        : (isDark
                            ? AppColors.primaryLight
                            : AppColors.primary),
                    width: 3,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        size: 16,
                        color: isDark
                            ? const Color(0xFFD4A843)
                            : const Color(0xFFC49B3C),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'التفسير',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? const Color(0xFFD4A843)
                              : const Color(0xFFC49B3C),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        commentaries.first.author,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? const Color(0xFF9B9484)
                              : const Color(0xFF6B6B6B),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    commentaries.first.text,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 15,
                      height: 1.8,
                      color: isDark
                          ? const Color(0xFFE8DFD0)
                          : const Color(0xFF2D2D2D),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            );
          },
        ) ?? const SizedBox.shrink(),
      ],
    );
  }
}
