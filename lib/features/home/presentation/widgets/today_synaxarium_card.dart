import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/coptic_calendar/coptic_date.dart';
import '../../providers/home_providers.dart';

class TodaySynaxariumCard extends ConsumerWidget {
  final CopticDate copticDate;

  const TodaySynaxariumCard({
    super.key,
    required this.copticDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const accentGold = Color(0xFFD4AF37);
    final synaxAsync = ref.watch(todaySynaxariumProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1B1B1B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // رأس البطاقة
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF00695C).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.history_edu_rounded,
                  color: Color(0xFF00695C),
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'تذكارات اليوم (السنكسار)',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  context.push('/synaxarium/story/${copticDate.month}/${copticDate.day}');
                },
                child: const Text('عرض الكل'),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // محتوى السنكسار
          synaxAsync.when(
            data: (entries) {
              if (entries.isEmpty) {
                return InkWell(
                  onTap: () => context.push('/synaxarium'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'تذكارات ${copticDate.day} ${copticDate.monthName} المبارك',
                      style: AppTypography.bodySmall,
                    ),
                  ),
                );
              }

              final primaryEntry = entries.first;
              final otherCount = entries.length - 1;

              // تنظيف نص القصة واستخلاص نبذة سريعة
              final rawStory = primaryEntry.shortText.trim().isNotEmpty
                  ? primaryEntry.shortText
                  : primaryEntry.fullText;
              final cleanText = rawStory
                  .replaceAll(RegExp(r'\s+'), ' ')
                  .trim();
              final excerpt = cleanText.length > 160
                  ? '${cleanText.substring(0, 155)}...'
                  : cleanText;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.push('/synaxarium/story/${copticDate.month}/${copticDate.day}');
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF141414) : const Color(0xFFF9F9F9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 18,
                                color: accentGold,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  primaryEntry.title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? accentGold : AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            excerpt,
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.5,
                              color: isDark ? Colors.white70 : Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (otherCount > 0) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 13,
                          color: isDark ? Colors.white38 : Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'يوجد أيضاً $otherCount تذكارات مقدسة أخرى لهذا اليوم المبارك',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? Colors.white38 : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 10),
                  // زر قراءة السيرة كاملة
                  InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.push('/synaxarium/story/${copticDate.month}/${copticDate.day}');
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00695C).withValues(alpha: isDark ? 0.2 : 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF00695C).withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.history_edu_rounded, size: 16, color: Color(0xFF00897B)),
                          SizedBox(width: 8),
                          Text(
                            'عرض كافة تذكارات وسير قديسي اليوم',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00897B),
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.chevron_left_rounded, size: 16, color: Color(0xFF00897B)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            error: (_, __) => InkWell(
              onTap: () => context.push('/synaxarium'),
              child: const Text('اضغط لعرض التذكارات الكنسية'),
            ),
          ),
        ],
      ),
    );
  }
}
