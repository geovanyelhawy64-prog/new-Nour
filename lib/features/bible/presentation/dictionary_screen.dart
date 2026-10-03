import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../core/widgets/noor_app_bar.dart';
import '../../../data/models/coptic_dictionary_entry.dart';
import '../providers/dictionary_providers.dart';

class DictionaryScreen extends ConsumerStatefulWidget {
  const DictionaryScreen({super.key});

  @override
  ConsumerState<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends ConsumerState<DictionaryScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final resultsAsync = _searchQuery.isEmpty
        ? null
        : ref.watch(dictionarySearchProvider(_searchQuery));

    final countAsync = ref.watch(dictionaryCountProvider);

    return Scaffold(
      appBar: const NoorAppBar(title: 'القاموس القبطي'),
      body: Column(
        children: [
          // شريط البحث
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'ابحث بالقبطي أو العربي أو النطق...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: isDark
                    ? AppColors.surfaceDark
                    : AppColors.surfaceLight,
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),

          // عدد الكلمات
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                countAsync.when(
                  data: (count) => Text(
                    '$count كلمة في القاموس',
                    style: theme.textTheme.bodySmall,
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // النتائج
          Expanded(
            child: resultsAsync == null
                ? _buildDefaultView(theme, isDark)
                : resultsAsync.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, _) => Center(
                      child: Text('حدث خطأ: $error'),
                    ),
                    data: (results) {
                      if (results.isEmpty) {
                        return Center(
                          child: Text(
                            'لا توجد نتائج لـ "$_searchQuery"',
                            style: theme.textTheme.bodyLarge,
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final entry = results[index];
                          return _buildDictionaryCard(entry, theme, isDark);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultView(ThemeData theme, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.translate,
            size: 64,
            color: isDark
                ? const Color(0xFF9B9484)
                : const Color(0xFF6B6B6B),
          ),
          const SizedBox(height: 16),
          Text(
            'ابحث عن أي كلمة قبطية',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isDark
                  ? const Color(0xFF9B9484)
                  : const Color(0xFF6B6B6B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'اكتب الكلمة بالقبطي أو النطق أو العربي',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildDictionaryCard(
    CopticDictionaryEntry entry,
    ThemeData theme,
    bool isDark,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          right: BorderSide(
            color: isDark
                ? AppColors.primaryLight
                : AppColors.primary,
            width: 3,
          ),
        ),
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
          // القبطي + النطق
          Row(
            children: [
              Text(
                entry.coptic,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontFamily: 'Antinoou',
                  color: isDark
                      ? const Color(0xFFD4A843)
                      : const Color(0xFFC49B3C),
                  fontSize: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '(${entry.phonetic})',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? const Color(0xFF9B9484)
                      : const Color(0xFF6B6B6B),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFFD4A843).withValues(alpha: 0.2)
                      : const Color(0xFFC49B3C).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  entry.partOfSpeechAr,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? const Color(0xFFD4A843)
                        : const Color(0xFFC49B3C),
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // المعنى بالعربي
          Text(
            entry.arabic,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.8,
            ),
            textDirection: TextDirection.rtl,
          ),
          // الإنجليزي (لو موجود)
          if (entry.english != null) ...[
            const SizedBox(height: 4),
            Text(
              entry.english!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark
                    ? const Color(0xFF9B9484)
                    : const Color(0xFF6B6B6B),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          // الاستخدام (لو موجود)
          if (entry.usage != null && entry.usage!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF141821)
                    : const Color(0xFFFAF6F0),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.format_quote,
                    size: 16,
                    color: isDark
                        ? const Color(0xFF9B9484)
                        : const Color(0xFF6B6B6B),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      entry.usage!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        height: 1.6,
                        color: isDark
                            ? const Color(0xFFE8DFD0)
                            : const Color(0xFF2D2D2D),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
            ),
          ],
          // مرجع اللحن (لو موجود)
          if (entry.hymnReference != null && entry.hymnReference!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.music_note,
                  size: 14,
                  color: isDark
                      ? const Color(0xFFD4A843)
                      : const Color(0xFFC49B3C),
                ),
                const SizedBox(width: 4),
                Text(
                  entry.hymnReference!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? const Color(0xFFD4A843)
                        : const Color(0xFFC49B3C),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
