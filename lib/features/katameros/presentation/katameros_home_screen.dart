import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/coptic_calendar/coptic_calendar_engine.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class KatamerosHomeScreen extends StatelessWidget {
  const KatamerosHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todayLiturgical = CopticCalendarEngine.getLiturgicalDayInfo(DateTime.now());

    final sections = [
      _KatamerosSection(
        id: 'today',
        title: 'قراءات اليوم الحالية',
        subtitle: '${todayLiturgical.copticDate.formatArabic()} - ${todayLiturgical.seasonName}',
        icon: Icons.today_rounded,
        color: AppColors.primary,
        isHighlighted: true,
      ),
      const _KatamerosSection(
        id: 'sundays',
        title: 'قطمارس الآحاد',
        subtitle: 'قراءات آحاد السنة التوتية على مدار شهور السنة القبطية',
        icon: Icons.church_rounded,
        color: Color(0xFFE65100),
      ),
      const _KatamerosSection(
        id: 'annual_days',
        title: 'قطمارس الأيام السنوي',
        subtitle: 'قراءات أيام الأسبوع من الاثنين إلى السبت',
        icon: Icons.calendar_view_week_rounded,
        color: Color(0xFF2E7D32),
      ),
      const _KatamerosSection(
        id: 'great_lent',
        title: 'قطمارس الصوم الكبير',
        subtitle: 'قراءات أسابيع الصوم المقدس من أسبوع الاستعداد إلى أسبوع الآلام',
        icon: Icons.wb_twilight_rounded,
        color: Color(0xFF6A1B9A),
      ),
      const _KatamerosSection(
        id: 'holy_fifty',
        title: 'قطمارس الخماسين المقدسة',
        subtitle: 'قراءات أيام وآحاد فترة القيامة المجيدة السبعين يوماً',
        icon: Icons.wb_sunny_rounded,
        color: Color(0xFFFFA000),
      ),
      const _KatamerosSection(
        id: 'pascha',
        title: 'قطمارس البصخة المقدسة',
        subtitle: 'نبوات وأناجيل ومزامير سواعي البصخة نهاراً وليلاً',
        icon: Icons.dark_mode_rounded,
        color: Color(0xFF212121),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('القراءات (القطمارس الكنسي)'),
        actions: const [
          AppQuickMenu(),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final s = sections[index];
          return Card(
            elevation: s.isHighlighted ? 2 : 1,
            color: s.isHighlighted ? AppColors.primary.withValues(alpha: 0.05) : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: s.isHighlighted
                  ? const BorderSide(color: AppColors.primary, width: 1.5)
                  : BorderSide.none,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => context.push('/katameros/read/${s.id}'),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: s.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(s.icon, color: s.color, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.title, style: AppTypography.heading3.copyWith(fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(s.subtitle, style: AppTypography.caption, maxLines: 2),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textSecondaryLight),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _KatamerosSection {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isHighlighted;

  const _KatamerosSection({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.isHighlighted = false,
  });
}
