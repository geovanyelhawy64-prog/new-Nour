import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/coptic_calendar/coptic_date.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/common/empty_view.dart';
import '../../../../widgets/common/error_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class SaintReaderScreen extends StatefulWidget {
  final String saintId;

  const SaintReaderScreen({super.key, required this.saintId});

  @override
  State<SaintReaderScreen> createState() => _SaintReaderScreenState();
}

class _SaintReaderScreenState extends State<SaintReaderScreen> {
  late Future<Saint?> _saintFuture;
  late double _fontSize;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _fontSize = PreferencesService.getFontSize();
    _saintFuture = DatabaseService.instance.saintsDao.getSaintById(widget.saintId);
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    final status = await DatabaseService.bookmarksDao
        .isBookmarked('saints', widget.saintId);
    if (mounted) {
      setState(() => _isBookmarked = status);
    }
  }

  Future<void> _toggleBookmark(Saint saint) async {
    HapticFeedback.selectionClick();
    final dao = DatabaseService.bookmarksDao;
    if (_isBookmarked) {
      final all = await dao.getBookmarksByType('saints');
      final target = all.where((b) => b.contentId == widget.saintId).firstOrNull;
      if (target != null) {
        await dao.removeBookmark(target.id);
      }
      if (mounted) {
        setState(() => _isBookmarked = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تمت إزالة سيرة القديس من المفضلة')),
        );
      }
    } else {
      await dao.addBookmark(
        contentType: 'saints',
        contentId: widget.saintId,
        displayTitle: saint.nameAr,
        note: saint.biography.length > 80 ? '${saint.biography.substring(0, 80)}...' : saint.biography,
      );
      if (mounted) {
        setState(() => _isBookmarked = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم حفظ سيرة القديس في المفضلة بنجاح')),
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

  void _copySaintBio(Saint saint) {
    final buffer = StringBuffer();
    buffer.writeln(saint.nameAr);
    if (saint.nameCoptic != null && saint.nameCoptic!.isNotEmpty) {
      buffer.writeln(saint.nameCoptic);
    }
    if (saint.feastMonth != null && saint.feastDay != null &&
        saint.feastMonth! >= 1 && saint.feastMonth! <= 13) {
      buffer.writeln('التذكار: ${saint.feastDay} ${CopticDate.monthNames[saint.feastMonth! - 1]}');
    }
    buffer.writeln();
    buffer.writeln(saint.biography);
    buffer.writeln();
    buffer.writeln('بركة صلواته تكون معنا. آمين.');

    Clipboard.setData(ClipboardData(text: buffer.toString()));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم نسخ سيرة القديس إلى الحافظة')),
      );
    }
  }

  String _formatFeastDate(int? month, int? day) {
    if (month == null || day == null) return '';
    if (month < 1 || month > 13) return '';
    return '$day ${CopticDate.monthNames[month - 1]}';
  }

  String _formatCategory(String type) {
    switch (type) {
      case 'martyrs':
        return 'شهيد';
      case 'monks':
        return 'راهب وناسك';
      case 'patriarchs':
        return 'بطريرك وأسقف';
      case 'modern':
        return 'قديس معاصر';
      case 'women':
        return 'قديسة وعذراء';
      default:
        return 'قديس ومعترف';
    }
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<Saint?>(
        future: _saintFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(title: const Text('سيرة القديس')),
              body: const LoadingView(message: 'جاري تحميل سيرة القديس...'),
            );
          }

          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: const Text('سيرة القديس')),
              body: ErrorView(
                message: 'حدث خطأ أثناء تحميل سيرة القديس',
                onRetry: () => setState(() {
                  _saintFuture = DatabaseService.instance.saintsDao.getSaintById(widget.saintId);
                }),
              ),
            );
          }

          final saint = snapshot.data;
          if (saint == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('سيرة القديس')),
              body: EmptyView(
                message: 'لم يتم العثور على سيرة هذا القديس',
                icon: Icons.person_off_rounded,
                action: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('العودة'),
                ),
              ),
            );
          }

          final feastText = _formatFeastDate(saint.feastMonth, saint.feastDay);

          return Scaffold(
            appBar: AppBar(
              title: Text(saint.nameAr, overflow: TextOverflow.ellipsis),
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
                  tooltip: 'نسخ السيرة',
                  onPressed: () => _copySaintBio(saint),
                ),
                IconButton(
                  icon: Icon(
                    _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                    color: _isBookmarked ? AppColors.gold : null,
                  ),
                  tooltip: _isBookmarked ? 'إزالة من المفضلة' : 'حفظ في المفضلة',
                  onPressed: () => _toggleBookmark(saint),
                ),
                const AppQuickMenu(),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // بطاقة العنوان والتفاصيل
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary.withValues(alpha: 0.15),
                            ),
                            child: const Icon(
                              Icons.auto_awesome_rounded,
                              color: AppColors.primary,
                              size: 36,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            saint.nameAr,
                            style: AppTypography.heading1.copyWith(
                              fontSize: 22,
                              color: AppColors.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (saint.nameCoptic != null && saint.nameCoptic!.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                saint.nameCoptic!,
                                style: const TextStyle(
                                  fontFamily: AppTypography.fontFamilyCoptic,
                                  fontSize: 18,
                                  color: AppColors.accent,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            alignment: WrapAlignment.center,
                            children: [
                              Chip(
                                avatar: const Icon(Icons.category_rounded, size: 16, color: AppColors.primary),
                                label: Text(_formatCategory(saint.type)),
                                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                              ),
                              if (feastText.isNotEmpty)
                                Chip(
                                  avatar: const Icon(Icons.event_rounded, size: 16, color: AppColors.gold),
                                  label: Text('التذكار: $feastText'),
                                  backgroundColor: AppColors.gold.withValues(alpha: 0.15),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // نص السيرة الكامل
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
                                'السيرة العطرة',
                                style: AppTypography.heading2.copyWith(fontSize: 18, color: AppColors.primary),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          SelectableText(
                            saint.biography.isNotEmpty ? saint.biography : saint.shortBio,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: _fontSize,
                              height: 1.85,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.gold.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.church_rounded, color: AppColors.primary),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'بركة صلوات وشفاعة هذا القديس العظيم تكون معنا جميعاً. آمين.',
                                    style: AppTypography.bodySmall.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
      );
  }
}
