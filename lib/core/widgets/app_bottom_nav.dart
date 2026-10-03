import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

/// شريط التنقل السفلي الموحد (الرئيسية | الكتاب | الألحان | المزيد)
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onIndexChanged;
  final ValueChanged<int>? onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    this.onIndexChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final gold = AppTheme.gold(context);
    final isDark = AppTheme.isDark(context);

    final callback = onTap ?? onIndexChanged;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppTheme.card(context),
      selectedItemColor: gold,
      unselectedItemColor: isDark ? const Color(0xFF8E8E93) : const Color(0xFF6E655B),
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 11),
      onTap: (index) {
        if (index != currentIndex) {
          HapticFeedback.selectionClick();
          if (callback != null) {
            callback(index);
          } else {
            switch (index) {
              case 0:
                context.go('/');
                break;
              case 1:
                context.go('/library');
                break;
              case 2:
                context.go('/search');
                break;
              case 3:
                context.go('/bookmarks');
                break;
            }
          }
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_library_outlined),
          activeIcon: Icon(Icons.local_library_rounded),
          label: 'المكتبة',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          activeIcon: Icon(Icons.manage_search_rounded),
          label: 'البحث',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border_rounded),
          activeIcon: Icon(Icons.bookmark_rounded),
          label: 'المحفوظات',
        ),
      ],
    );
  }
}
