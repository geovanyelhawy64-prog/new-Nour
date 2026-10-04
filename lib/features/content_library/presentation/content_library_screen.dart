import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/navigation/app_quick_menu.dart';
import 'content_library_data.dart';

/// البوابات الكنسية الأربع الكبرى لإعادة هيكلة التطبيق للسهولة المطلقة

class ContentLibraryScreen extends StatefulWidget {
  const ContentLibraryScreen({super.key});

  @override
  State<ContentLibraryScreen> createState() => _ContentLibraryScreenState();
}

class _ContentLibraryScreenState extends State<ContentLibraryScreen>
    with SingleTickerProviderStateMixin {
  GrandPillar _selectedPillar = GrandPillar.all;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isGridView = true; // الافتراضي: عرض شبكة فخمة
  late AnimationController _animController;


  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animController.dispose();
    super.dispose();
  }

  List<LibraryCategoryItem> get _filteredCategories {
    return allCategories.where((item) {
      final matchesPillar =
          _selectedPillar == GrandPillar.all || item.pillar == _selectedPillar;
      final matchesSearch = _searchQuery.isEmpty ||
          item.title.contains(_searchQuery) ||
          item.subtitle.contains(_searchQuery) ||
          item.badge.contains(_searchQuery);
      return matchesPillar && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const accentGold = Color(0xFFC49B3C);

    return  Scaffold(
        backgroundColor: isDark ? const Color(0xFF141821) : const Color(0xFFFAF6F0),
        appBar: AppBar(
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '🏛️ مكتبة نور الشاملة',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          actions: [
            // زر تبديل وضع العرض (شبكة / قائمة)
            IconButton(
              tooltip: _isGridView ? 'عرض كقائمة' : 'عرض كشبكة',
              icon: Icon(_isGridView ? Icons.view_agenda_rounded : Icons.grid_view_rounded),
              onPressed: () {
                HapticFeedback.selectionClick();
                setState(() {
                  _isGridView = !_isGridView;
                });
              },
            ),
            const AppQuickMenu(),
          ],
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ==========================================
            // حقل البحث الكنسي الذكي
            // ==========================================
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1C2230) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? Colors.white12 : const Color(0xFFE8E0D0),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val.trim();
                      });
                    },
                    style: const TextStyle(fontSize: 14, fontFamily: 'Cairo'),
                    decoration: InputDecoration(
                      hintText: 'ابحث في الكتب، الصلوات، الألحان، والقديسين...',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white54 : Colors.black45,
                        fontFamily: 'Cairo',
                      ),
                      prefixIcon: const Icon(Icons.search_rounded, color: accentGold, size: 22),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, size: 20),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
              ),
            ),

            // ==========================================
            // شريط البوابات الكنسية الأربع الكبرى (Pillars Selector)
            // ==========================================
            SliverToBoxAdapter(
              child: Container(
                height: 52,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: GrandPillar.values.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final pillar = GrandPillar.values[index];
                    final isSelected = _selectedPillar == pillar;

                    return InkWell(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        setState(() {
                          _selectedPillar = pillar;
                          _animController.reset();
                          _animController.forward();
                        });
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutCubic,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? pillar.themeColor.withValues(alpha: isDark ? 0.35 : 0.18)
                              : (isDark ? const Color(0xFF1C2230) : Colors.white),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected
                                ? pillar.themeColor
                                : (isDark ? Colors.white12 : const Color(0xFFE8E0D0)),
                            width: isSelected ? 1.8 : 1.0,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: pillar.themeColor.withValues(alpha: 0.25),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              pillar.icon,
                              size: 17,
                              color: isSelected
                                  ? pillar.themeColor
                                  : (isDark ? Colors.white70 : Colors.black54),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              pillar.title,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected
                                    ? (isDark ? Colors.white : pillar.themeColor)
                                    : (isDark ? Colors.white70 : Colors.black87),
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ==========================================
            // عداد النتائج والتوجيه
            // ==========================================
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                child: Row(
                  children: [
                    Text(
                      'عرض ${_filteredCategories.length} من أصل ${allCategories.length} قسماً كنسياً',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? const Color(0xFFAFA799) : const Color(0xFF7A7062),
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _isGridView ? 'عرض شبكي' : 'عرض تفصيلي',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        color: accentGold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ==========================================
            // المحتوى: إما شبكة بطاقات فخمة أو قائمة تفصيلية
            // ==========================================
            _filteredCategories.isEmpty
                ? SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off_rounded,
                              size: 54, color: isDark ? Colors.white38 : Colors.black26),
                          const SizedBox(height: 12),
                          const Text(
                            'لم يتم العثور على نتائج للبحث',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'جرب البحث بكلمة أخرى أو تصفح باقي البوابات',
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark ? Colors.white60 : Colors.black54,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : _isGridView
                    ? SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                        sliver: SliverGrid(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.88,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final item = _filteredCategories[index];
                              return FadeTransition(
                                opacity: _animController,
                                child: _buildGridCard(context, item, isDark),
                              );
                            },
                            childCount: _filteredCategories.length,
                          ),
                        ),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final item = _filteredCategories[index];
                              return FadeTransition(
                                opacity: _animController,
                                child: _buildListCard(context, item, isDark),
                              );
                            },
                            childCount: _filteredCategories.length,
                          ),
                        ),
                      ),
          ],
        ),
      );
  }

  /// كارت الشبكة الفخم (Grid Card)
  Widget _buildGridCard(BuildContext context, LibraryCategoryItem item, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C2230) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white12 : const Color(0xFFE8E0D0),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            context.push(item.route);
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الأيقونة والشارة
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            item.primaryColor,
                            item.secondaryColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: item.primaryColor.withValues(alpha: 0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(item.icon, color: Colors.white, size: 22),
                      ),
                    ),
                    const Icon(Icons.arrow_back_rounded, size: 16, color: Colors.grey),
                  ],
                ),
                const Spacer(),

                // العنوان
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    height: 1.25,
                    fontFamily: 'Cairo',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // الوصف
                Text(
                  item.subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.3,
                    color: isDark ? const Color(0xFFAFA799) : const Color(0xFF6B655B),
                    fontFamily: 'Cairo',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // الشارة
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: item.primaryColor.withValues(alpha: isDark ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: item.primaryColor.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    item.badge,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: item.primaryColor,
                      fontFamily: 'Cairo',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// كارت القائمة التفصيلي (List Card)
  Widget _buildListCard(BuildContext context, LibraryCategoryItem item, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C2230) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? Colors.white12 : const Color(0xFFE8E0D0),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            context.push(item.route);
          },
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الأيقونة الكنسية
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        item.primaryColor,
                        item.secondaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: item.primaryColor.withValues(alpha: 0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(item.icon, color: Colors.white, size: 26),
                  ),
                ),
                const SizedBox(width: 14),

                // النصوص والتفاصيل
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 15.5,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: item.primaryColor.withValues(alpha: isDark ? 0.2 : 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: item.primaryColor.withValues(alpha: 0.4),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              item.badge,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: item.primaryColor,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                          fontSize: 12.5,
                          height: 1.45,
                          color: isDark ? const Color(0xFFAFA799) : const Color(0xFF6B655B),
                          fontFamily: 'Cairo',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // سهم الانتقال
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: isDark ? Colors.white30 : Colors.black26,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
