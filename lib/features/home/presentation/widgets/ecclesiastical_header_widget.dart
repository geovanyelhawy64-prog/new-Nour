import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/coptic_calendar/coptic_date.dart';
import '../../../../core/coptic_calendar/rite_determiner.dart';
import '../../../../core/providers/simple_mode_provider.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class EcclesiasticalHeaderWidget extends StatelessWidget {
  final CopticDate copticDate;
  final DayRiteInfo riteInfo;

  const EcclesiasticalHeaderWidget({
    super.key,
    required this.copticDate,
    required this.riteInfo,
  });

  static String toArabicDigits(int number) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    var str = number.toString();
    for (var i = 0; i < 10; i++) {
      str = str.replaceAll(english[i], arabic[i]);
    }
    return str;
  }

  /// تحديد نغمة اليوم الكنسية (آدام / واطس) ونغمة الطقس (سنوي / فرايحي / صيامي / إلخ)
  String _determineTone(DateTime date) {
    // نغمة الأيام في الطقس القبطي:
    // الأحد، الاثنين، الثلاثاء = آدام (Adam)
    // الأربعاء، الخميس، الجمعة، السبت = واطس (Batos)
    final weekday = date.weekday;
    final dayTone = (weekday == DateTime.sunday ||
            weekday == DateTime.monday ||
            weekday == DateTime.tuesday)
        ? 'آدام'
        : 'واطس';

    switch (riteInfo.rite) {
      case ChurchRite.festive:
      case ChurchRite.joyous:
        return 'فرايحي ($dayTone)';
      case ChurchRite.lenten:
        return 'صيامي ($dayTone)';
      case ChurchRite.kiahki:
        return 'كيهكي ($dayTone)';
      case ChurchRite.pascha:
        return 'حزايني / بصخة';
      case ChurchRite.annual:
        return 'سنوي ($dayTone)';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const accentGold = Color(0xFFD4AF37);
    final gregorian = copticDate.toGregorian();
    final copticDayStr = toArabicDigits(copticDate.day);
    final copticYearStr = toArabicDigits(copticDate.year);
    final toneStr = _determineTone(gregorian);

    final riteTitle = riteInfo.isFasting
        ? (riteInfo.fastName ?? 'صوم')
        : riteInfo.riteNameAr;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1B1B1B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: accentGold.withValues(alpha: isDark ? 0.35 : 0.25),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // الصف العلوي: الأيقونة + التاريخ القبطي واليوم + زر البحث وزر القائمة
          Row(
            children: [
              // أيقونة الكنيسة الذهبية
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      accentGold.withValues(alpha: 0.25),
                      isDark ? AppColors.primaryDark : AppColors.primaryLight,
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: accentGold.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.church_rounded,
                    color: accentGold,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // التاريخ القبطي واليوم
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '⛪ $copticDayStr ${copticDate.monthName} $copticYearStr ش',
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          AppDateUtils.formatGregorianWithDay(gregorian),
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? Colors.white60 : Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text('•', style: TextStyle(fontSize: 11, color: Colors.grey)),
                        const SizedBox(width: 6),
                        const Text(
                          'Noor',
                          style: TextStyle(
                            fontSize: 11,
                            color: accentGold,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // زر الوضع المبسط لكبار السن
              Consumer(
                builder: (context, ref, _) => IconButton(
                  icon: const Icon(Icons.accessibility_new_rounded, size: 22),
                  tooltip: 'الوضع المبسط لكبار السن',
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    ref.read(simpleModeProvider.notifier).setSimpleMode(true);
                    context.go('/simple');
                  },
                  visualDensity: VisualDensity.compact,
                ),
              ),
              // زر القائمة السريعة الشاملة (⋮)
              const AppQuickMenu(),
            ],
          ),

          const SizedBox(height: 10),
          Divider(
            height: 1,
            color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
          ),
          const SizedBox(height: 10),

          // الصف السفلي: الطقس والنغمة
          Row(
            children: [
              // شارة الطقس
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: riteInfo.isFasting
                        ? AppColors.lentenColor.withValues(alpha: 0.12)
                        : accentGold.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: riteInfo.isFasting
                          ? AppColors.lentenColor.withValues(alpha: 0.25)
                          : accentGold.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        riteInfo.isFasting ? Icons.wb_twilight_rounded : Icons.auto_awesome_rounded,
                        size: 14,
                        color: riteInfo.isFasting ? AppColors.lentenColor : accentGold,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'الطقس: $riteTitle',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: riteInfo.isFasting ? AppColors.lentenColor : accentGold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // شارة النغمة
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.grey.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isDark ? Colors.white12 : Colors.grey.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.music_note_rounded,
                        size: 14,
                        color: isDark ? Colors.white70 : Colors.grey[700],
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'النغمة: $toneStr',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white70 : Colors.grey[800],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // مناسبة اليوم أو العيد إن وُجد
          if (riteInfo.feastName != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    accentGold.withValues(alpha: 0.18),
                    accentGold.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: accentGold.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star_rounded, size: 16, color: accentGold),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      riteInfo.feastName!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: accentGold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
