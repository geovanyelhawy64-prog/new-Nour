import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/rite.dart';
import '../providers/rite_providers.dart';

class RiteReaderScreen extends ConsumerStatefulWidget {
  final int riteId;
  const RiteReaderScreen({super.key, required this.riteId});

  @override
  ConsumerState<RiteReaderScreen> createState() => _RiteReaderScreenState();
}

class _RiteReaderScreenState extends ConsumerState<RiteReaderScreen> {
  int _textMode = 0; // 0=عربي, 1=قبطي, 2=قبطي معرب

  static const _modeLabels = ['عربي', 'قبطي', 'قبطي معرب'];

  @override
  Widget build(BuildContext context) {
    final riteAsync = ref.watch(riteByIdProvider(widget.riteId));
    final sectionsAsync = ref.watch(riteSectionsProvider(widget.riteId));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gold = isDark
        ? const Color(0xFFD4A843)
        : const Color(0xFFC49B3C);

    return Scaffold(
      appBar: AppBar(
        title: Text(riteAsync.asData?.value?.nameAr ?? 'الطقس'),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.text_fields),
            onSelected: (v) => setState(() => _textMode = v),
            itemBuilder: (_) => List.generate(
              3,
              (i) => PopupMenuItem(
                value: i,
                child: Row(
                  children: [
                    Icon(
                      _textMode == i
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: gold,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(_modeLabels[i]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: sectionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطأ: $e')),
        data: (sections) {
          if (sections.isEmpty) {
            return const Center(child: Text('لا توجد أقسام'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sections.length,
            itemBuilder: (context, index) {
              final s = sections[index];
              return _buildSection(s, isDark, gold);
            },
          );
        },
      ),
    );
  }

  Widget _buildSection(RiteSection s, bool isDark, Color gold) {
    final textColor = isDark
        ? const Color(0xFFE8DFD0)
        : const Color(0xFF2D2D2D);
    final rubricColor = isDark
        ? const Color(0xFFD4A843)
        : const Color(0xFF8B6914);
    final responseColor = isDark
        ? const Color(0xFF7CB9E8)
        : const Color(0xFF1A5276);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section title
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: gold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border(
                right: BorderSide(color: gold, width: 3),
              ),
            ),
            child: Text(
              s.titleAr,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: gold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(height: 12),

          // Rubric (liturgical instruction)
          if (s.rubric != null && s.rubric!.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: rubricColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: rubricColor.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline,
                      size: 16, color: rubricColor),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      s.rubric!,
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: rubricColor,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],

          // Main text based on mode
          _buildMainText(s, textColor),
          const SizedBox(height: 8),

          // Response
          if (s.response != null && s.response!.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: responseColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'الشعب:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: responseColor,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    s.response!,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: responseColor,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],

          // Divider
          if (s.sortOrder > 0)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Divider(
                color: gold.withValues(alpha: 0.2),
                thickness: 1,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMainText(RiteSection s, Color textColor) {
    String text;
    switch (_textMode) {
      case 1: // قبطي
        text = s.copticText ?? s.textAr;
        break;
      case 2: // قبطي معرب
        text = s.copticArabicText ?? s.copticText ?? s.textAr;
        break;
      default: // عربي
        text = s.textAr;
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: textColor,
        height: 2.0,
      ),
      textAlign: TextAlign.right,
    );
  }
}
