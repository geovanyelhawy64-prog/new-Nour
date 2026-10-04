import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/providers/simple_mode_provider.dart';
import '../../../core/coptic_calendar/coptic_date.dart';

class SimpleHomeScreen extends ConsumerWidget {
  const SimpleHomeScreen({super.key});

  int _getCurrentHourId() {
    final now = DateTime.now();
    final hour = now.hour;

    // 04:00 - 08:59 -> باكر (1)
    // 09:00 - 11:59 -> الثالثة (2)
    // 12:00 - 14:59 -> السادسة (3)
    // 15:00 - 17:29 -> التاسعة (4)
    // 17:30 - 20:59 -> الغروب (5)
    // 21:00 - 23:59 -> النوم (6)
    // 00:00 - 03:59 -> نصف الليل (7)
    if (hour >= 4 && hour < 9) return 1;
    if (hour >= 9 && hour < 12) return 2;
    if (hour >= 12 && hour < 15) return 3;
    if (hour >= 15 && hour < 18) return 4;
    if (hour >= 18 && hour < 21) return 5;
    if (hour >= 21 || hour < 0) return 6;
    return 7; // نصف الليل
  }

  String _getCurrentHourName(int id) {
    switch (id) {
      case 1:
        return 'صلاة باكر';
      case 2:
        return 'صلاة الساعة الثالثة';
      case 3:
        return 'صلاة الساعة السادسة';
      case 4:
        return 'صلاة الساعة التاسعة';
      case 5:
        return 'صلاة الغروب';
      case 6:
        return 'صلاة النوم';
      case 7:
        return 'صلاة نصف الليل';
      default:
        return 'صلاة باكر';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentHourId = _getCurrentHourId();
    final currentHourName = _getCurrentHourName(currentHourId);

    // Coptic Date
    final copticDate = CopticDate.fromDate(DateTime.now());

    final goldColor = isDark
        ? const Color(0xFFD4A843)
        : const Color(0xFF9E782F);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'نور — الوضع المبسط',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            icon: const Icon(Icons.swap_horiz, size: 26),
            label: const Text(
              'الوضع العادي',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              await ref.read(simpleModeProvider.notifier).setSimpleMode(false);
              if (context.mounted) {
                context.go('/');
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // Date Banner
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: goldColor.withValues(alpha: 0.4), width: 1.5),
              ),
              child: Column(
                children: [
                  Text(
                    'اليوم: ${copticDate.day} ${copticDate.monthNameAr} (${copticDate.year} ش)',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: goldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Card 1: صلاة الساعة الحالية (أكبر بطاقة وأهم بطاقة)
            _SimpleActionCard(
              title: currentHourName,
              subtitle: 'صلاة الوقت الحالي في الأجبية',
              icon: Icons.access_time_filled,
              color: const Color(0xFFB8860B),
              isHero: true,
              onTap: () => context.push('/agpeya/hour/$currentHourId'),
            ),
            const SizedBox(height: 12),

            // Card 2: إنجيل اليوم
            _SimpleActionCard(
              title: 'إنجيل اليوم',
              subtitle: 'قراءة إنجيل قداس اليوم من القطمارس',
              icon: Icons.menu_book_rounded,
              color: const Color(0xFF2E7D32),
              onTap: () => context.push('/katameros'),
            ),
            const SizedBox(height: 12),

            // Card 3: سنكسار اليوم
            _SimpleActionCard(
              title: 'سنكسار اليوم',
              subtitle: 'تذكارات وسير قديسي هذا اليوم',
              icon: Icons.auto_stories,
              color: const Color(0xFF6A1B9A),
              onTap: () => context.push('/synaxarium'),
            ),
            const SizedBox(height: 12),

            // Card 4: جميع صلوات الأجبية
            _SimpleActionCard(
              title: 'الأجبية (جميع الصلوات)',
              subtitle: 'صلوات السواعي السبع كاملة',
              icon: Icons.front_hand,
              color: const Color(0xFF1565C0),
              onTap: () => context.push('/agpeya'),
            ),
            const SizedBox(height: 12),

            // Card 5: القداس الإلهي
            _SimpleActionCard(
              title: 'القداس الإلهي',
              subtitle: 'الخولاجي المقدس (الباسيلي والغريغوري والكيرلسي)',
              icon: Icons.church,
              color: const Color(0xFFC2185B),
              onTap: () => context.push('/liturgy'),
            ),
            const SizedBox(height: 12),

            // Card 6: الكتاب المقدس
            _SimpleActionCard(
              title: 'الكتاب المقدس',
              subtitle: 'العهدان القديم والجديد والأسفار القانونية',
              icon: Icons.book,
              color: const Color(0xFFD84315),
              onTap: () => context.push('/bible'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _SimpleActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isHero;
  final VoidCallback onTap;

  const _SimpleActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.isHero = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: isHero ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: isHero ? color : color.withValues(alpha: 0.3),
          width: isHero ? 2.5 : 1.2,
        ),
      ),
      color: isHero
          ? (isDark ? color.withValues(alpha: 0.2) : color.withValues(alpha: 0.08))
          : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 18,
            vertical: isHero ? 22 : 18,
          ),
          child: Row(
            children: [
              Container(
                width: isHero ? 60 : 52,
                height: isHero ? 60 : 52,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: isDark ? 0.25 : 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: isHero ? 34 : 28,
                  color: isDark ? color.withValues(alpha: 0.9) : color,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: isHero ? 23 : 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.grey[400] : Colors.grey[700],
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_back_ios_new,
                size: 22,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
