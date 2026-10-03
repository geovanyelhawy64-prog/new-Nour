import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/coptic_calendar/coptic_month.dart';
import '../../../../core/services/database_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/common/empty_view.dart';
import '../../../../widgets/common/error_view.dart';
import '../../../../widgets/common/loading_view.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class FeastsHomeScreen extends StatefulWidget {
  const FeastsHomeScreen({super.key});

  @override
  State<FeastsHomeScreen> createState() => _FeastsHomeScreenState();
}

class _FeastsHomeScreenState extends State<FeastsHomeScreen> {
  late Future<List<FeastsAndFast>> _feastsFuture;

  @override
  void initState() {
    super.initState();
    _feastsFuture = DatabaseService.instance.feastsDao.getAllFeastsAndFasts();
  }

  String _formatDate(FeastsAndFast f) {
    if (f.isMovable) {
      if (f.calculationRule != null) {
        if (f.calculationRule == 'easter') return 'يوم عيد القيامة المجيد';
        if (f.calculationRule!.contains('easter - 7')) return 'الأحد السابع من الصوم الكبير';
        if (f.calculationRule!.contains('easter - 55')) return 'يبدأ قبل القيامة بـ ٥٥ يوماً';
        if (f.calculationRule!.contains('easter - 69')) return 'يبدأ قبل الصوم الكبير بأسبوعين';
        if (f.calculationRule!.contains('easter + 39')) return 'اليوم الأربعون بعد القيامة';
        if (f.calculationRule!.contains('easter + 49')) return 'اليوم الخمسون بعد القيامة';
        if (f.calculationRule!.contains('easter + 50')) return 'اليوم التالي لعيد العنصرة';
        if (f.calculationRule!.contains('easter - 3')) return 'يوم الخميس من أسبوع البصخة';
        if (f.calculationRule!.contains('easter + 7')) return 'الأحد التالي لعيد القيامة';
      }
      return 'عيد متغير التاريخ (بحساب الإبقطي)';
    }

    if (f.copticMonth != null && f.copticDay != null) {
      final monthName = CopticMonth.fromNumber(f.copticMonth!).nameAr;
      return '$monthName ${f.copticDay}';
    }

    return 'تذكار كنسي دائم';
  }

  void _showFeastDetails(FeastsAndFast f) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  f.nameAr,
                  style: AppTypography.heading2.copyWith(fontSize: 18, color: AppColors.primary),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _formatDate(f),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (f.durationDays != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.festive.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'المدة: ${f.durationDays} يوم',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.festive),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 14),
                Text(
                  f.description,
                  style: AppTypography.bodyMedium.copyWith(height: 1.8),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الأعياد والأصوام الكنسية'),
          actions: const [
            AppQuickMenu(),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'الأعياد السيدية'),
              Tab(text: 'أصوام الكنيسة'),
              Tab(text: 'أعياد القديسين'),
            ],
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: FutureBuilder<List<FeastsAndFast>>(
            future: _feastsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingView(message: 'جاري تحميل الأعياد والأصوام...');
              }

              if (snapshot.hasError) {
                return ErrorView(
                  message: 'حدث خطأ أثناء تحميل الأعياد والأصوام',
                  onRetry: () => setState(() {
                    _feastsFuture = DatabaseService.instance.feastsDao.getAllFeastsAndFasts();
                  }),
                );
              }

              final allItems = snapshot.data ?? [];
              if (allItems.isEmpty) {
                return const EmptyView(
                  message: 'لا توجد أعياد أو أصوام مسجلة',
                  icon: Icons.celebration_rounded,
                );
              }
              final majorFeasts = allItems.where((f) => f.type == 'major_feast').toList();
              final minorFeasts = allItems.where((f) => f.type == 'minor_feast').toList();
              final fasts = allItems.where((f) => f.type == 'fast').toList();

              // Separate Lord's minor feasts from general saints feasts
              final lordsMinorIds = {
                'circumcision',
                'wedding_cana',
                'presentation_temple',
                'entry_to_egypt',
                'transfiguration',
                'covenant_thursday_feast',
                'thomas_sunday',
              };

              final lordsMinor = minorFeasts.where((f) => lordsMinorIds.contains(f.id)).toList();
              final saintsFeasts = minorFeasts.where((f) => !lordsMinorIds.contains(f.id)).toList();

              return TabBarView(
                children: [
                  _buildLordFeastsTab(majorFeasts, lordsMinor),
                  _buildFastsTab(fasts),
                  _buildSaintsFeastsTab(saintsFeasts),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLordFeastsTab(List<FeastsAndFast> major, List<FeastsAndFast> minor) {
    final totalCount = 2 + major.length + minor.length;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: totalCount,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                const Icon(Icons.star_rounded, color: AppColors.festive, size: 22),
                const SizedBox(width: 8),
                Text(
                  'الأعياد السيدية الكبرى (${major.length} أعياد)',
                  style: AppTypography.heading3.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          );
        }
        if (index <= major.length) {
          final f = major[index - 1];
          return _buildFeastCard(f, AppColors.festive, Icons.star_rounded);
        }
        if (index == major.length + 1) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                const Icon(Icons.celebration_rounded, color: Color(0xFFE65100), size: 22),
                const SizedBox(width: 8),
                Text(
                  'الأعياد السيدية الصغرى (${minor.length} أعياد)',
                  style: AppTypography.heading3.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          );
        }
        final f = minor[index - major.length - 2];
        return _buildFeastCard(f, const Color(0xFFE65100), Icons.celebration_rounded);
      },
    );
  }

  Widget _buildFastsTab(List<FeastsAndFast> fasts) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: fasts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final f = fasts[index];
        final isStrict = f.rite == 'lenten';
        final badgeColor = isStrict ? AppColors.lenten : const Color(0xFF1565C0);

        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _showFeastDetails(f),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: badgeColor.withValues(alpha: 0.12),
                    child: Icon(Icons.local_dining_rounded, color: badgeColor, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                f.nameAr,
                                style: AppTypography.heading3.copyWith(fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: badgeColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                isStrict ? 'درجة أولى' : 'درجة ثانية',
                                style: TextStyle(fontSize: 11, color: badgeColor, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDate(f),
                          style: AppTypography.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          f.description,
                          style: AppTypography.caption,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_left_rounded, size: 20, color: AppColors.textSecondaryLight),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSaintsFeastsTab(List<FeastsAndFast> saintsFeasts) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: saintsFeasts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final f = saintsFeasts[index];
        return _buildFeastCard(f, AppColors.primary, Icons.auto_awesome_rounded);
      },
    );
  }

  Widget _buildFeastCard(FeastsAndFast f, Color accentColor, IconData icon) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showFeastDetails(f),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: accentColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      f.nameAr,
                      style: AppTypography.heading3.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(f),
                      style: AppTypography.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_left_rounded, size: 20, color: AppColors.textSecondaryLight),
            ],
          ),
        ),
      ),
    );
  }
}
