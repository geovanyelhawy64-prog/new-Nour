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

class SacramentDetailScreen extends StatefulWidget {
  final String sacramentId;

  const SacramentDetailScreen({super.key, required this.sacramentId});

  @override
  State<SacramentDetailScreen> createState() => _SacramentDetailScreenState();
}

class _SacramentDetailScreenState extends State<SacramentDetailScreen> {
  late String _activeId;
  late Future<List<SacramentSection>> _sectionsFuture;
  late double _fontSize;

  @override
  void initState() {
    super.initState();
    _fontSize = PreferencesService.getFontSize();
    _activeId = _normalizeId(widget.sacramentId);
    _loadData();
  }

  String _normalizeId(String id) {
    if (id == 'confession') return 'repentance';
    if (id == 'confirmation') return 'chrismation';
    return id;
  }

  void _loadData() {
    _sectionsFuture = DatabaseService.instance.sacramentsDao.getSectionsForSacrament(_activeId);
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

  void _copySection(String title, String content) {
    Clipboard.setData(ClipboardData(text: '$title\n\n$content'));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم نسخ النص إلى الحافظة')),
      );
    }
  }

  String _getSacramentTitle(String id) {
    switch (id) {
      case 'baptism':
        return 'سر المعمودية المقدس';
      case 'chrismation':
        return 'سر الميرون المقدس';
      case 'repentance':
        return 'سر التوبة والاعتراف';
      case 'eucharist':
        return 'سر الإفخارستيا المقدس';
      case 'unction':
        return 'سر مسحة المرضى (القنديل)';
      case 'matrimony':
        return 'سر الزيجة المقدس (الإكليل)';
      case 'priesthood':
        return 'سر الكهنوت المقدس';
      default:
        return 'سر من أسرار الكنيسة';
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = _getSacramentTitle(_activeId);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.text_increase_rounded, size: 20),
            tooltip: 'تكبير الخط',
            onPressed: _increaseFont,
          ),
          IconButton(
            icon: const Icon(Icons.text_decrease_rounded, size: 20),
            tooltip: 'تصغير الخط',
            onPressed: _decreaseFont,
          ),
          const AppQuickMenu(),
        ],
      ),
      body:  FutureBuilder<List<SacramentSection>>(
          future: _sectionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingView(message: 'جاري تحميل شروحات السر المقدس...');
            }

            if (snapshot.hasError) {
              return ErrorView(
                message: 'حدث خطأ أثناء تحميل شروحات السر المقدس',
                onRetry: () => setState(() => _loadData()),
              );
            }

            final sections = snapshot.data ?? [];
            if (sections.isEmpty) {
              return EmptyView(
                message: 'لا توجد شروحات مسجلة لهذا السر حالياً',
                subtitle: title,
                icon: Icons.church_rounded,
              );
            }

            return RefreshIndicator(
              onRefresh: () async => setState(() => _loadData()),
              child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: sections.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final sec = sections[index];

                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                sec.title,
                                style: AppTypography.heading3.copyWith(
                                  fontSize: 16,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy_rounded, size: 18),
                              tooltip: 'نسخ الشرح',
                              onPressed: () => _copySection(sec.title, sec.content),
                            ),
                          ],
                        ),

                        // Biblical Scriptures badge
                        if (sec.scriptures != null && sec.scriptures!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.menu_book_rounded, size: 14, color: AppColors.primary),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    sec.scriptures!,
                                    style: AppTypography.caption.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: 12),
                        const Divider(height: 1),
                        const SizedBox(height: 14),

                        // Section text with full diacritics
                        SelectableText(
                          sec.content,
                          style: AppTypography.bodyLarge.copyWith(
                            fontSize: _fontSize,
                            height: 1.85,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
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
