import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class BibleHomeScreen extends StatelessWidget {
  const BibleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lastRead = PreferencesService.getLastBibleRead();
    int? lastBookId;
    int? lastChapter;
    if (lastRead != null && lastRead.contains(':')) {
      final parts = lastRead.split(':');
      lastBookId = int.tryParse(parts[0]);
      lastChapter = int.tryParse(parts[1]);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('الكتاب المقدس'),
        actions: const [
          AppQuickMenu(),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (lastBookId != null && lastChapter != null) ...[
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: AppColors.primary.withValues(alpha: 0.4)),
              ),
              color: AppColors.primary.withValues(alpha: 0.08),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.history_rounded, color: Colors.white),
                ),
                title: const Text('متابعة آخر قراءة', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('الإصحاح $lastChapter'),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () => context.push('/bible/read/$lastBookId/$lastChapter'),
              ),
            ),
            const SizedBox(height: 16),
          ],
          _TestamentCard(
            title: 'العهد القديم',
            subtitle: '٣٩ سفراً قانونياً',
            icon: Icons.auto_stories_rounded,
            color: const Color(0xFF388E3C),
            onTap: () => context.push('/bible/books/old'),
          ),
          const SizedBox(height: 12),
          _TestamentCard(
            title: 'العهد الجديد',
            subtitle: '٢٧ سفراً',
            icon: Icons.menu_book_rounded,
            color: const Color(0xFF1976D2),
            onTap: () => context.push('/bible/books/new'),
          ),
          const SizedBox(height: 12),
          _TestamentCard(
            title: 'الأسفار القانونية الثانية',
            subtitle: '١٠ أسفار وتتمات قانونية',
            icon: Icons.bookmark_added_rounded,
            color: AppColors.primary,
            onTap: () => context.push('/bible/books/deutero'),
          ),
        ],
      ),
    );
  }
}

class _TestamentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _TestamentCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(title, style: AppTypography.heading3),
        subtitle: Text(subtitle, style: AppTypography.bodySmall),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: onTap,
      ),
    );
  }
}
