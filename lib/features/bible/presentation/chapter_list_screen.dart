import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../widgets/common/empty_view.dart';
import '../../../../widgets/common/error_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';
import '../providers/bible_providers.dart';

class ChapterListScreen extends ConsumerWidget {
  final int bookId;

  const ChapterListScreen({super.key, required this.bookId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookAsync = ref.watch(bookInfoProvider(bookId));

    return bookAsync.when(
      data: (book) => Scaffold(
        appBar: AppBar(
          title: Text(book.nameAr),
          actions: const [
            AppQuickMenu(),
          ],
        ),
        body: book.chapterCount == 0
            ? const EmptyView(
                message: 'لا توجد إصحاحات متاحة لهذا السفر',
                icon: Icons.menu_book_rounded,
              )
            : RefreshIndicator(
                onRefresh: () => ref.refresh(bookInfoProvider(bookId).future),
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: book.chapterCount,
                  itemBuilder: (context, index) {
                    final chapter = index + 1;
                    return InkWell(
                      onTap: () => context.push('/bible/read/$bookId/$chapter'),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                        ),
                        child: Center(
                          child: Text(
                            '$chapter',
                            style: AppTypography.heading3.copyWith(color: AppColors.primaryDark),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('الكتاب المقدس')),
        body: const LoadingView(message: 'جاري تحميل الإصحاحات...'),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(title: const Text('الكتاب المقدس')),
        body: ErrorView(
          message: 'حدث خطأ أثناء تحميل بيانات السفر',
          onRetry: () => ref.refresh(bookInfoProvider(bookId)),
        ),
      ),
    );
  }
}
