import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/database_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/common/empty_view.dart';
import '../../../../widgets/common/error_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class TheologyTopicScreen extends StatefulWidget {
  final String topicId;

  const TheologyTopicScreen({super.key, required this.topicId});

  @override
  State<TheologyTopicScreen> createState() => _TheologyTopicScreenState();
}

class _TheologyTopicScreenState extends State<TheologyTopicScreen> {
  late Future<List<TheologyArticle>> _articlesFuture;

  @override
  void initState() {
    super.initState();
    _articlesFuture = DatabaseService.instance.theologyDao.getArticlesByCategory(widget.topicId);
  }

  String _getTopicTitle(String topicId) {
    switch (topicId) {
      case 'trinity':
        return 'عقيدة الثالوث القدوس';
      case 'nature_of_christ':
        return 'طبيعة السيد المسيح';
      case 'incarnation':
        return 'التجسد وطبيعة السيد المسيح';
      case 'redemption':
        return 'الفداء والصليب والقيامة';
      case 'church':
        return 'الكنيسة طبيعتها ورسالتها';
      case 'sacraments':
        return 'الأسرار الكنسية شرح لاهوتي';
      case 'theotokos':
        return 'العذراء مريم والدة الإله';
      case 'intercession':
        return 'شفاعة القديسين وإكرام العذراء';
      case 'angels':
        return 'الملائكة والأجناد السماوية';
      case 'salvation':
        return 'مفهوم الخلاص والجهاد';
      case 'ecumenical_councils':
      case 'councils':
        return 'المجامع المسكونية وقانون الإيمان';
      case 'heresies':
        return 'الهرطقات والردود العقائدية';
      case 'church_history':
        return 'تاريخ الكنيسة القبطية الأرثوذكسية';
      case 'church_rites':
        return 'الموسوعة الطقسية الكنسية';
      case 'church_books':
        return 'أمهات الكتب الكنسية والآبائية';
      case 'tradition':
        return 'التقليد الكنسي الشريف';
      case 'liturgy_rites':
        return 'شرح القداس الإلهي والطقوس';
      case 'patristics':
        return 'أقوال الآباء القديسين والرهبنة';
      case 'apologetics_faq':
        return 'أسئلة إيمانية وطقسية شائعة';
      case 'apologetics':
        return 'الرد على الشبهات وعصمة الكتاب';
      default:
        return 'اللاهوت والعقيدة';
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = _getTopicTitle(widget.topicId);

    return  Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: const [
            AppQuickMenu(),
          ],
        ),
        body: FutureBuilder<List<TheologyArticle>>(
          future: _articlesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingView(message: 'جاري تحميل المقالات اللاهوتية...');
            }

            if (snapshot.hasError) {
              return ErrorView(
                message: 'حدث خطأ أثناء تحميل المقالات اللاهوتية',
                onRetry: () => setState(() {
                  _articlesFuture = DatabaseService.instance.theologyDao.getArticlesByCategory(widget.topicId);
                }),
              );
            }

            final articles = snapshot.data ?? [];
            if (articles.isEmpty) {
              return EmptyView(
                message: 'لا توجد مقالات متاحة لهذا الموضوع حالياً',
                subtitle: title,
                icon: Icons.menu_book_rounded,
              );
            }

            return RefreshIndicator(
              onRefresh: () async => setState(() {
                _articlesFuture = DatabaseService.instance.theologyDao.getArticlesByCategory(widget.topicId);
              }),
              child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: articles.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => context.push('/theology/article/${article.id}'),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                '${article.articleOrder}',
                                style: AppTypography.heading3.copyWith(color: AppColors.primary),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title,
                                  style: AppTypography.heading3.copyWith(fontSize: 16),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  article.content.replaceAll('\n', ' '),
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.textSecondaryLight,
                                    height: 1.4,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: AppColors.textSecondaryLight,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
        ),
      );
  }
}
