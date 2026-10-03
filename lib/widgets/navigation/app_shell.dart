import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final location = GoRouterState.of(context).uri.path;
    final accentGold = isDark ? AppColors.primaryLight : AppColors.primary;

    int currentIndex;
    if (location == '/') {
      currentIndex = 0;
    } else if (location.startsWith('/library') || location.startsWith('/content')) {
      currentIndex = 1;
    } else if (location.startsWith('/search')) {
      currentIndex = 2;
    } else if (location.startsWith('/bookmarks')) {
      currentIndex = 3;
    } else {
      currentIndex = 0;
    }

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: accentGold,
            unselectedItemColor: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 11,
            ),
            onTap: (index) {
              if (index != currentIndex) {
                HapticFeedback.selectionClick();
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
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded, color: accentGold),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.local_library_outlined),
                activeIcon: Icon(Icons.local_library_rounded, color: accentGold),
                label: 'المكتبة',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.search_rounded),
                activeIcon: Icon(Icons.manage_search_rounded, color: accentGold),
                label: 'البحث',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.bookmark_border_rounded),
                activeIcon: Icon(Icons.bookmark_rounded, color: accentGold),
                label: 'المحفوظات',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
