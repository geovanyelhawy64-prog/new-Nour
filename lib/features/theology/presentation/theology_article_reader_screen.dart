import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/common/empty_view.dart';
import '../../../../widgets/common/error_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class TheologyArticleReaderScreen extends StatefulWidget {
  final String articleId;

  const TheologyArticleReaderScreen({super.key, required this.articleId});

  @override
  State<TheologyArticleReaderScreen> createState() => _TheologyArticleReaderScreenState();
}

class _TheologyArticleReaderScreenState extends State<TheologyArticleReaderScreen> {
  late Future<TheologyArticle?> _articleFuture;
  late double _fontSize;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _fontSize = PreferencesService.getFontSize();
    _articleFuture = DatabaseService.instance.theologyDao.getArticleById(widget.articleId);
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    final status = await DatabaseService.userData
        .isBookmarked('theology', widget.articleId);
    if (mounted) {
      setState(() => _isBookmarked = status);
    }
  }

  Future<void> _toggleBookmark(TheologyArticle article) async {
    HapticFeedback.selectionClick();
    final dao = DatabaseService.userData;
    if (_isBookmarked) {
      final all = await dao.getBookmarksByType('theology');
      final target = all.where((b) => b.contentId == widget.articleId).firstOrNull;
      if (target != null) {
        await dao.removeBookmark(target.id);
      }
      if (mounted) {
        setState(() => _isBookmarked = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تمت إزالة المقال من المفضلة')),
        );
      }
    } else {
      await dao.addBookmark(
        contentType: 'theology',
        contentId: widget.articleId,
        displayTitle: article.title,
        note: article.content.length > 80 ? '${article.content.substring(0, 80)}...' : article.content,
      );
      if (mounted) {
        setState(() => _isBookmarked = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم حفظ المقال في المفضلة بنجاح')),
        );
      }
    }
  }

  void _increaseFont() {
    if (_fontSize < 36.0) {
      setState(() => _fontSize += 2.0);
      PreferencesService.setFontSize(_fontSize);
    }
  }

  void _decreaseFont() {
    if (_fontSize > 14.0) {
      setState(() => _fontSize -= 2.0);
      PreferencesService.setFontSize(_fontSize);
    }
  }

  void _copyContent(TheologyArticle article) {
    Clipboard.setData(ClipboardData(text: '${article.title}\n\n${article.content}'));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم نسخ المقال إلى الحافظة')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: FutureBuilder<TheologyArticle?>(
        future: _articleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(title: const Text('العقيدة واللاهوت')),
              body: const LoadingView(message: 'جاري تحميل المقال اللاهوتي...'),
            );
          }

          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: const Text('العقيدة واللاهوت')),
              body: ErrorView(
                message: 'حدث خطأ أثناء تحميل المقال اللاهوتي',
                onRetry: () => setState(() {
                  _articleFuture = DatabaseService.instance.theologyDao.getArticleById(widget.articleId);
                }),
              ),
            );
          }

          final article = snapshot.data;
          if (article == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('العقيدة واللاهوت')),
              body: EmptyView(
                message: 'لم يتم العثور على المقال المطلوب',
                icon: Icons.menu_book_rounded,
                action: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('العودة'),
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(article.categoryAr, overflow: TextOverflow.ellipsis),
              actions: [
                IconButton(
                  icon: const Icon(Icons.text_decrease_rounded),
                  tooltip: 'تصغير الخط',
                  onPressed: _decreaseFont,
                ),
                IconButton(
                  icon: const Icon(Icons.text_increase_rounded),
                  tooltip: 'تكبير الخط',
                  onPressed: _increaseFont,
                ),
                IconButton(
                  icon: const Icon(Icons.copy_rounded),
                  tooltip: 'نسخ المقال',
                  onPressed: () => _copyContent(article),
                ),
                IconButton(
                  icon: Icon(
                    _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                    color: _isBookmarked ? AppColors.gold : null,
                  ),
                  tooltip: _isBookmarked ? 'إزالة من المفضلة' : 'حفظ في المفضلة',
                  onPressed: () => _toggleBookmark(article),
                ),
                const AppQuickMenu(),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // بطاقة العنوان والتصنيف
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withValues(alpha: 0.08),
                            AppColors.gold.withValues(alpha: 0.05),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.psychology_rounded,
                              color: AppColors.primary,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            article.title,
                            style: AppTypography.heading2.copyWith(
                              color: AppColors.primary,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Chip(
                            label: Text(article.categoryAr),
                            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // نص المقال
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.menu_book_rounded, color: AppColors.primary, size: 22),
                              const SizedBox(width: 8),
                              Text(
                                'البيان العقائدي والشواهد',
                                style: AppTypography.heading3.copyWith(color: AppColors.primary),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          SelectableText(
                            article.content,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: _fontSize,
                              height: 1.85,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
