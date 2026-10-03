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

class BookListScreen extends ConsumerStatefulWidget {
  final String testament;

  const BookListScreen({super.key, required this.testament});

  @override
  ConsumerState<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends ConsumerState<BookListScreen> {
  String _selectedCategory = 'all';

  String get _title {
    switch (widget.testament) {
      case 'old':
        return 'أسفار العهد القديم';
      case 'new':
        return 'أسفار العهد الجديد';
      case 'deutero':
        return 'الأسفار القانونية الثانية';
      default:
        return 'أسفار الكتاب المقدس';
    }
  }

  List<Map<String, String>> _getCategories() {
    if (widget.testament == 'old') {
      return [
        {'id': 'all', 'label': 'جميع الأسفار'},
        {'id': 'law', 'label': 'التوراة (٥)'},
        {'id': 'history', 'label': 'التاريخية (١٢)'},
        {'id': 'poetry', 'label': 'الشعرية (٥)'},
        {'id': 'major_prophets', 'label': 'الأنبياء الكبار (٥)'},
        {'id': 'minor_prophets', 'label': 'الأنبياء الصغار (١٢)'},
      ];
    } else if (widget.testament == 'new') {
      return [
        {'id': 'all', 'label': 'جميع الأسفار'},
        {'id': 'gospels', 'label': 'الأناجيل (٤)'},
        {'id': 'acts', 'label': 'أعمال الرسل (١)'},
        {'id': 'pauline', 'label': 'رسائل بولس (١٤)'},
        {'id': 'catholic', 'label': 'الرسائل الجامعة (٧)'},
        {'id': 'revelation', 'label': 'الرؤيا (١)'},
      ];
    }
    return [
      {'id': 'all', 'label': 'الأسفار القانونية (١٠)'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final booksAsync = ref.watch(booksByTestamentProvider(widget.testament));
    final categories = _getCategories();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          actions: const [
            AppQuickMenu(),
          ],
        ),
        body: Column(
          children: [
            // Category filter chips
            if (categories.length > 1)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border(
                    bottom: BorderSide(color: AppColors.primary.withValues(alpha: 0.15)),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.map((cat) {
                      final isSelected = _selectedCategory == cat['id'];
                      return Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8),
                        child: ChoiceChip(
                          label: Text(cat['label']!),
                          selected: isSelected,
                          selectedColor: AppColors.primary,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : AppColors.primary,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 13,
                          ),
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedCategory = cat['id']!;
                              });
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

            // Book list
            Expanded(
              child: booksAsync.when(
                data: (allBooks) {
                  final books = _selectedCategory == 'all'
                      ? allBooks
                      : allBooks.where((b) => b.category == _selectedCategory).toList();

                  if (books.isEmpty) {
                    return EmptyView(
                      message: 'لا توجد أسفار متاحة',
                      subtitle: 'سيتم تحميل أسفار $_title قريباً',
                      icon: Icons.menu_book_rounded,
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => ref.refresh(booksByTestamentProvider(widget.testament).future),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      itemCount: books.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                            child: Text(
                              '${book.bookOrder}',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Row(
                            children: [
                              Text(
                                book.nameAr,
                                style: AppTypography.heading3.copyWith(fontSize: 16),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  book.categoryAr,
                                  style: AppTypography.caption.copyWith(
                                    fontSize: 11,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text('${book.chapterCount} إصحاحاً'),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                          onTap: () => context.push('/bible/chapters/${book.id}'),
                        );
                      },
                    ),
                  );
                },
                loading: () => const LoadingView(message: 'جاري تحميل الأسفار...'),
                error: (error, stack) => ErrorView(
                  message: 'حدث خطأ أثناء تحميل الأسفار',
                  onRetry: () => ref.refresh(booksByTestamentProvider(widget.testament)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
