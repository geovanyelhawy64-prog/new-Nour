import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/coptic_calendar/coptic_date.dart';
import '../../providers/home_providers.dart';

class SmartDailyLiturgyCard extends ConsumerWidget {
  final CopticDate copticDate;

  const SmartDailyLiturgyCard({
    super.key,
    required this.copticDate,
  });

  String _getCurrentHourName() {
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 9) return 'صلاة باكر';
    if (hour >= 9 && hour < 12) return 'صلاة الساعة الثالثة';
    if (hour >= 12 && hour < 15) return 'صلاة الساعة السادسة';
    if (hour >= 15 && hour < 18) return 'صلاة الساعة التاسعة';
    if (hour >= 18 && hour < 21) return 'صلاة الغروب';
    if (hour >= 21 || hour < 0) return 'صلاة النوم';
    return 'صلاة نصف الليل';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const accentGold = Color(0xFFC49B3C);
    final hourName = _getCurrentHourName();

    final readingsAsync = ref.watch(todayLiturgicalReadingsProvider);
    final synaxariumAsync = ref.watch(todaySynaxariumProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1E2638), const Color(0xFF141821)]
              : [const Color(0xFFFFFFFF), const Color(0xFFFAF6F0)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: accentGold.withValues(alpha: isDark ? 0.45 : 0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: accentGold.withValues(alpha: isDark ? 0.18 : 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            HapticFeedback.lightImpact();
            context.push('/today-liturgy');
          },
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان والشارة
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            accentGold,
                            accentGold.withValues(alpha: 0.75),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: accentGold.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.auto_stories_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'صلاتي وقراءاتي اليوم',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          Text(
                            'المنجلية اليومية التلقائية المتكاملة',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? const Color(0xFFAFA799) : const Color(0xFF6B655B),
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: accentGold.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: accentGold.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bolt_rounded, size: 14, color: accentGold),
                          const SizedBox(width: 4),
                          const Text(
                            'تجميع ذكي',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: accentGold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // بطاقات سريعة لملخص اليوم
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF151C2A) : const Color(0xFFF4EFE6),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      // 1. صلاة الساعة الحالية
                      Row(
                        children: [
                          const Icon(Icons.access_time_filled_rounded, size: 16, color: accentGold),
                          const SizedBox(width: 8),
                          Text(
                            'صلاة الساعة المقترحة الآن:',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: isDark ? Colors.white70 : Colors.black54,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            hourName,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: accentGold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // 2. إنجيل اليوم
                      readingsAsync.when(
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                        data: (readings) {
                          final gospel = readings.where((r) => r.readingType.contains('إنجيل')).firstOrNull;
                          if (gospel == null) return const SizedBox.shrink();
                          return Row(
                            children: [
                              const Icon(Icons.menu_book_rounded, size: 16, color: accentGold),
                              const SizedBox(width: 8),
                              Text(
                                'إنجيل القداس:',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: isDark ? Colors.white70 : Colors.black54,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  gospel.reference,
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : Colors.black87,
                                    fontFamily: 'Cairo',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 8),

                      // 3. سنكسار اليوم
                      synaxariumAsync.when(
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                        data: (entries) {
                          if (entries.isEmpty) return const SizedBox.shrink();
                          return Row(
                            children: [
                              const Icon(Icons.star_rounded, size: 16, color: accentGold),
                              const SizedBox(width: 8),
                              Text(
                                'تذكار السنكسار:',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: isDark ? Colors.white70 : Colors.black54,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  entries.first.title,
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : Colors.black87,
                                    fontFamily: 'Cairo',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // زر الإجراء الرئيسي العريض والواضح
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentGold,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      context.push('/today-liturgy');
                    },
                    icon: const Icon(Icons.play_arrow_rounded, size: 22, color: Colors.black),
                    label: const Text(
                      'ابدأ صلوات وقراءات اليوم كاملة',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
