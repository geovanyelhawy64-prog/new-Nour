import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/rite.dart';
import '../providers/rite_providers.dart';

class RitesHomeScreen extends ConsumerWidget {
  const RitesHomeScreen({super.key});

  static const _categoryIcons = {
    'sacrament': Icons.water_drop_outlined,
    'ordination': Icons.how_to_reg_outlined,
    'funeral': Icons.local_florist_outlined,
    'laqan': Icons.opacity_outlined,
    'consecration': Icons.church_outlined,
  };

  static const _categoryColors = {
    'sacrament': Color(0xFFC49B3C),
    'ordination': Color(0xFF6B4C8A),
    'funeral': Color(0xFF5C6B73),
    'laqan': Color(0xFF3C7BC4),
    'consecration': Color(0xFF8B4513),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ritesAsync = ref.watch(allRitesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الطقوس الطقسية'),
        centerTitle: true,
      ),
      body: ritesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطأ: $e')),
        data: (rites) {
          if (rites.isEmpty) {
            return const Center(child: Text('لا توجد طقوس بعد'));
          }

          // Group by category
          final grouped = <String, List<Rite>>{};
          for (final r in rites) {
            grouped.putIfAbsent(r.category.name, () => []).add(r);
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: grouped.entries.map((entry) {
              final cat = RiteCategory.fromString(entry.key);
              final icon = _categoryIcons[entry.key] ?? Icons.star_outline;
              final color = _categoryColors[entry.key] ??
                  const Color(0xFFC49B3C);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Row(
                      children: [
                        Icon(icon, color: color, size: 22),
                        const SizedBox(width: 8),
                        Text(
                          cat.labelAr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${entry.value.length})',
                          style: TextStyle(
                            color: isDark
                                ? Colors.grey[400]
                                : Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...entry.value.map((rite) => Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: color.withValues(alpha: 0.3),
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: color.withValues(alpha: 0.15),
                            child: Icon(icon, color: color, size: 20),
                          ),
                          title: Text(
                            rite.nameAr,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: rite.description != null
                              ? Text(
                                  rite.description!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark
                                        ? Colors.grey[400]
                                        : Colors.grey[600],
                                  ),
                                )
                              : null,
                          trailing: Icon(
                            Icons.chevron_left,
                            color: isDark
                                ? Colors.grey[400]
                                : Colors.grey[600],
                          ),
                          onTap: () =>
                              context.push('/rites/${rite.id}'),
                        ),
                      )),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
