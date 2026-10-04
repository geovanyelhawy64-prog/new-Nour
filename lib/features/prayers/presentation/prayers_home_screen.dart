import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/database_service.dart';
import '../../../../data/database/app_database.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class PrayersHomeScreen extends StatefulWidget {
  const PrayersHomeScreen({super.key});

  @override
  State<PrayersHomeScreen> createState() => _PrayersHomeScreenState();
}

class _PrayersHomeScreenState extends State<PrayersHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<OccasionalPrayer>? _searchResults;
  bool _isSearching = false;

  static const _categories = [
    _PrayerCategory(
      'daily',
      'صلوات الحياة اليومية',
      'الاستيقاظ، قبل وبعد الأكل، قبل النوم، صلاة الشكر الصباحية والمسائية',
      Icons.wb_sunny_rounded,
      Color(0xFFF57C00),
    ),
    _PrayerCategory(
      'repentance',
      'صلوات التوبة والانسحاق',
      'صلوات انكسار القلب، المزمور الخمسون، صلاة منسى الملك، وقبل وبعد الاعتراف',
      Icons.favorite_border_rounded,
      Color(0xFF6A1B9A),
    ),
    _PrayerCategory(
      'protection',
      'صلوات الحماية والتحصين',
      'الحفظ من قوى الشر، الحماية من الحسد، وعند الخوف وطرد الأفكار الرديئة',
      Icons.security_rounded,
      Color(0xFF303F9F),
    ),
    _PrayerCategory(
      'communion',
      'صلوات التناول المقدس',
      'صلوات الاستعداد قبل التناول وصلوات الشكر بعده والاعتراف بالجسد والدم',
      Icons.local_dining_rounded,
      Color(0xFFC62828),
    ),
    _PrayerCategory(
      'departed',
      'صلوات الراقدين والتعزية',
      'أوشية الراقدين الكنسية، تعزية الحزانى، تذكار الأربعين والسنوية، والوالدين',
      Icons.bedtime_rounded,
      Color(0xFF455A64),
    ),
    _PrayerCategory(
      'healing',
      'صلوات الشفاء والمرضى',
      'صلاة من أجل مريض، صلاة المريض لنفسه، والشكر عند نوال الشفاء والعافية',
      Icons.healing_rounded,
      Color(0xFF43A047),
    ),
    _PrayerCategory(
      'distress',
      'صلوات الضيق والشدة',
      'صلاة في وقت التجربة وهجوم الأفكار، وطلب النجاة والسلام القلبي',
      Icons.shield_rounded,
      Color(0xFF37474F),
    ),
    _PrayerCategory(
      'family',
      'صلوات الأسرة والبركة',
      'صلاة لتبريك البيت الجديد، وحفظ الأبناء، والمولود الجديد، وبركة الزواج',
      Icons.home_rounded,
      Color(0xFFD84315),
    ),
    _PrayerCategory(
      'study',
      'صلوات الطلبة والدارسين',
      'صلاة قبل المذاكرة، قبل دخول الامتحان، طلب الحكمة والتفوق والنجاح',
      Icons.school_rounded,
      Color(0xFF1565C0),
    ),
    _PrayerCategory(
      'work',
      'صلوات العمل والتوفيق',
      'صلاة قبل بدء عمل جديد، وطلب الأمانة والبركة في الرزق وشكر المساء',
      Icons.business_center_rounded,
      Color(0xFF00838F),
    ),
    _PrayerCategory(
      'travel',
      'صلوات المسافرين',
      'صلاة قبل السفر، حفظ الطريق والسلامة براً وبحراً وجواً وشكر العودة',
      Icons.flight_takeoff_rounded,
      Color(0xFF00897B),
    ),
    _PrayerCategory(
      'thanks',
      'صلوات الشكر والتسبيح',
      'صلاة الشكر الكنسية الجامعة وتسبيح مراحم الرب عند نوال العطايا',
      Icons.auto_awesome_rounded,
      Color(0xFFC8A94E),
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) async {
    final q = query.trim();
    if (q.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = null;
      });
      return;
    }

    setState(() => _isSearching = true);
    final results = await DatabaseService.instance.prayersDao.searchPrayers(q);
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صلوات المناسبات والطلبات'),
        actions: const [
          AppQuickMenu(),
        ],
      ),
      body:  Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearch,
                decoration: InputDecoration(
                  hintText: 'ابحث في الصلوات والطلبات...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _searchController.clear();
                            _onSearch('');
                          },
                        )
                      : null,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),

            // Content
            Expanded(
              child: _isSearching ? _buildSearchResults() : _buildCategoriesList(),
            ),
          ],
        ),
    );
  }

  Widget _buildCategoriesList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _categories.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == 0) {
          // بطاقة خاصة مميزة لـ صلاة حسب المشاعر
          final isDark = Theme.of(context).brightness == Brightness.dark;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF4A148C), const Color(0xFF311B92)]
                    : [const Color(0xFFE8EAF6), const Color(0xFFF3E5F5)],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFF8E24AA).withValues(alpha: 0.35),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withValues(alpha: isDark ? 0.3 : 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => context.push('/prayers/feelings'),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.purple.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Text('🕊️', style: TextStyle(fontSize: 26)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'صلاة حسب المشاعر',
                                style: AppTypography.heading3.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'جديد',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'صلوات معزية حسب حالتك: قلق • حزن • فرح • توبة • مرض',
                            style: AppTypography.caption.copyWith(
                              color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: AppColors.textSecondaryLight,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final cat = _categories[index - 1];
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => context.push('/prayers/category/${cat.id}'),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: cat.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(cat.icon, color: cat.color, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cat.title, style: AppTypography.heading3.copyWith(fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(cat.subtitle, style: AppTypography.caption, maxLines: 2),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textSecondaryLight),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    final results = _searchResults ?? [];
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off_rounded, size: 48, color: AppColors.textSecondaryLight),
            const SizedBox(height: 12),
            Text('لم يتم العثور على صلوات تطابق بحثك', style: AppTypography.bodyMedium),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final p = results[index];
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => context.push('/prayers/category/${p.category}'),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          p.categoryAr,
                          style: const TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          p.title,
                          style: AppTypography.heading3.copyWith(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    p.content,
                    style: AppTypography.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PrayerCategory {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _PrayerCategory(this.id, this.title, this.subtitle, this.icon, this.color);
}
