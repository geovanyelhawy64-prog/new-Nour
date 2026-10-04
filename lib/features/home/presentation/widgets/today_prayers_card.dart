import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../prayer_tracker/services/prayer_tracker_service.dart';

class TodayPrayersCard extends StatefulWidget {
  const TodayPrayersCard({super.key});

  @override
  State<TodayPrayersCard> createState() => _TodayPrayersCardState();
}

class _TodayPrayersCardState extends State<TodayPrayersCard> {
  List<String> _completedPrayers = [];

  static const List<Map<String, dynamic>> _hours = [
    {
      'id': 'prime',
      'name': 'باكر',
      'title': 'صلاة باكر',
      'time': '6:00 ص',
      'icon': Icons.wb_sunny_rounded,
      'hourMin': 4,
      'hourMax': 9,
    },
    {
      'id': 'terce',
      'name': 'الثالثة',
      'title': 'الساعة الثالثة',
      'time': '9:00 ص',
      'icon': Icons.schedule_rounded,
      'hourMin': 9,
      'hourMax': 12,
    },
    {
      'id': 'sext',
      'name': 'السادسة',
      'title': 'الساعة السادسة',
      'time': '12:00 م',
      'icon': Icons.wb_sunny_outlined,
      'hourMin': 12,
      'hourMax': 15,
    },
    {
      'id': 'none',
      'name': 'التاسعة',
      'title': 'الساعة التاسعة',
      'time': '3:00 م',
      'icon': Icons.alarm_rounded,
      'hourMin': 15,
      'hourMax': 17,
    },
    {
      'id': 'vespers',
      'name': 'الحادية عشر',
      'title': 'صلاة الغروب',
      'time': '5:00 م',
      'icon': Icons.wb_twilight_rounded,
      'hourMin': 17,
      'hourMax': 21,
    },
    {
      'id': 'compline',
      'name': 'النوم',
      'title': 'صلاة النوم',
      'time': '9:00 م',
      'icon': Icons.bedtime_rounded,
      'hourMin': 21,
      'hourMax': 24,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadPrayerState();
  }

  Future<void> _loadPrayerState() async {
    final completed = await PrayerTrackerService.getCompletedPrayersForDate(DateTime.now());
    if (mounted) {
      setState(() {
        _completedPrayers = completed;
      });
    }
  }

  Future<void> _togglePrayer(String hourId) async {
    HapticFeedback.mediumImpact();
    await PrayerTrackerService.togglePrayer(DateTime.now(), hourId);
    await _loadPrayerState();
  }

  /// هل هذه الصلاة هي الصلاة الحالية للوقت الراهن؟
  bool _isCurrentHour(Map<String, dynamic> hour) {
    final nowHour = DateTime.now().hour;
    final min = hour['hourMin'] as int;
    final max = hour['hourMax'] as int;

    if (hour['id'] == 'compline') {
      return (nowHour >= 21 || nowHour < 4);
    }
    return nowHour >= min && nowHour < max;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const accentGold = Color(0xFFD4AF37);
    final completedCount = _completedPrayers.where((id) => _hours.any((h) => h['id'] == id)).length;

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
                  color: const Color(0xFF6A1B9A).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.access_time_filled_rounded,
                  color: Color(0xFF6A1B9A),
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'الصلوات اليومية',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'أتممت $completedCount من ٦ صلوات اليوم',
                      style: TextStyle(
                        fontSize: 11,
                        color: completedCount > 0 ? Colors.green : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  context.push('/agpeya');
                },
                child: const Text('الصلوات'),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // شبكة الصلوات مع علامة "أنت هنا" وحالة الإتمام
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _hours.map((hour) {
                  final id = hour['id'] as String;
                  final isDone = _completedPrayers.contains(id);
                  final isCurrent = _isCurrentHour(hour);

                  final itemWidth = (constraints.maxWidth - 8) / 2;

                  return SizedBox(
                    width: itemWidth,
                    child: _buildPrayerCard(
                      context: context,
                      hour: hour,
                      isDone: isDone,
                      isCurrent: isCurrent,
                      isDark: isDark,
                      accentGold: accentGold,
                    ),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 12),
          // زر الانتقال المباشر للأجبية الكاملة
          InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              context.push('/agpeya');
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF6A1B9A).withValues(alpha: isDark ? 0.2 : 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF6A1B9A).withValues(alpha: 0.3),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book_rounded, size: 16, color: Color(0xFF9C27B0)),
                  SizedBox(width: 8),
                  Text(
                    'فتح كتاب الصلوات بجميع سواعية',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9C27B0),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_left_rounded, size: 16, color: Color(0xFF9C27B0)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerCard({
    required BuildContext context,
    required Map<String, dynamic> hour,
    required bool isDone,
    required bool isCurrent,
    required bool isDark,
    required Color accentGold,
  }) {
    final id = hour['id'] as String;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          context.push('/agpeya/hour/$id');
        },
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isCurrent
                ? accentGold.withValues(alpha: isDark ? 0.16 : 0.08)
                : (isDark ? const Color(0xFF141414) : const Color(0xFFF9F9F9)),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isCurrent
                  ? accentGold
                  : (isDone
                      ? Colors.green.withValues(alpha: 0.4)
                      : (isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06))),
              width: isCurrent ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // مؤشر "أنت هنا" عند صلاة الساعة الحالية
              if (isCurrent) ...[
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: accentGold,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.location_on_rounded, size: 10, color: Colors.black),
                          SizedBox(width: 2),
                          Text(
                            'أنت هنا',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      hour['time'] as String,
                      style: TextStyle(fontSize: 10, color: accentGold, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              ] else ...[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    hour['time'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: isDark ? Colors.white38 : Colors.grey[500],
                    ),
                  ),
                ),
              ],

              // اسم الصلاة وزر التبديل
              Row(
                children: [
                  Icon(
                    hour['icon'] as IconData,
                    size: 18,
                    color: isCurrent ? accentGold : (isDone ? Colors.green : AppColors.primary),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      hour['name'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isCurrent
                            ? accentGold
                            : (isDark ? Colors.white : Colors.black87),
                      ),
                    ),
                  ),
                  // زر تبديل حالة الصلاة (Check box)
                  GestureDetector(
                    onTap: () => _togglePrayer(id),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isDone
                            ? Colors.green.withValues(alpha: 0.15)
                            : (isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDone ? Colors.green : Colors.grey.withValues(alpha: 0.4),
                          width: 1.2,
                        ),
                      ),
                      child: Icon(
                        isDone ? Icons.check_rounded : Icons.circle_outlined,
                        size: 14,
                        color: isDone ? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // حالة الصلاة
              Text(
                isDone ? 'تمت الصلاة ✓' : 'لم تصلي بعد',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: isDone
                      ? Colors.green
                      : (isDark ? Colors.white38 : Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
