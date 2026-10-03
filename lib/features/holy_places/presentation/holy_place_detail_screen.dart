import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/holy_places_providers.dart';

class HolyPlaceDetailScreen extends ConsumerWidget {
  final int placeId;
  const HolyPlaceDetailScreen({super.key, required this.placeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeAsync = ref.watch(holyPlaceByIdProvider(placeId));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final goldColor = isDark ? const Color(0xFFD4A843) : const Color(0xFFC49B3C);

    return Scaffold(
      appBar: AppBar(
        title: placeAsync.whenOrNull(
              data: (p) => p != null ? Text(p.nameAr) : null,
            ) ??
            const Text('المكان المقدس'),
        centerTitle: true,
      ),
      body: placeAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطأ: $e')),
        data: (p) {
          if (p == null) {
            return const Center(child: Text('لم يتم العثور على المكان'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: goldColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: goldColor.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        p.nameAr,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: goldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (p.nameCoptic != null && p.nameCoptic!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          p.nameCoptic!,
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? Colors.grey[300] : Colors.grey[700],
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      const SizedBox(height: 10),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _Badge(icon: Icons.category, label: p.type.labelAr),
                          _Badge(icon: Icons.location_on, label: p.governorate),
                          if (p.century != null)
                            _Badge(icon: Icons.schedule, label: p.century!),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Patron Saint
                if (p.patronSaint != null && p.patronSaint!.isNotEmpty) ...[
                  _SectionBox(
                    icon: Icons.star_rounded,
                    title: 'شفيع المكان',
                    content: p.patronSaint!,
                    goldColor: goldColor,
                  ),
                  const SizedBox(height: 14),
                ],

                // Location details
                _SectionBox(
                  icon: Icons.map_outlined,
                  title: 'الموقع الجغرافي والوصول',
                  content: p.locationDescription,
                  goldColor: goldColor,
                  coordinates: (p.latitude != null && p.longitude != null)
                      ? '${p.latitude}, ${p.longitude}'
                      : null,
                ),
                const SizedBox(height: 14),

                // History
                _SectionBox(
                  icon: Icons.history_edu_rounded,
                  title: 'النبذة التاريخية والروحية',
                  content: p.history,
                  goldColor: goldColor,
                  isLongText: true,
                ),
                const SizedBox(height: 14),

                // Feast Days
                if (p.feastDay != null && p.feastDay!.isNotEmpty) ...[
                  _SectionBox(
                    icon: Icons.celebration_rounded,
                    title: 'الأعياد والمناسبات السنوية',
                    content: p.feastDay!,
                    goldColor: goldColor,
                  ),
                  const SizedBox(height: 14),
                ],

                // Visiting rules
                if (p.visitingRules != null && p.visitingRules!.isNotEmpty) ...[
                  _SectionBox(
                    icon: Icons.access_time_filled_rounded,
                    title: 'مواعيد وإرشادات الزيارة والبركة',
                    content: p.visitingRules!,
                    goldColor: goldColor,
                  ),
                  const SizedBox(height: 20),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Badge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _SectionBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final Color goldColor;
  final bool isLongText;
  final String? coordinates;

  const _SectionBox({
    required this.icon,
    required this.title,
    required this.content,
    required this.goldColor,
    this.isLongText = false,
    this.coordinates,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black12,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, color: goldColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: goldColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              height: isLongText ? 1.8 : 1.5,
              color: isDark ? const Color(0xFFE8DFD0) : const Color(0xFF2D2D2D),
            ),
          ),
          if (coordinates != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.gps_fixed, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 6),
                Text(
                  'الإحداثيات: $coordinates',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
