import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/noor_app_bar.dart';
import '../../../data/models/psali.dart';
import '../providers/psali_providers.dart';

class _PsaliGenericListScreen extends ConsumerWidget {
  final String title;
  final ProviderListenable<AsyncValue<List<Psali>>> provider;
  final Color accentColor;
  final String emptyMessage;

  const _PsaliGenericListScreen({
    required this.title,
    required this.provider,
    required this.accentColor,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(provider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: NoorAppBar(title: title),
      body: listAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطأ: $e')),
        data: (items) {
          if (items.isEmpty) {
            return Center(child: Text(emptyMessage));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: accentColor.withValues(alpha: 0.15),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    item.nameAr,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.nameCoptic != null && item.nameCoptic!.isNotEmpty)
                        Text(
                          item.nameCoptic!,
                          style: const TextStyle(
                            fontFamily: 'Antinoou',
                            fontSize: 16,
                            color: Color(0xFFC49B3C),
                          ),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        item.occasion,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () => context.push(
                    '/psali/reader/${item.psaliId}',
                    extra: item.nameAr,
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

class PsaliTheotokiaScreen extends StatelessWidget {
  const PsaliTheotokiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PsaliGenericListScreen(
      title: 'التئوطوكيات السبع',
      provider: psaliByTypeProvider('theotokia'),
      accentColor: const Color(0xFF1B4F72),
      emptyMessage: 'لا توجد تئوطوكيات متاحة بعد',
    );
  }
}

class PsaliKiahkiScreen extends StatelessWidget {
  const PsaliKiahkiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PsaliGenericListScreen(
      title: 'المديحات الكيهكية',
      provider: kiahkiMadihatProvider,
      accentColor: const Color(0xFFC49B3C),
      emptyMessage: 'لا توجد مديحات كيهكية متاحة بعد',
    );
  }
}

class PsaliPsalmodyScreen extends StatelessWidget {
  const PsaliPsalmodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PsaliGenericListScreen(
      title: 'الإبصلمودية',
      provider: psalmodyProvider,
      accentColor: const Color(0xFF1E6B3A),
      emptyMessage: 'لا توجد إبصلموديات متاحة بعد',
    );
  }
}

class PsaliLobshScreen extends StatelessWidget {
  const PsaliLobshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PsaliGenericListScreen(
      title: 'اللبش والطرح',
      provider: psaliByTypeProvider('lobsh'),
      accentColor: const Color(0xFF5B2C6F),
      emptyMessage: 'لا توجد تسابيح لبش متاحة بعد',
    );
  }
}

class PsaliDoxologyScreen extends StatelessWidget {
  const PsaliDoxologyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PsaliGenericListScreen(
      title: 'الذوكصولوجيات',
      provider: psaliByTypeProvider('doxology'),
      accentColor: const Color(0xFF8B4513),
      emptyMessage: 'لا توجد ذوكصولوجيات متاحة بعد',
    );
  }
}
