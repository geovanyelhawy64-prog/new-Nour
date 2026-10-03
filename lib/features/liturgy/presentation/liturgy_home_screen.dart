import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class LiturgyHomeScreen extends StatelessWidget {
  const LiturgyHomeScreen({super.key});

  static const _liturgies = [
    _LiturgyItem(
      id: 'raising_incense',
      title: 'رفع بخور عشية وباكر',
      subtitle: 'صلوات الاستعداد ورفع البخور المسائي والصباحي',
      icon: Icons.fireplace_rounded,
      color: Color(0xFFC62828),
    ),
    _LiturgyItem(
      id: 'basil',
      title: 'القداس الباسيلي',
      subtitle: 'للقديس باسيليوس الكبير أسقف قيصرية كبادوكية',
      icon: Icons.church_rounded,
      color: Color(0xFFB71C1C),
    ),
    _LiturgyItem(
      id: 'gregory',
      title: 'القداس الغريغوري',
      subtitle: 'للقديس غريغوريوس الثيؤلوغوس (الناطق بالإلهيات)',
      icon: Icons.auto_stories_rounded,
      color: Color(0xFF880E4F),
    ),
    _LiturgyItem(
      id: 'cyril',
      title: 'القداس الكيرلسي',
      subtitle: 'للقديس مرقس الرسول ووضعه القديس كيرلس عمود الدين',
      icon: Icons.workspace_premium_rounded,
      color: Color(0xFF4A148C),
    ),
    _LiturgyItem(
      id: 'distribution',
      title: 'صلوات التوزيع والبركة',
      subtitle: 'مزمور التوزيع ١٥٠ ومدائح التناول وصرف الشعب',
      icon: Icons.celebration_rounded,
      color: Color(0xFFD84315),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('القداس (الخولاجي المقدس)'),
        actions: const [
          AppQuickMenu(),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _liturgies.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _liturgies[index];
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => context.push('/liturgy/read/${item.id}'),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: item.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(item.icon, color: item.color, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title, style: AppTypography.heading3.copyWith(fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(item.subtitle, style: AppTypography.caption, maxLines: 2),
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

class _LiturgyItem {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _LiturgyItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}
