import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

class QuickAccessGrid extends StatelessWidget {
  const QuickAccessGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.95,
        children: _sections.map((section) {
          return _SectionCard(
            icon: section.icon,
            label: section.label,
            color: section.color,
            onTap: () => context.push(section.route),
          );
        }).toList(),
      ),
    );
  }
}

class _SectionInfo {
  final IconData icon;
  final String label;
  final Color color;
  final String route;

  const _SectionInfo({
    required this.icon,
    required this.label,
    required this.color,
    required this.route,
  });
}

const _sections = [
  _SectionInfo(
    icon: Icons.menu_book_rounded,
    label: 'الكتاب المقدس',
    color: Color(0xFF4CAF50),
    route: '/bible',
  ),
  _SectionInfo(
    icon: Icons.access_time_rounded,
    label: 'الصلوات',
    color: Color(0xFF2196F3),
    route: '/agpeya',
  ),
  _SectionInfo(
    icon: Icons.church_rounded,
    label: 'القداس',
    color: Color(0xFFC62828),
    route: '/liturgy',
  ),
  _SectionInfo(
    icon: Icons.music_note_rounded,
    label: 'الألحان',
    color: Color(0xFF9C27B0),
    route: '/hymns',
  ),
  _SectionInfo(
    icon: Icons.auto_stories_rounded,
    label: 'القراءات',
    color: Color(0xFFFF9800),
    route: '/katameros',
  ),
  _SectionInfo(
    icon: Icons.calendar_today_rounded,
    label: 'التذكارات',
    color: Color(0xFF795548),
    route: '/synaxarium',
  ),
  _SectionInfo(
    icon: Icons.people_rounded,
    label: 'القديسين',
    color: Color(0xFFC8A94E),
    route: '/saints',
  ),
  _SectionInfo(
    icon: Icons.library_music_rounded,
    label: 'الدفنار',
    color: Color(0xFF607D8B),
    route: '/difnar',
  ),
  _SectionInfo(
    icon: Icons.dark_mode_rounded,
    label: 'أسبوع الآلام',
    color: Color(0xFF212121),
    route: '/pascha',
  ),
  _SectionInfo(
    icon: Icons.celebration_rounded,
    label: 'الأعياد',
    color: Color(0xFFE91E63),
    route: '/feasts',
  ),
  _SectionInfo(
    icon: Icons.water_drop_rounded,
    label: 'الأسرار',
    color: Color(0xFF00BCD4),
    route: '/sacraments',
  ),
  _SectionInfo(
    icon: Icons.favorite_rounded,
    label: 'صلوات المناسبات',
    color: Color(0xFFFF5722),
    route: '/prayers',
  ),
  _SectionInfo(
    icon: Icons.school_rounded,
    label: 'العقيدة',
    color: Color(0xFF3F51B5),
    route: '/theology',
  ),
  _SectionInfo(
    icon: Icons.lyrics_rounded,
    label: 'المدائح والترانيم',
    color: Color(0xFF8BC34A),
    route: '/hymns',
  ),
  _SectionInfo(
    icon: Icons.nightlight_rounded,
    label: 'التسبحة',
    color: Color(0xFF673AB7),
    route: '/hymns',
  ),
];

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _SectionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: color,
                size: 26,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                label,
                style: AppTypography.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
