import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/app_colors.dart';
import '../../../data/models/emotion_prayer.dart';
import '../providers/emotion_prayer_providers.dart';

class EmotionPrayersScreen extends ConsumerStatefulWidget {
  final String? initialCategory;

  const EmotionPrayersScreen({super.key, this.initialCategory});

  @override
  ConsumerState<EmotionPrayersScreen> createState() => _EmotionPrayersScreenState();
}

class _EmotionPrayersScreenState extends ConsumerState<EmotionPrayersScreen> {
  late EmotionCategory _selected;

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory != null) {
      _selected = EmotionCategory.fromString(widget.initialCategory!);
    } else {
      _selected = EmotionCategory.comfort;
    }
  }

  static const _categoryIcons = {
    EmotionCategory.comfort: Icons.sentiment_dissatisfied_outlined,
    EmotionCategory.anxiety: Icons.favorite_border_rounded,
    EmotionCategory.peace: Icons.spa_outlined,
    EmotionCategory.repentance: Icons.restart_alt_rounded,
    EmotionCategory.gratitude: Icons.celebration_outlined,
    EmotionCategory.guidance: Icons.explore_outlined,
    EmotionCategory.sickness: Icons.healing_outlined,
    EmotionCategory.temptation: Icons.shield_outlined,
  };

  static const _categoryColors = {
    EmotionCategory.comfort: Color(0xFF4A6572),
    EmotionCategory.anxiety: Color(0xFFE57373),
    EmotionCategory.peace: Color(0xFF4CAF50),
    EmotionCategory.repentance: Color(0xFF8E24AA),
    EmotionCategory.gratitude: Color(0xFFC49B3C),
    EmotionCategory.guidance: Color(0xFF0288D1),
    EmotionCategory.sickness: Color(0xFF00897B),
    EmotionCategory.temptation: Color(0xFFD84315),
  };

  @override
  Widget build(BuildContext context) {
    final prayersAsync = ref.watch(emotionPrayersByCategoryProvider(_selected.name));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = _categoryColors[_selected] ?? const Color(0xFFC49B3C);

    return Scaffold(
      appBar: AppBar(
        title: const Text('صلوات حسب المشاعر والحاجة'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Emotion selector grid / chips
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: EmotionCategory.values.map((cat) {
                  final isSel = _selected == cat;
                  final catColor = _categoryColors[cat] ?? Colors.amber;
                  final icon = _categoryIcons[cat] ?? Icons.circle;

                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ChoiceChip(
                      avatar: Icon(icon, size: 18, color: isSel ? Colors.white : catColor),
                      label: Text(
                        cat.labelAr,
                        style: TextStyle(
                          color: isSel ? Colors.white : (isDark ? Colors.grey[300] : Colors.grey[800]),
                          fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                      selected: isSel,
                      selectedColor: catColor,
                      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                      onSelected: (selected) {
                        if (selected) setState(() => _selected = cat);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const Divider(height: 1),

          // Content list
          Expanded(
            child: prayersAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('خطأ: $e')),
              data: (prayers) {
                if (prayers.isEmpty) {
                  return const Center(child: Text('لا توجد صلوات مسجلة لهذا القسم'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: prayers.length,
                  itemBuilder: (context, index) {
                    final p = prayers[index];
                    return _PrayerCard(prayer: p, color: color);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PrayerCard extends StatelessWidget {
  final EmotionPrayer prayer;
  final Color color;

  const _PrayerCard({required this.prayer, required this.color});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withValues(alpha: 0.35), width: 1.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    prayer.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Bible Verse Box
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withValues(alpha: isDark ? 0.15 : 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border(right: BorderSide(color: color, width: 3.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '«${prayer.verseText}»',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.6,
                      color: isDark ? const Color(0xFFE8DFD0) : const Color(0xFF2D2D2D),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '— ${prayer.verseReference}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Psalm (if present)
            if (prayer.psalmText != null && prayer.psalmText!.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_stories, size: 16, color: color),
                        const SizedBox(width: 6),
                        Text(
                          'من المزامير (${prayer.psalmReference})',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      prayer.psalmText!,
                      style: TextStyle(
                        fontSize: 14.5,
                        height: 1.6,
                        color: isDark ? Colors.grey[300] : Colors.grey[800],
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Agpeya Prayer (if present)
            if (prayer.agpeyaPrayer != null && prayer.agpeyaPrayer!.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.front_hand, size: 16, color: color),
                        const SizedBox(width: 6),
                        Text(
                          'صلاة من الأجبية (${prayer.agpeyaReference})',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      prayer.agpeyaPrayer!,
                      style: TextStyle(
                        fontSize: 14.5,
                        height: 1.6,
                        color: isDark ? Colors.grey[300] : Colors.grey[800],
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Meditation
            Text(
              prayer.meditation,
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: isDark ? Colors.grey[400] : Colors.grey[700],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
