import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../providers/cross_reference_providers.dart';

class CrossReferencesWidget extends ConsumerWidget {
  final int bookId;
  final int chapter;
  final int verse;

  const CrossReferencesWidget({
    super.key,
    required this.bookId,
    required this.chapter,
    required this.verse,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refsAsync = ref.watch(
      crossReferencesProvider((
        bookId: bookId,
        chapter: chapter,
        verse: verse,
      )),
    );

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return refsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (refs) {
        if (refs.isEmpty) return const SizedBox.shrink();

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.surfaceDark
                : const Color(0xFFF0F4FF),
            borderRadius: BorderRadius.circular(8),
            border: Border(
              right: BorderSide(
                color: isDark
                    ? const Color(0xFF5B9BD5)
                    : const Color(0xFF1B4F72),
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
                    Icons.link,
                    size: 16,
                    color: isDark
                        ? const Color(0xFF5B9BD5)
                        : const Color(0xFF1B4F72),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'آيات مرتبطة (${refs.length})',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? const Color(0xFF5B9BD5)
                          : const Color(0xFF1B4F72),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...refs.take(5).map((refItem) {
                return InkWell(
                  onTap: () {
                    context.push(
                      '/bible/read/${refItem.bookId}/${refItem.chapter}',
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF5B9BD5).withValues(alpha: 0.2)
                                : const Color(0xFF1B4F72).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${refItem.bookName} ${refItem.chapter}:${refItem.verse}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isDark
                                  ? const Color(0xFF5B9BD5)
                                  : const Color(0xFF1B4F72),
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            refItem.text.length > 80
                                ? '${refItem.text.substring(0, 80)}...'
                                : refItem.text,
                            style: theme.textTheme.bodySmall?.copyWith(
                              height: 1.5,
                              color: isDark
                                  ? const Color(0xFFE8DFD0)
                                  : const Color(0xFF2D2D2D),
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
