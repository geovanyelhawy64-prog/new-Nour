import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

class AgpeyaQuickBarWidget extends StatelessWidget {
  const AgpeyaQuickBarWidget({super.key});

  static const _hours = [
    {'id': 'prime', 'name': 'باكر', 'icon': Icons.wb_sunny_outlined},
    {'id': 'terce', 'name': 'الثالثة', 'icon': Icons.access_time_rounded},
    {'id': 'sext', 'name': 'السادسة', 'icon': Icons.wb_twilight_rounded},
    {'id': 'none', 'name': 'التاسعة', 'icon': Icons.alarm_rounded},
    {'id': 'vespers', 'name': 'الغروب', 'icon': Icons.nights_stay_outlined},
    {'id': 'compline', 'name': 'النوم', 'icon': Icons.bedtime_outlined},
    {'id': 'midnight', 'name': 'نصف الليل', 'icon': Icons.dark_mode_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              const Text(
                'الصلوات اليومية',
                style: AppTypography.heading3,
              ),
              const Spacer(),
              TextButton(
                onPressed: () => context.push('/agpeya'),
                child: const Text('الصلوات'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: _hours.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final h = _hours[index];
              return InkWell(
                onTap: () => context.push('/agpeya/hour/${h['id']}'),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 72,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.surfaceDark
                        : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.divider.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        h['icon'] as IconData,
                        size: 22,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        h['name'] as String,
                        style: AppTypography.caption.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
