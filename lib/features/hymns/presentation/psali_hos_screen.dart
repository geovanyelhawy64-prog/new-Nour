import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/noor_app_bar.dart';
import '../providers/psali_providers.dart';

class PsaliHosScreen extends ConsumerWidget {
  const PsaliHosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hosAsync = ref.watch(hosProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: const NoorAppBar(title: 'الهوسات الأربع'),
      body: hosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطأ: $e')),
        data: (hos) {
          if (hos.isEmpty) {
            return const Center(child: Text('لا توجد هوسات بعد'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: hos.length,
            itemBuilder: (context, index) {
              final h = hos[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF8B2500).withValues(alpha: 0.15),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Color(0xFF8B2500),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    h.nameAr,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (h.nameCoptic != null)
                        Text(
                          h.nameCoptic!,
                          style: const TextStyle(
                            fontFamily: 'Antinoou',
                            fontSize: 16,
                            color: Color(0xFFC49B3C),
                          ),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        h.occasion,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () => context.push(
                    '/psali/reader/${h.psaliId}',
                    extra: h.nameAr,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
