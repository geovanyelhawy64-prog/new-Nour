import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class PaschaHomeScreen extends StatelessWidget {
  const PaschaHomeScreen({super.key});

  static const _days = [
    _PaschaDay('lazarus', 'سبت لعازر', 'قراءات باكر والقداس الإلهي ومعجزة إقامة لعازر', Icons.wb_sunny_rounded, Color(0xFF388E3C)),
    _PaschaDay('hosanna', 'أحد الشعانين (السعف)', 'قراءات العشية، باكر، والقداس الإلهي (الأناجيل الأربعة)', Icons.eco_rounded, Color(0xFFD4AF37)),
    _PaschaDay('monday', 'إثنين البصخة', 'لعن شجرة التين وتطهير الهيكل', Icons.dark_mode_rounded, Color(0xFF212121)),
    _PaschaDay('tuesday', 'ثلاثاء البصخة', 'يوم التعاليم والأمثال وأسئلة الفريسيين', Icons.dark_mode_rounded, Color(0xFF212121)),
    _PaschaDay('wednesday', 'أربعاء البصخة (أربعاء أيوب)', 'تآمر يهوذا وسكب الطيب برأس المخلص', Icons.dark_mode_rounded, Color(0xFF212121)),
    _PaschaDay('covenant_thursday', 'خميس العهد', 'صلاة اللقان، غسل الأرجل، وتأسيس سر الإفخارستيا', Icons.water_drop_rounded, Color(0xFF1565C0)),
    _PaschaDay('good_friday', 'الجمعة العظيمة', 'صلب مخلصنا الصالح، الأمانة، والميطانيات والدفنة', Icons.close_rounded, Color(0xFF000000)),
    _PaschaDay('bright_saturday', 'سبت النور (أبو غلمسيس)', 'تسبيح سفر الرؤيا ونزول المسيح إلى الجحيم وسبي السبايا', Icons.light_mode_rounded, Color(0xFFFFA000)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أسبوع الآلام (البصخة المقدسة)'),
        actions: const [
          AppQuickMenu(),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _days.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final day = _days[index];
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => context.push('/pascha/day/${day.id}'),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: day.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(day.icon, color: day.color, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(day.title, style: AppTypography.heading3.copyWith(fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(day.subtitle, style: AppTypography.caption, maxLines: 2),
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

class _PaschaDay {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _PaschaDay(this.id, this.title, this.subtitle, this.icon, this.color);
}
