import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/coptic_calendar/coptic_month.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/common/empty_view.dart';
import '../../../../widgets/common/error_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class SynaxariumStoryScreen extends StatefulWidget {
  final int month;
  final int day;

  const SynaxariumStoryScreen({
    super.key,
    required this.month,
    required this.day,
  });

  @override
  State<SynaxariumStoryScreen> createState() => _SynaxariumStoryScreenState();
}

class _SynaxariumStoryScreenState extends State<SynaxariumStoryScreen> {
  late Future<List<SynaxariumEntry>> _entriesFuture;
  late double _fontSize;

  @override
  void initState() {
    super.initState();
    _fontSize = PreferencesService.getFontSize();
    _loadEntries();
  }

  void _loadEntries() {
    _entriesFuture = DatabaseService.instance.synaxariumDao.getEntriesForDay(
      widget.month,
      widget.day,
    );
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

  void _copyStory(SynaxariumEntry entry) {
    Clipboard.setData(ClipboardData(text: '${entry.title}\n\n${entry.fullText}')).then((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم نسخ سيرة القديس إلى الحافظة')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final copticMonth = CopticMonth.fromNumber(widget.month);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'السنكسار - ${widget.day} ${copticMonth.nameAr}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
      body: FutureBuilder<List<SynaxariumEntry>>(
        future: _entriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView(message: 'جاري تحميل السنكسار...');
          }

          if (snapshot.hasError) {
            return ErrorView(
              message: 'حدث خطأ أثناء تحميل السنكسار',
              onRetry: () => setState(() => _loadEntries()),
            );
          }

          final entries = snapshot.data ?? [];
          if (entries.isEmpty) {
            return EmptyView(
              message: 'لا توجد تذكارات مسجلة لهذا اليوم',
              subtitle: '${widget.day} ${copticMonth.nameAr}',
              icon: Icons.auto_stories_rounded,
            );
          }

          return RefreshIndicator(
            onRefresh: () async => setState(() => _loadEntries()),
            child:  ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: entries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final entry = entries[index];
                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
                      width: 0.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Story Header
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryDark,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                entry.title,
                                style: AppTypography.heading3.copyWith(
                                  fontSize: _fontSize + 1,
                                  color: AppColors.primaryDark,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy_rounded, size: 18),
                              tooltip: 'نسخ السيرة',
                              onPressed: () => _copyStory(entry),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(height: 1),
                        const SizedBox(height: 14),

                        // Full Story Text
                        SelectableText(
                          entry.fullText,
                          style: AppTypography.bodyMedium.copyWith(
                            fontSize: _fontSize,
                            height: 1.8,
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          ),
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
