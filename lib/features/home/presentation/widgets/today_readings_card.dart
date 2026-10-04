import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/coptic_calendar/coptic_date.dart';
import '../../../../data/database/app_database.dart';
import '../../providers/home_providers.dart';

class TodayReadingsCard extends ConsumerStatefulWidget {
  final CopticDate copticDate;

  const TodayReadingsCard({
    super.key,
    required this.copticDate,
  });

  @override
  ConsumerState<TodayReadingsCard> createState() => _TodayReadingsCardState();
}

class _TodayReadingsCardState extends ConsumerState<TodayReadingsCard> {
  int _selectedServiceIndex = 2; // 0: عشية, 1: باكر, 2: القداس (افتراضي)

  @override
  void initState() {
    super.initState();
    // تحديد الخدمة الافتراضية بحسب وقت اليوم الفعلي
    final hour = DateTime.now().hour;
    if (hour >= 17 && hour < 23) {
      _selectedServiceIndex = 0; // عشية
    } else if (hour >= 4 && hour < 10) {
      _selectedServiceIndex = 1; // باكر
    } else {
      _selectedServiceIndex = 2; // القداس
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const accentGold = Color(0xFFD4AF37);
    final readingsAsync = ref.watch(todayLiturgicalReadingsProvider);

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
          // عنوان البطاقة وزر عرض القطمارس
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.annualColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.auto_stories_rounded,
                  color: AppColors.annualColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'قراءات اليوم',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'عشية • باكر • القداس الإلهي',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: accentGold,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                icon: const Icon(Icons.menu_book_rounded, size: 16),
                label: const Text(
                  'عرض الكل',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  context.push('/katameros/read/today');
                },
              ),
            ],
          ),
          const SizedBox(height: 12),

          // شريط اختيار الخدمة الكنسية (عشية / باكر / القداس)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF141414) : Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _buildServiceTab(0, '🌙 عشية', isDark),
                _buildServiceTab(1, '🌅 باكر', isDark),
                _buildServiceTab(2, '⛪ القداس', isDark),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // محتوى القراءات المحددة بحسب الخدمة
          readingsAsync.when(
            data: (readings) {
              if (readings.isEmpty) {
                return _buildEmptyFallback(context);
              }
              return _buildServiceReadings(readings, context);
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            error: (_, __) => _buildEmptyFallback(context),
          ),

          const SizedBox(height: 10),
          // زر لقراءة النص الكامل في القطمارس
          InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              context.push('/katameros/read/today');
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: accentGold.withValues(alpha: isDark ? 0.15 : 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: accentGold.withValues(alpha: 0.3)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book_rounded, size: 16, color: accentGold),
                  SizedBox(width: 8),
                  Text(
                    'عرض القراءات الكنسية كاملة',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: accentGold,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_left_rounded, size: 16, color: accentGold),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceTab(int index, String label, bool isDark) {
    final isSelected = _selectedServiceIndex == index;
    const accentGold = Color(0xFFD4AF37);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() => _selectedServiceIndex = index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? const Color(0xFF2A2A2A) : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
            border: isSelected
                ? Border.all(color: accentGold.withValues(alpha: 0.5), width: 1)
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? accentGold
                    : (isDark ? Colors.white60 : Colors.grey[700]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceReadings(List<KatamerosReading> allReadings, BuildContext context) {
    if (_selectedServiceIndex == 0) {
      // عشية: مزمور، إنجيل
      final psalm = allReadings.firstWhere(
        (r) => r.serviceType == 'vespers' && r.readingType == 'psalm',
        orElse: () => _fallbackReading('vespers', 'psalm', 'مزمور العشية'),
      );
      final gospel = allReadings.firstWhere(
        (r) => r.serviceType == 'vespers' && r.readingType == 'gospel',
        orElse: () => _fallbackReading('vespers', 'gospel', 'إنجيل العشية'),
      );

      return Column(
        children: [
          _buildReadingItem(
            title: 'مزمور عشية',
            reference: psalm.reference,
            icon: Icons.music_note_rounded,
            onTap: () => context.push('/katameros/read/today'),
          ),
          const Divider(height: 12),
          _buildReadingItem(
            title: 'إنجيل عشية',
            reference: gospel.reference,
            icon: Icons.book_rounded,
            onTap: () => context.push('/katameros/read/today'),
          ),
        ],
      );
    } else if (_selectedServiceIndex == 1) {
      // باكر: مزمور، إنجيل
      final psalm = allReadings.firstWhere(
        (r) => r.serviceType == 'matins' && r.readingType == 'psalm',
        orElse: () => _fallbackReading('matins', 'psalm', 'مزمور باكر'),
      );
      final gospel = allReadings.firstWhere(
        (r) => r.serviceType == 'matins' && r.readingType == 'gospel',
        orElse: () => _fallbackReading('matins', 'gospel', 'إنجيل باكر'),
      );

      return Column(
        children: [
          _buildReadingItem(
            title: 'مزمور باكر',
            reference: psalm.reference,
            icon: Icons.music_note_rounded,
            onTap: () => context.push('/katameros/read/today'),
          ),
          const Divider(height: 12),
          _buildReadingItem(
            title: 'إنجيل باكر',
            reference: gospel.reference,
            icon: Icons.book_rounded,
            onTap: () => context.push('/katameros/read/today'),
          ),
        ],
      );
    } else {
      // القداس: بولس، كاثوليكون، إبركسيس، سنكسار، مزمور، إنجيل
      final pauline = allReadings.firstWhere(
        (r) => r.serviceType == 'liturgy' && r.readingType == 'pauline',
        orElse: () => _fallbackReading('liturgy', 'pauline', 'البولس'),
      );
      final catholic = allReadings.firstWhere(
        (r) => r.serviceType == 'liturgy' && r.readingType == 'catholic',
        orElse: () => _fallbackReading('liturgy', 'catholic', 'الكاثوليكون'),
      );
      final acts = allReadings.firstWhere(
        (r) => r.serviceType == 'liturgy' && r.readingType == 'acts',
        orElse: () => _fallbackReading('liturgy', 'acts', 'الإبركسيس'),
      );
      final psalm = allReadings.firstWhere(
        (r) => r.serviceType == 'liturgy' && r.readingType == 'psalm',
        orElse: () => _fallbackReading('liturgy', 'psalm', 'مزمور القداس'),
      );
      final gospel = allReadings.firstWhere(
        (r) => r.serviceType == 'liturgy' && r.readingType == 'gospel',
        orElse: () => _fallbackReading('liturgy', 'gospel', 'إنجيل القداس'),
      );

      return Column(
        children: [
          _buildReadingItem(
            title: 'البولس (رسالة بولس الرسول)',
            reference: pauline.reference,
            icon: Icons.mail_rounded,
            onTap: () => context.push('/katameros/read/today'),
          ),
          const Divider(height: 8),
          _buildReadingItem(
            title: 'الكاثوليكون (الرسائل الجامعة)',
            reference: catholic.reference,
            icon: Icons.mark_email_read_rounded,
            onTap: () => context.push('/katameros/read/today'),
          ),
          const Divider(height: 8),
          _buildReadingItem(
            title: 'الإبركسيس (سفر أعمال الرسل)',
            reference: acts.reference,
            icon: Icons.public_rounded,
            onTap: () => context.push('/katameros/read/today'),
          ),
          const Divider(height: 8),
          _buildReadingItem(
            title: 'التذكارات (تذكار اليوم)',
            reference: 'تذكارات قديسي اليوم في القداس',
            icon: Icons.history_edu_rounded,
            onTap: () => context.push('/synaxarium/story/${widget.copticDate.month}/${widget.copticDate.day}'),
          ),
          const Divider(height: 8),
          _buildReadingItem(
            title: 'مزمور القداس',
            reference: psalm.reference,
            icon: Icons.music_note_rounded,
            onTap: () => context.push('/katameros/read/today'),
          ),
          const Divider(height: 8),
          _buildReadingItem(
            title: 'إنجيل القداس الإلهي',
            reference: gospel.reference,
            icon: Icons.auto_stories_rounded,
            isGospel: true,
            onTap: () => context.push('/katameros/read/today'),
          ),
        ],
      );
    }
  }

  Widget _buildReadingItem({
    required String title,
    required String reference,
    required IconData icon,
    required VoidCallback onTap,
    bool isGospel = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const accentGold = Color(0xFFD4AF37);

    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: isGospel ? accentGold : (isDark ? Colors.white54 : Colors.grey[600]),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isGospel ? FontWeight.bold : FontWeight.w600,
                  color: isGospel ? (isDark ? Colors.white : Colors.black87) : null,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                reference.isNotEmpty ? reference : 'قراءة اليوم',
                style: TextStyle(
                  fontSize: 12,
                  color: isGospel ? accentGold : (isDark ? Colors.white60 : Colors.grey[700]),
                  fontWeight: isGospel ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_left_rounded,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  KatamerosReading _fallbackReading(String service, String type, String ref) {
    return KatamerosReading(
      id: 0,
      copticMonth: widget.copticDate.month,
      copticDay: widget.copticDate.day,
      periodType: 'annual',
      rite: 'annual',
      serviceType: service,
      readingType: type,
      reference: ref,
      content: '',
      synaxariumId: null,
    );
  }

  Widget _buildEmptyFallback(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/katameros/read/today'),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(Icons.chevron_left_rounded, size: 20, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              'قراءات اليوم بحسب طقس الكنيسة',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text('اضغط للقراءة', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
