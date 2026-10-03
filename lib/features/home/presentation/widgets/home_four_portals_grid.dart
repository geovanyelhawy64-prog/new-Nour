import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';

/// بطاقات الأروقة الكبرى الأربعة (The 4 Grand Cathedral Pillars)
/// تنقل المستخدم مباشرة إلى ركائز الإيمان والطقس دون أي اختباء
class HomeFourPortalsGrid extends StatelessWidget {
  const HomeFourPortalsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const accentGold = Color(0xFFD4AF37);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان القسم
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              children: [
                const Icon(
                  Icons.account_balance_rounded,
                  color: accentGold,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'أروقة الكاتدرائية',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    context.push('/library');
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'المكتبة الكاملة',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 11,
                        color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          // شبكة 2x2 للركائز الأربعة
          Row(
            children: [
              Expanded(
                child: _buildPortalCard(
                  context: context,
                  isDark: isDark,
                  title: 'الكتاب المقدس',
                  subtitle: '٧٣ سفراً + التفاسير',
                  badge: 'العهد القديم والجديد',
                  icon: Icons.menu_book_rounded,
                  iconColor: const Color(0xFFD4AF37),
                  route: '/bible',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildPortalCard(
                  context: context,
                  isDark: isDark,
                  title: 'الأجبية والصلوات',
                  subtitle: '٨ سواعي + الخولاجي',
                  badge: 'صلوات الكنيسة',
                  icon: Icons.auto_stories_rounded,
                  iconColor: const Color(0xFF2069B4),
                  route: '/agpeya',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildPortalCard(
                  context: context,
                  isDark: isDark,
                  title: 'التسبحة والألحان',
                  subtitle: 'ألحان المواسم والطقوس',
                  badge: 'المعلم أسامة لطفي',
                  icon: Icons.music_note_rounded,
                  iconColor: const Color(0xFF2E8278),
                  route: '/hymns',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildPortalCard(
                  context: context,
                  isDark: isDark,
                  title: 'السنكسار والقديسون',
                  subtitle: '٨٥٩ تذكاراً + الدفنار',
                  badge: 'سحابة الشهود',
                  icon: Icons.history_edu_rounded,
                  iconColor: const Color(0xFFBA3838),
                  route: '/synaxarium',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPortalCard({
    required BuildContext context,
    required bool isDark,
    required String title,
    required String subtitle,
    required String badge,
    required IconData icon,
    required Color iconColor,
    required String route,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2433) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: iconColor.withValues(alpha: isDark ? 0.35 : 0.2),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            HapticFeedback.lightImpact();
            context.push(route);
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: iconColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        icon,
                        color: iconColor,
                        size: 20,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: iconColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        badge,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: iconColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    color: isDark ? Colors.white54 : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
