import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/prayer_tracker_service.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class PrayerTrackerScreen extends StatefulWidget {
  const PrayerTrackerScreen({super.key});

  @override
  State<PrayerTrackerScreen> createState() => _PrayerTrackerScreenState();
}

class _PrayerTrackerScreenState extends State<PrayerTrackerScreen> {
  DateTime _selectedDate = DateTime.now();
  List<String> _completedPrayers = [];
  int _currentStreak = 0;
  Map<DateTime, int> _weeklyStats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final completed = await PrayerTrackerService.getCompletedPrayersForDate(_selectedDate);
    final streak = await PrayerTrackerService.calculateStreak();
    final weekly = await PrayerTrackerService.getWeeklyStats();
    if (mounted) {
      setState(() {
        _completedPrayers = completed;
        _currentStreak = streak;
        _weeklyStats = weekly;
        _isLoading = false;
      });
    }
  }

  Future<void> _togglePrayer(String hourId) async {
    await PrayerTrackerService.togglePrayer(_selectedDate, hourId);
    await _loadData();
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    _loadData();
  }

  String _arabicDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'الاثنين';
      case DateTime.tuesday:
        return 'الثلاثاء';
      case DateTime.wednesday:
        return 'الأربعاء';
      case DateTime.thursday:
        return 'الخميس';
      case DateTime.friday:
        return 'الجمعة';
      case DateTime.saturday:
        return 'السبت';
      case DateTime.sunday:
        return 'الأحد';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalHours = PrayerTrackerService.canonicalHours.length;
    final completedCount = _completedPrayers.length;
    final percent = totalHours > 0 ? (completedCount / totalHours) : 0.0;
    const accentGold = Color(0xFFD4AF37);

    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الصلاة اليومي (الأجبية)'),
        actions: [
          IconButton(
            tooltip: 'الانتقال إلى اليوم',
            icon: const Icon(Icons.today_rounded),
            onPressed: () => _selectDate(DateTime.now()),
          ),
          const AppQuickMenu(),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // بطاقة الـ Streak والتشجيع
                    _buildStreakCard(theme, accentGold),
                    const SizedBox(height: 16),

                    // شريط الأيام السبعة الأخير
                    _buildWeeklyBar(theme, accentGold),
                    const SizedBox(height: 16),

                    // بطاقة نسبة إنجاز صلوات اليوم المختار
                    _buildDailySummaryCard(theme, accentGold, completedCount, totalHours, percent),
                    const SizedBox(height: 16),

                    // عنوان قائمة السواعي
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'صلوات السواعي القانونية',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$completedCount من $totalHours صلوات',
                          style: TextStyle(
                            fontSize: 13,
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // قائمة السواعي السبع
                    ...PrayerTrackerService.canonicalHours.map((hour) {
                      final isDone = _completedPrayers.contains(hour.id);
                      return _buildHourCard(hour, isDone, theme, accentGold);
                    }),
                    const SizedBox(height: 20),

                    // تأمل آبائي في الصلاة
                    _buildFatherQuoteCard(theme, accentGold),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildStreakCard(ThemeData theme, Color accentGold) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accentGold.withValues(alpha: 0.18),
            accentGold.withValues(alpha: 0.05),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentGold.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentGold.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.local_fire_department_rounded,
              color: Color(0xFFE65100),
              size: 32,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _currentStreak > 0
                      ? '$_currentStreak أيام صلاة متواصلة'
                      : 'ابدأ سلسلتك المباركة اليوم',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _currentStreak > 0
                      ? '«صلوا كل حين ولا تملوا» — واظب على رفع قلبك أمام الله كل يوم.'
                      : 'صلِّ صلاة واحدة على الأقل في اليوم لتحافظ على استمرارية رفع قلبك.',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyBar(ThemeData theme, Color accentGold) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Text(
              'الأسبوع الأخير',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _weeklyStats.entries.map((entry) {
              final d = entry.key;
              final count = entry.value;
              final isToday = d.year == today.year && d.month == today.month && d.day == today.day;
              final isSelected = d.year == _selectedDate.year &&
                  d.month == _selectedDate.month &&
                  d.day == _selectedDate.day;

              return GestureDetector(
                onTap: () => _selectDate(d),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? accentGold.withValues(alpha: 0.2)
                        : (isToday ? accentGold.withValues(alpha: 0.08) : Colors.transparent),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? accentGold
                          : (isToday ? accentGold.withValues(alpha: 0.5) : Colors.transparent),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _arabicDayName(d.weekday).substring(0, 3),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? accentGold : theme.textTheme.bodySmall?.color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${d.day}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? accentGold : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: count >= 7
                              ? Colors.green
                              : (count > 0 ? accentGold : Colors.grey.withValues(alpha: 0.3)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDailySummaryCard(
    ThemeData theme,
    Color accentGold,
    int completed,
    int total,
    double percent,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 54,
            height: 54,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: percent,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    percent == 1.0 ? Colors.green : accentGold,
                  ),
                ),
                Center(
                  child: Text(
                    '${(percent * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تاريخ: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  percent == 1.0
                      ? 'مبارك! أتممت صلوات السواعي السبع كاملة اليوم.'
                      : 'أتممت $completed من أصل $total صلوات. استكمل صلواتك الباقية.',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourCard(
    AgpeyaHourInfo hour,
    bool isDone,
    ThemeData theme,
    Color accentGold,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isDone ? accentGold.withValues(alpha: 0.06) : theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDone ? accentGold.withValues(alpha: 0.4) : Colors.grey.withValues(alpha: 0.18),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: Checkbox(
          value: isDone,
          activeColor: accentGold,
          checkColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onChanged: (_) => _togglePrayer(hour.id),
        ),
        title: Row(
          children: [
            Text(
              hour.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                decoration: isDone ? TextDecoration.lineThrough : null,
                color: isDone ? accentGold : null,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                hour.idealTime,
                style: TextStyle(
                  fontSize: 11,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            hour.memorial,
            style: TextStyle(
              fontSize: 12,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
          tooltip: 'فتح الصلاة في الأجبية',
          onPressed: () => context.push('/agpeya/hour/${hour.id}'),
        ),
      ),
    );
  }

  Widget _buildFatherQuoteCard(ThemeData theme, Color accentGold) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.format_quote_rounded, color: accentGold, size: 20),
              const SizedBox(width: 6),
              Text(
                'من أقوال الآباء في الصلاة',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: accentGold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            '«الصلاة هي حراسة العقل، وحصن الجسد، وسور الروح. حين تصلي بمزامير الأجبية فإنك تتحدث بكلمات الروح القدس نفسه.»',
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '— مار إسحق السرياني',
              style: TextStyle(
                fontSize: 11,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
