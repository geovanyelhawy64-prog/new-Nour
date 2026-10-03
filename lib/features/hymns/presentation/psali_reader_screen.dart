import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/noor_app_bar.dart';
import '../../../core/widgets/text_mode_switcher.dart';
import '../providers/psali_providers.dart';

class PsaliReaderScreen extends ConsumerStatefulWidget {
  final String psaliId;
  final String title;

  const PsaliReaderScreen({
    super.key,
    required this.psaliId,
    required this.title,
  });

  @override
  ConsumerState<PsaliReaderScreen> createState() => _PsaliReaderScreenState();
}

class _PsaliReaderScreenState extends ConsumerState<PsaliReaderScreen> {
  TextDisplayMode _displayMode = TextDisplayMode.arabic;

  @override
  Widget build(BuildContext context) {
    final sectionsAsync = ref.watch(psaliSectionsProvider(widget.psaliId));
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: NoorAppBar(
        title: widget.title,
        actions: [
          TextModeSwitcher(
            currentMode: _displayMode,
            availableModes: const [
              TextDisplayMode.arabic,
              TextDisplayMode.coptic,
              TextDisplayMode.copticArabic,
              TextDisplayMode.all,
            ],
            onModeChanged: (mode) {
              setState(() {
                _displayMode = mode;
              });
            },
          ),
        ],
      ),
      body: sectionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('فشل تحميل التسبيحة', style: theme.textTheme.bodyLarge),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.invalidate(
                  psaliSectionsProvider(widget.psaliId),
                ),
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
        data: (sections) {
          if (sections.isEmpty) {
            return Center(
              child: Text(
                'لا توجد أقسام متاحة بعد',
                style: theme.textTheme.bodyLarge,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sections.length,
            itemBuilder: (context, index) {
              final section = sections[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.surfaceDark
                      : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rubric (التعليمات الطقسية)
                    if (section.rubric != null && section.rubric!.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF5B2C6F).withValues(alpha: 0.2)
                              : const Color(0xFFF3E5F5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 16,
                              color: isDark
                                  ? const Color(0xFF9B59B6)
                                  : const Color(0xFF5B2C6F),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                section.rubric!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: isDark
                                      ? const Color(0xFF9B59B6)
                                      : const Color(0xFF5B2C6F),
                                  fontStyle: FontStyle.italic,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // النص بثلاث لغات
                    TextModeSwitcher(
                      arabicText: section.textArabic,
                      copticText: section.textCoptic,
                      phoneticText: section.textPhonetic,
                      showHymnLayout: true,
                      currentMode: _displayMode,
                    ),

                    // الرد (لو موجود)
                    if (section.response != null && section.response!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E6B3A).withValues(alpha: 0.2)
                              : const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(6),
                          border: Border(
                            right: BorderSide(
                              color: isDark
                                  ? const Color(0xFF5CB85C)
                                  : const Color(0xFF1E6B3A),
                              width: 3,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الرد:',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: isDark
                                    ? const Color(0xFF5CB85C)
                                    : const Color(0xFF1E6B3A),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              section.response!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                height: 1.8,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
