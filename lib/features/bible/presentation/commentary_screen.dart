import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../core/widgets/noor_app_bar.dart';
import '../providers/commentary_providers.dart';

class CommentaryScreen extends ConsumerWidget {
  final int bookId;
  final int chapter;
  final String bookName;

  const CommentaryScreen({
    super.key,
    required this.bookId,
    required this.chapter,
    required this.bookName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentaryAsync = ref.watch(
      chapterCommentaryProvider((
        bookId: bookId,
        chapter: chapter,
      )),
    );

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: NoorAppBar(
        title: 'تفسير $bookName $chapter',
      ),
      body: commentaryAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'فشل تحميل التفسير',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.invalidate(
                  chapterCommentaryProvider((
                    bookId: bookId,
                    chapter: chapter,
                  )),
                ),
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
        data: (commentaries) {
          if (commentaries.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu_book_outlined,
                    size: 64,
                    color: isDark
                        ? const Color(0xFF9B9484)
                        : const Color(0xFF6B6B6B),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا يوجد تفسير متاح لهذا الإصحاح بعد',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isDark
                          ? const Color(0xFF9B9484)
                          : const Color(0xFF6B6B6B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'سيتم إضافة التفسيرات تدريجياً',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: commentaries.length,
            itemBuilder: (context, index) {
              final commentary = commentaries[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.surfaceDark
                      : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border(
                    right: BorderSide(
                      color: isDark
                          ? AppColors.primaryLight
                          : AppColors.primary,
                      width: 4,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDark ? 0.2 : 0.06,
                      ),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFFD4A843).withValues(alpha: 0.2)
                                : const Color(0xFFC49B3C).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            commentary.isChapterLevel
                                ? 'الإصحاح ${commentary.chapter}'
                                : commentary.reference,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isDark
                                  ? const Color(0xFFD4A843)
                                  : const Color(0xFFC49B3C),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          commentary.author,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isDark
                                ? const Color(0xFF9B9484)
                                : const Color(0xFF6B6B6B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      commentary.summary,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? const Color(0xFFE8DFD0)
                            : const Color(0xFF2D2D2D),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      commentary.text,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 2.0,
                        color: isDark
                            ? const Color(0xFFE8DFD0)
                            : const Color(0xFF2D2D2D),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'المصدر: ${commentary.source}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? const Color(0xFF9B9484)
                            : const Color(0xFF6B6B6B),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
