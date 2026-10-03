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

class PrayerReaderScreen extends StatefulWidget {
  final String categoryId;

  const PrayerReaderScreen({super.key, required this.categoryId});

  @override
  State<PrayerReaderScreen> createState() => _PrayerReaderScreenState();
}

class _PrayerReaderScreenState extends State<PrayerReaderScreen> {
  late Future<List<OccasionalPrayer>> _prayersFuture;
  late double _fontSize;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _fontSize = PreferencesService.getFontSize();
    _loadPrayers();
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    final status = await DatabaseService.userData
        .isBookmarked('prayers', widget.categoryId);
    if (mounted) {
      setState(() => _isBookmarked = status);
    }
  }

  Future<void> _toggleBookmark(String title) async {
    HapticFeedback.selectionClick();
    final dao = DatabaseService.userData;
    if (_isBookmarked) {
      final all = await dao.getBookmarksByType('prayers');
      final target = all.where((b) => b.contentId == widget.categoryId).firstOrNull;
      if (target != null) {
        await dao.removeBookmark(target.id);
      }
      if (mounted) {
        setState(() => _isBookmarked = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تمت إزالة الصلوات من المفضلة')),
        );
      }
    } else {
      await dao.addBookmark(
        contentType: 'prayers',
        contentId: widget.categoryId,
        displayTitle: title,
      );
      if (mounted) {
        setState(() => _isBookmarked = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم حفظ الصلوات في المفضلة بنجاح')),
        );
      }
    }
  }

  void _loadPrayers() {
    _prayersFuture = DatabaseService.instance.prayersDao.getPrayersByCategory(widget.categoryId);
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

  void _copyPrayer(OccasionalPrayer prayer) {
    Clipboard.setData(ClipboardData(text: '${prayer.title}\n\n${prayer.content}'));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم نسخ الصلاة إلى الحافظة')),
      );
    }
  }

  String _getCategoryTitle(String id) {
    switch (id) {
      case 'daily':
        return 'صلوات الحياة اليومية';
      case 'protection':
        return 'صلوات الحماية والتحصين';
      case 'departed':
        return 'صلوات الراقدين والتعزية';
      case 'communion':
        return 'صلوات التناول المقدس';
      case 'study':
      case 'exams':
        return 'صلوات الطلبة والدارسين';
      case 'travel':
        return 'صلوات المسافرين';
      case 'healing':
      case 'illness':
        return 'صلوات الشفاء والمرضى';
      case 'meals':
        return 'صلوات المائدة والبركة';
      case 'repentance':
        return 'صلوات التوبة والانسحاق';
      case 'distress':
        return 'صلوات الضيق والشدة';
      case 'family':
        return 'صلوات الأسرة والبركة';
      case 'work':
        return 'صلوات العمل والتوفيق';
      case 'thanks':
        return 'صلوات الشكر والتسبيح';
      default:
        return 'صلوات المناسبات';
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = _getCategoryTitle(widget.categoryId);

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
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
              color: _isBookmarked ? AppColors.gold : null,
            ),
            tooltip: _isBookmarked ? 'إزالة من المفضلة' : 'حفظ في المفضلة',
            onPressed: () => _toggleBookmark(title),
          ),
          const AppQuickMenu(),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: FutureBuilder<List<OccasionalPrayer>>(
          future: _prayersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingView(message: 'جاري تحميل الصلوات...');
            }

            if (snapshot.hasError) {
              return ErrorView(
                message: 'حدث خطأ أثناء تحميل الصلوات',
                onRetry: () => setState(() => _loadPrayers()),
              );
            }

            final prayers = snapshot.data ?? [];
            if (prayers.isEmpty) {
              return EmptyView(
                message: 'لا توجد صلوات مسجلة في هذا القسم حالياً',
                subtitle: title,
                icon: Icons.auto_stories_rounded,
              );
            }

            return RefreshIndicator(
              onRefresh: () async => setState(() => _loadPrayers()),
              child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: prayers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final p = prayers[index];
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
                                p.title,
                                style: AppTypography.heading3.copyWith(
                                  fontSize: 16,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy_rounded, size: 18),
                              tooltip: 'نسخ الصلاة',
                              onPressed: () => _copyPrayer(p),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(height: 1),
                        const SizedBox(height: 14),

                        // Prayer Content with full tashkeel
                        SelectableText(
                          p.content,
                          style: AppTypography.bodyLarge.copyWith(
                            fontSize: _fontSize,
                            height: 1.9,
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
      ),
    );
  }
}
