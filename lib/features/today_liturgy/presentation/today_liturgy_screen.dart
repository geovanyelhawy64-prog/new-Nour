import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/coptic_calendar/coptic_date.dart';
import '../../../core/coptic_calendar/rite_determiner.dart';
import '../../../core/widgets/noor_app_bar.dart';
import '../../agpeya/providers/agpeya_providers.dart';
import '../../home/providers/home_providers.dart';

/// الشاشة الذكية المتكاملة: «صلاتي وقراءاتي اليوم» (المنجلية اليومية التلقائية)
/// تجمع صلاة الساعة الحالية + قراءات قطمارس اليوم + سنكسار اليوم + ألحان المناسبة
class TodayLiturgyScreen extends ConsumerStatefulWidget {
  const TodayLiturgyScreen({super.key});

  @override
  ConsumerState<TodayLiturgyScreen> createState() => _TodayLiturgyScreenState();
}

class _TodayLiturgyScreenState extends ConsumerState<TodayLiturgyScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _fontSize = 18.0;

  static const List<String> _tabs = [
    'صلاة الساعة',
    'قراءات القداس',
    'سنكسار اليوم',
    'مردات وألحان',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getCurrentHourId() {
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 9) return 'prime';
    if (hour >= 9 && hour < 12) return 'terce';
    if (hour >= 12 && hour < 15) return 'sext';
    if (hour >= 15 && hour < 18) return 'none';
    if (hour >= 18 && hour < 21) return 'vespers';
    if (hour >= 21 || hour < 0) return 'compline';
    return 'midnight';
  }

  String _getHourTitle(String id) {
    switch (id) {
      case 'prime':
        return 'صلاة باكر';
      case 'terce':
        return 'صلاة الساعة الثالثة';
      case 'sext':
        return 'صلاة الساعة السادسة';
      case 'none':
        return 'صلاة الساعة التاسعة';
      case 'vespers':
        return 'صلاة الغروب';
      case 'compline':
        return 'صلاة النوم';
      case 'midnight':
        return 'صلاة نصف الليل';
      default:
        return 'صلاة الأجبية';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const accentGold = Color(0xFFC49B3C);

    final now = DateTime.now();
    final copticDate = CopticDate.fromGregorian(now);
    final riteInfo = RiteDeterminer.determineRite(now);
    final hourId = _getCurrentHourId();
    final hourTitle = _getHourTitle(hourId);

    return  Scaffold(
        backgroundColor: isDark ? const Color(0xFF141821) : const Color(0xFFFAF6F0),
        appBar: NoorAppBar(
          title: 'صلاتي وقراءاتي اليوم',
          actions: [
            // تكبير/تصغير الخط
            IconButton(
              tooltip: 'حجم الخط',
              icon: const Icon(Icons.format_size_rounded),
              onPressed: () {
                setState(() {
                  _fontSize = _fontSize == 18.0 ? 21.0 : (_fontSize == 21.0 ? 24.0 : 18.0);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('حجم الخط: ${_fontSize.toInt()}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // كارت الهيدر الليتورجي الذكي
            _buildLiturgicalHeader(context, copticDate, riteInfo, hourTitle, isDark, accentGold),

            // شريط التبويبات الفاخر
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1C2230) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? Colors.white12 : const Color(0xFFE8E0D0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: accentGold,
                indicatorWeight: 3,
                labelColor: accentGold,
                unselectedLabelColor: isDark ? Colors.white60 : Colors.black54,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'Cairo'),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 13, fontFamily: 'Cairo'),
                tabs: const [
                  Tab(icon: Icon(Icons.access_time_filled_rounded, size: 20), text: 'صلاة الساعة'),
                  Tab(icon: Icon(Icons.menu_book_rounded, size: 20), text: 'قراءات القداس'),
                  Tab(icon: Icon(Icons.calendar_month_rounded, size: 20), text: 'السنكسار'),
                  Tab(icon: Icon(Icons.music_note_rounded, size: 20), text: 'المردات واللحن'),
                ],
              ),
            ),

            // محتوى التبويبات
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // 1. صلاة الساعة الحالية
                  _buildAgpeyaHourView(hourId, hourTitle, isDark),

                  // 2. قراءات قداس اليوم
                  _buildKatamerosView(isDark),

                  // 3. سنكسار اليوم
                  _buildSynaxariumView(isDark),

                  // 4. ألحان ومردات اليوم
                  _buildHymnsAndResponsesView(riteInfo, isDark),
                ],
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildLiturgicalHeader(
    BuildContext context,
    CopticDate copticDate,
    DayRiteInfo riteInfo,
    String hourTitle,
    bool isDark,
    Color accentGold,
  ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1E2638), const Color(0xFF151C2A)]
              : [const Color(0xFFFFFFFF), const Color(0xFFF7F3EA)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: accentGold.withValues(alpha: 0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: accentGold.withValues(alpha: isDark ? 0.15 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentGold.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.church_rounded, color: accentGold, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      copticDate.formatted,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: accentGold.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        hourTitle,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: accentGold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'الطقس: ${riteInfo.riteNameAr} • النغمة: ${riteInfo.seasonName}',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: isDark ? const Color(0xFFB0A99A) : const Color(0xFF7A7062),
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgpeyaHourView(String hourId, String hourTitle, bool isDark) {
    final sectionsAsync = ref.watch(hourSectionsProvider(hourId));

    return sectionsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('خطأ في تحميل الصلاة: $e')),
      data: (sections) {
        if (sections.isEmpty) {
          return const Center(child: Text('لا توجد نصوص متاحة'));
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
          itemCount: sections.length,
          itemBuilder: (context, index) {
            final sec = sections[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1C2230) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? Colors.white10 : const Color(0xFFE8E0D0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFFC49B3C),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          sec.title,
                          style: TextStyle(
                            fontSize: _fontSize - 1,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFC49B3C),
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    sec.textAr,
                    style: TextStyle(
                      fontSize: _fontSize,
                      height: 1.8,
                      color: isDark ? const Color(0xFFE8DFD0) : const Color(0xFF2D2D2D),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildKatamerosView(bool isDark) {
    final readingsAsync = ref.watch(todayLiturgicalReadingsProvider);

    return readingsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('خطأ في تحميل القراءات: $e')),
      data: (readings) {
        if (readings.isEmpty) {
          return const Center(
            child: Text(
              'لا توجد قراءات مسجلة لهذا اليوم',
              style: TextStyle(fontFamily: 'Cairo'),
            ),
          );
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
          itemCount: readings.length,
          itemBuilder: (context, index) {
            final reading = readings[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1C2230) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? Colors.white10 : const Color(0xFFE8E0D0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC49B3C).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          reading.readingType,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFC49B3C),
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          reading.reference,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? Colors.white70 : Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    reading.content,
                    style: TextStyle(
                      fontSize: _fontSize,
                      height: 1.8,
                      color: isDark ? const Color(0xFFE8DFD0) : const Color(0xFF2D2D2D),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSynaxariumView(bool isDark) {
    final synaxariumAsync = ref.watch(todaySynaxariumProvider);

    return synaxariumAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('خطأ في تحميل السنكسار: $e')),
      data: (entries) {
        if (entries.isEmpty) {
          return const Center(child: Text('لا توجد تذكارات مسجلة لهذا اليوم'));
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final entry = entries[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1C2230) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? Colors.white10 : const Color(0xFFE8E0D0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFC49B3C), size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          entry.title,
                          style: TextStyle(
                            fontSize: _fontSize,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFC49B3C),
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    entry.fullText,
                    style: TextStyle(
                      fontSize: _fontSize - 1,
                      height: 1.8,
                      color: isDark ? const Color(0xFFE8DFD0) : const Color(0xFF2D2D2D),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHymnsAndResponsesView(DayRiteInfo riteInfo, bool isDark) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
      children: [
        // كارت نغمة اليوم
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1C2230) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? Colors.white10 : const Color(0xFFE8E0D0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.library_music_rounded, color: Color(0xFFC49B3C), size: 22),
                  SizedBox(width: 8),
                  Text(
                    'مرد الإنجيل الكنسي لليوم',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC49B3C),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '«مبارك الآتي باسم الرب، ربنا وإلهنا ومخلصنا يسوع المسيح، ابن الله الحي، له المجد دائماً أبدياً آمين.»',
                style: TextStyle(
                  fontSize: _fontSize,
                  height: 1.8,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFFE8DFD0) : const Color(0xFF2D2D2D),
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 14),
              const Divider(),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    'الطقس والنغمة المقررة: ${riteInfo.riteNameAr} (${riteInfo.seasonName})',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.white70 : Colors.black54,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      context.push('/hymns');
                    },
                    icon: const Icon(Icons.arrow_back_rounded, size: 16),
                    label: const Text(
                      'فتح مكتبة الألحان',
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
