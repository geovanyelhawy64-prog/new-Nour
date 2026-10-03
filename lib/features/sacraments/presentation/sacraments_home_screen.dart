import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class SacramentsHomeScreen extends StatelessWidget {
  const SacramentsHomeScreen({super.key});

  static const _sacraments = [
    _SacramentItem('baptism', 'سر المعمودية المقدس', 'باب الدخول إلى الملكوت والميلاد الثاني بالماء والروح', Icons.water_drop_rounded, Color(0xFF0288D1)),
    _SacramentItem('chrismation', 'سر الميرون المقدس', 'حلول وثبات الروح القدس وختم المعمدين بست وثلاثين رشمة', Icons.sanitizer_rounded, Color(0xFF7B1FA2)),
    _SacramentItem('confession', 'سر التوبة والاعتراف', 'مغفرة الخطايا والرجوع إلى حضن الآب مع التحليل من الأب الكاهن', Icons.healing_rounded, Color(0xFF388E3C)),
    _SacramentItem('eucharist', 'سر الإفخارستيا (التناول)', 'جسد الرب ودمه الأقدسين للحياة الأبدية ومغفرة الخطايا', Icons.local_bar_rounded, Color(0xFFD32F2F)),
    _SacramentItem('unction', 'سر مسحة المرضى (القنديل)', 'شفاء النفس والجسد ومسح المريض بزيت الصلاة المقدس', Icons.medical_services_rounded, Color(0xFFE65100)),
    _SacramentItem('matrimony', 'سر الزيجة المقدس (الإكليل)', 'اتحاد الرجل والمرأة في سر المسيح والكنيسة بالروح القدس', Icons.favorite_rounded, Color(0xFFC2185B)),
    _SacramentItem('priesthood', 'سر الكهنوت المقدس', 'خدمة الأسرار والرعاية من خلال وضع الأيدي الرسولية (دياكونية، قسيسية، أسقفية)', Icons.church_rounded, Color(0xFF4527A0)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأسرار الكنسية السبعة'),
        actions: const [
          AppQuickMenu(),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _sacraments.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final s = _sacraments[index];
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => context.push('/sacraments/detail/${s.id}'),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: s.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(s.icon, color: s.color, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.title, style: AppTypography.heading3.copyWith(fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(s.description, style: AppTypography.caption, maxLines: 2),
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

class _SacramentItem {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _SacramentItem(this.id, this.title, this.description, this.icon, this.color);
}
