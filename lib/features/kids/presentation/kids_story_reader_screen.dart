import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../widgets/navigation/app_quick_menu.dart';
import '../data/kids_data.dart';

class KidsStoryReaderScreen extends StatefulWidget {
  final String storyId;

  const KidsStoryReaderScreen({super.key, required this.storyId});

  @override
  State<KidsStoryReaderScreen> createState() => _KidsStoryReaderScreenState();
}

class _KidsStoryReaderScreenState extends State<KidsStoryReaderScreen> {
  double _fontSize = 18.0;
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final story = KidsData.stories.firstWhere(
      (s) => s.id == widget.storyId,
      orElse: () => KidsData.stories.first,
    );

    return  Scaffold(
        appBar: AppBar(
          title: Text(
            story.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Cairo', fontSize: 16),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.text_increase_rounded),
              tooltip: 'تكبير الخط',
              onPressed: () {
                if (_fontSize < 28) setState(() => _fontSize += 2);
              },
            ),
            IconButton(
              icon: const Icon(Icons.text_decrease_rounded),
              tooltip: 'تصغير الخط',
              onPressed: () {
                if (_fontSize > 14) setState(() => _fontSize -= 2);
              },
            ),
            const AppQuickMenu(),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
          children: [
            // بطاقة رأس القصة الكبيرة
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    story.themeColor.withValues(alpha: isDark ? 0.35 : 0.15),
                    story.themeColor.withValues(alpha: isDark ? 0.15 : 0.05),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: story.themeColor.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: story.themeColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: story.themeColor.withValues(alpha: 0.5), width: 2),
                    ),
                    child: Center(
                      child: Text(story.icon, style: const TextStyle(fontSize: 36)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    story.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    story.subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.white70 : Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: story.themeColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '📖 شاهد القصة: ${story.reference}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: story.themeColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // فقرات القصة المكتوبة بلغة واضحة وجميلة
            ...story.paragraphs.asMap().entries.map((entry) {
              final idx = entry.key + 1;
              final p = entry.value;

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: story.themeColor.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$idx',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: story.themeColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        p,
                        style: TextStyle(
                          fontSize: _fontSize,
                          height: 1.8,
                          fontFamily: 'Cairo',
                          color: isDark ? Colors.white : const Color(0xFF212121),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 16),

            // الآية الذهبية للقصة
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFD4AF37).withValues(alpha: isDark ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.4), width: 1.5),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star_rounded, color: Color(0xFFD4AF37), size: 20),
                      SizedBox(width: 6),
                      Text(
                        'الآية الذهبية للقصة',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD4AF37),
                          fontFamily: 'Cairo',
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.star_rounded, color: Color(0xFFD4AF37), size: 20),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    story.memoryVerse,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    story.memoryVerseRef,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // ماذا نتعلم من القصة؟ (المعنى الروحي والتربوي)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withValues(alpha: isDark ? 0.2 : 0.08),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFF2E7D32).withValues(alpha: 0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('💡', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ماذا نتعلم من القصة؟',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                            fontFamily: 'Cairo',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          story.moralLesson,
                          style: const TextStyle(fontSize: 13, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // زر إتمام القراءة الفرح
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isCompleted ? Colors.green : story.themeColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
              ),
              icon: Icon(_isCompleted ? Icons.check_circle_rounded : Icons.celebration_rounded),
              label: Text(
                _isCompleted ? 'رائع! أكملت قراءة هذه القصة 🎉' : 'أنهيت قراءة القصة! اضغط هنا 🎉',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                HapticFeedback.heavyImpact();
                setState(() => _isCompleted = !_isCompleted);
                if (_isCompleted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green[700],
                      content: const Text(
                        'أحسنت يا بطل! لقد تعلمت درساً جميلاً من كلمة الله 🌟',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );
  }
}
