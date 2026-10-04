import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/noor_app_bar.dart';
import '../providers/psali_providers.dart';

class PsaliHomeScreen extends ConsumerWidget {
  const PsaliHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final countAsync = ref.watch(psaliCountProvider);

    return Scaffold(
      appBar: const NoorAppBar(title: 'التسبحة'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // العنوان والعدد
          countAsync.when(
            data: (count) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                '$count نص تسبيحي',
                style: theme.textTheme.bodySmall,
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // الهوسات الأربع
          _buildSectionCard(
            context,
            theme,
            isDark,
            icon: Icons.looks_4,
            title: 'الهوسات الأربع',
            subtitle: 'تسابيح موسى ودانيال والثلاثة فتية',
            color: const Color(0xFF8B2500),
            onTap: () => context.push('/psali/hos'),
          ),

          // التئوطوكيات السبع
          _buildSectionCard(
            context,
            theme,
            isDark,
            icon: Icons.calendar_view_week,
            title: 'التئوطوكيات السبع',
            subtitle: 'تئوطوكية لكل يوم في الأسبوع',
            color: const Color(0xFF1B4F72),
            onTap: () => context.push('/psali/theotokia'),
          ),

          // المديحات الكيهكية
          _buildSectionCard(
            context,
            theme,
            isDark,
            icon: Icons.star,
            title: 'المديحات الكيهكية',
            subtitle: 'مديحات شهر كيهك',
            color: const Color(0xFFC49B3C),
            onTap: () => context.push('/psali/kiahki'),
          ),

          // الإبصلمودية
          _buildSectionCard(
            context,
            theme,
            isDark,
            icon: Icons.menu_book,
            title: 'الإبصلمودية',
            subtitle: 'المزامير القبطية (آدام وواطس)',
            color: const Color(0xFF1E6B3A),
            onTap: () => context.push('/psali/psalmody'),
          ),

          // اللبش والطرح
          _buildSectionCard(
            context,
            theme,
            isDark,
            icon: Icons.auto_stories,
            title: 'اللبش والطرح',
            subtitle: 'تسابيح المناسبات والأعياد',
            color: const Color(0xFF5B2C6F),
            onTap: () => context.push('/psali/lobsh'),
          ),

          // الذوكصولوجيات
          _buildSectionCard(
            context,
            theme,
            isDark,
            icon: Icons.church,
            title: 'الذوكصولوجيات',
            subtitle: 'تمجيدات القديسين والمناسبات',
            color: const Color(0xFF8B4513),
            onTap: () => context.push('/psali/doxology'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context,
    ThemeData theme,
    bool isDark, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isDark ? 0 : 1,
      color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark
              ? const Color(0xFF2A3040)
              : const Color(0xFFE8E0D4),
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: isDark ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? const Color(0xFF9B9484)
                            : const Color(0xFF6B6B6B),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_left,
                color: isDark
                    ? const Color(0xFF9B9484)
                    : const Color(0xFF6B6B6B),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
