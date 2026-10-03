import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/reading_plans_data.dart';
import '../models/reading_plan.dart';
import '../services/reading_plan_service.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class ReadingPlanScreen extends StatefulWidget {
  const ReadingPlanScreen({super.key});

  @override
  State<ReadingPlanScreen> createState() => _ReadingPlanScreenState();
}

class _ReadingPlanScreenState extends State<ReadingPlanScreen> {
  String _activePlanId = 'plan_whole_bible_365';
  int _currentDay = 1;
  List<int> _completedDays = [];
  bool _isLoading = true;

  BibleReadingPlan get _activePlan => ReadingPlansData.plans.firstWhere(
        (p) => p.id == _activePlanId,
        orElse: () => ReadingPlansData.plans.first,
      );

  PlanDay get _dayData => ReadingPlansData.getPlanDay(_activePlanId, _currentDay);

  @override
  void initState() {
    super.initState();
    _loadPlanData();
  }

  Future<void> _loadPlanData() async {
    setState(() => _isLoading = true);
    final planId = await ReadingPlanService.getActivePlanId();
    final completed = await ReadingPlanService.getCompletedDays(planId);
    final suggested = await ReadingPlanService.getSuggestedDay(planId);

    if (mounted) {
      setState(() {
        _activePlanId = planId;
        _completedDays = completed;
        _currentDay = suggested;
        _isLoading = false;
      });
    }
  }

  Future<void> _switchPlan(String newPlanId) async {
    await ReadingPlanService.setActivePlanId(newPlanId);
    final completed = await ReadingPlanService.getCompletedDays(newPlanId);
    final suggested = await ReadingPlanService.getSuggestedDay(newPlanId);
    if (mounted) {
      setState(() {
        _activePlanId = newPlanId;
        _completedDays = completed;
        _currentDay = suggested;
      });
    }
  }

  Future<void> _toggleCurrentDay() async {
    await ReadingPlanService.toggleDayCompleted(_activePlanId, _currentDay);
    final completed = await ReadingPlanService.getCompletedDays(_activePlanId);
    if (mounted) {
      setState(() {
        _completedDays = completed;
      });
    }
  }

  void _nextDay() {
    if (_currentDay < _activePlan.totalDays) {
      setState(() => _currentDay++);
    }
  }

  void _prevDay() {
    if (_currentDay > 1) {
      setState(() => _currentDay--);
    }
  }

  void _showJumpToDayDialog() {
    int target = _currentDay;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('انتقال إلى يوم محدد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('اختر اليوم من 1 إلى ${_activePlan.totalDays}:'),
            const SizedBox(height: 12),
            TextField(
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'اليوم الحالي: $_currentDay',
                border: const OutlineInputBorder(),
              ),
              onChanged: (val) {
                final num = int.tryParse(val);
                if (num != null) target = num;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              if (target >= 1 && target <= _activePlan.totalDays) {
                setState(() => _currentDay = target);
              }
            },
            child: const Text('انتقال'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const accentGold = Color(0xFFD4AF37);
    final isDone = _completedDays.contains(_currentDay);
    final progress = _activePlan.totalDays > 0 ? (_completedDays.length / _activePlan.totalDays) : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('خطة قراءة الكتاب المقدس'),
        actions: [
          IconButton(
            tooltip: 'الانتقال إلى يوم محدد',
            icon: const Icon(Icons.pin_rounded),
            onPressed: _showJumpToDayDialog,
          ),
          PopupMenuButton<String>(
            tooltip: 'اختيار خطة أخرى',
            icon: const Icon(Icons.swap_horiz_rounded),
            onSelected: _switchPlan,
            itemBuilder: (ctx) => ReadingPlansData.plans.map((p) {
              final isCurrent = p.id == _activePlanId;
              return PopupMenuItem(
                value: p.id,
                child: Row(
                  children: [
                    if (isCurrent)
                      const Icon(Icons.check, color: accentGold, size: 18)
                    else
                      const SizedBox(width: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        p.title,
                        style: TextStyle(
                          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                          color: isCurrent ? accentGold : null,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const AppQuickMenu(),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadPlanData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // بطاقة اختيار الخطة الحالية ونسبة التقدم الإجمالية
                    _buildProgressCard(theme, accentGold, progress),
                    const SizedBox(height: 16),

                    // محدد اليوم مع أزرار التنقل
                    _buildDayNavigator(theme, accentGold, isDone),
                    const SizedBox(height: 16),

                    // عنوان قراءات اليوم
                    Text(
                      _dayData.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // بطاقات الأصحاحات المقرر قراءتها اليوم
                    ..._dayData.readings.map((item) => _buildReadingCard(item, theme, accentGold)),
                    const SizedBox(height: 16),

                    // زر إتمام قراءة اليوم
                    _buildCompletionButton(isDone, accentGold),
                    const SizedBox(height: 24),

                    // آية تشجيعية لقراءة كلمة الله
                    _buildScriptureQuote(theme, accentGold),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildProgressCard(ThemeData theme, Color accentGold, double progress) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentGold.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_stories_rounded, color: accentGold, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _activePlan.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _activePlan.subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: accentGold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD4AF37),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.withValues(alpha: 0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'أتممت ${_completedDays.length} من أصل ${_activePlan.totalDays} يوماً',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                'متبقي: ${_activePlan.totalDays - _completedDays.length} يوماً',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayNavigator(ThemeData theme, Color accentGold, bool isDone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_right_rounded),
            tooltip: 'اليوم السابق',
            onPressed: _currentDay > 1 ? _prevDay : null,
          ),
          Column(
            children: [
              Text(
                'اليوم $_currentDay من ${_activePlan.totalDays}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isDone)
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_rounded, color: Colors.green, size: 14),
                    SizedBox(width: 4),
                    Text(
                      'مكتمل القراءة',
                      style: TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.chevron_left_rounded),
            tooltip: 'اليوم التالي',
            onPressed: _currentDay < _activePlan.totalDays ? _nextDay : null,
          ),
        ],
      ),
    );
  }

  Widget _buildReadingCard(PlanReadingItem item, ThemeData theme, Color accentGold) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentGold.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.menu_book_rounded, color: Color(0xFFD4AF37), size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.bookName} — الأصحاح ${item.chapter}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (item.notes != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    item.notes!,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: accentGold,
              foregroundColor: Colors.black,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            icon: const Icon(Icons.open_in_new_rounded, size: 16),
            label: const Text('اقرأ الآن'),
            onPressed: () {
              context.push('/bible/read/${item.bookId}/${item.chapter}');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionButton(bool isDone, Color accentGold) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: isDone ? Colors.green.shade700 : accentGold,
        foregroundColor: isDone ? Colors.white : Colors.black,
        elevation: 1,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(isDone ? Icons.check_circle_rounded : Icons.check_rounded),
      label: Text(
        isDone ? 'أتممت قراءة اليوم بنعمة ربنا (اضغط للإلغاء)' : 'وضع علامة إتمام قراءة اليوم',
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      onPressed: _toggleCurrentDay,
    );
  }

  Widget _buildScriptureQuote(ThemeData theme, Color accentGold) {
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
                'بركة كلمة الله',
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
            '«سِرَاجٌ لِرِجْلِي كَلاَمُكَ وَنُورٌ لِسَبِيلِي» (مزمور 119: 105)',
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
