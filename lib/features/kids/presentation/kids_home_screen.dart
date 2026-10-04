import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/navigation/app_quick_menu.dart';
import '../data/kids_data.dart';
import '../models/kids_prayer.dart';
import '../models/kids_story.dart';

class KidsHomeScreen extends StatefulWidget {
  const KidsHomeScreen({super.key});

  @override
  State<KidsHomeScreen> createState() => _KidsHomeScreenState();
}

class _KidsHomeScreenState extends State<KidsHomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  KidsTestament? _selectedTestament;
  final Set<String> _memorizedVerses = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleMemorized(String id) {
    HapticFeedback.mediumImpact();
    setState(() {
      if (_memorizedVerses.contains(id)) {
        _memorizedVerses.remove(id);
      } else {
        _memorizedVerses.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const accentGold = Color(0xFFD4AF37);

    return  Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('👶 وضع الأطفال', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
              SizedBox(width: 6),
              Text('• Kids Mode', style: TextStyle(fontSize: 13, color: accentGold, fontWeight: FontWeight.bold)),
            ],
          ),
          actions: const [
            AppQuickMenu(),
          ],
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: accentGold,
            indicatorWeight: 3,
            labelColor: accentGold,
            unselectedLabelColor: isDark ? Colors.white60 : Colors.black54,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            tabs: const [
              Tab(icon: Text('📖', style: TextStyle(fontSize: 18)), text: 'قصص الكتاب'),
              Tab(icon: Text('🙏', style: TextStyle(fontSize: 18)), text: 'صلواتي'),
              Tab(icon: Text('⭐', style: TextStyle(fontSize: 18)), text: 'آيات للحفظ'),
              Tab(icon: Text('🎨', style: TextStyle(fontSize: 18)), text: 'ركن التلوين'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildStoriesTab(isDark),
            _buildPrayersTab(isDark),
            _buildVersesTab(isDark),
            _buildColoringTab(isDark),
          ],
        ),
      );
  }

  // ==========================================
  // تبويب 1: قصص الكتاب المقدس
  // ==========================================
  Widget _buildStoriesTab(bool isDark) {
    final filteredStories = _selectedTestament == null
        ? KidsData.stories
        : KidsData.stories.where((s) => s.testament == _selectedTestament).toList();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
      itemCount: filteredStories.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // رسالة ترحيبية لطيفة
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF0288D1).withValues(alpha: isDark ? 0.25 : 0.12),
                      const Color(0xFF00897B).withValues(alpha: isDark ? 0.2 : 0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF0288D1).withValues(alpha: 0.3)),
                ),
                child: const Row(
                  children: [
                    Text('🌟', style: TextStyle(fontSize: 32)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'أهلاً بك يا بطل في قصص الكتاب!',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'قصص رائعة نتعلم منها شجاعة داود، وأمانة دانيال، ومحبة يسوع العظيمة.',
                            style: TextStyle(fontSize: 12, height: 1.3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // فلاتر العهد القديم والجديد
              Row(
                children: [
                  _buildFilterChip('الكل (١٠)', _selectedTestament == null, () {
                    setState(() => _selectedTestament = null);
                  }),
                  const SizedBox(width: 8),
                  _buildFilterChip('العهد القديم (٦)', _selectedTestament == KidsTestament.oldTestament, () {
                    setState(() => _selectedTestament = KidsTestament.oldTestament);
                  }),
                  const SizedBox(width: 8),
                  _buildFilterChip('العهد الجديد (٤)', _selectedTestament == KidsTestament.newTestament, () {
                    setState(() => _selectedTestament = KidsTestament.newTestament);
                  }),
                ],
              ),
              const SizedBox(height: 12),
            ],
          );
        }
        final story = filteredStories[index - 1];
        return _buildStoryCard(story, isDark);
      },
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    const accentGold = Color(0xFFD4AF37);
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? accentGold : Colors.grey.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? accentGold : Colors.transparent),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.black : null,
          ),
        ),
      ),
    );
  }

  Widget _buildStoryCard(KidsStory story, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: story.themeColor.withValues(alpha: isDark ? 0.35 : 0.2),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: story.themeColor.withValues(alpha: isDark ? 0.15 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            HapticFeedback.lightImpact();
            context.push('/kids/story/${story.id}');
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // أيقونة القصة
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: story.themeColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: story.themeColor.withValues(alpha: 0.4)),
                  ),
                  child: Center(
                    child: Text(story.icon, style: const TextStyle(fontSize: 28)),
                  ),
                ),
                const SizedBox(width: 14),

                // تفاصيل القصة
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              story.title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: story.themeColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              story.testament == KidsTestament.oldTestament ? 'عهد قديم' : 'عهد جديد',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: story.themeColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        story.subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white60 : Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        story.reference,
                        style: TextStyle(
                          fontSize: 11,
                          color: story.themeColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 6),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: isDark ? Colors.white38 : Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // تبويب 2: صلواتي اليومية
  // ==========================================
  Widget _buildPrayersTab(bool isDark) {
    final prayers = KidsData.prayers;
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
      itemCount: prayers.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF5E35B1).withValues(alpha: isDark ? 0.2 : 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF5E35B1).withValues(alpha: 0.3)),
                ),
                child: const Row(
                  children: [
                    Text('🙏', style: TextStyle(fontSize: 32)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'صلوات قصيرة من قلبي ليسوع',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'الصلاة هي أن نكلم يسوع مثل صديقنا المقرب في كل وقت.',
                            style: TextStyle(fontSize: 12, height: 1.3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        }
        final prayer = prayers[index - 1];
        return _buildPrayerCard(prayer, isDark);
      },
    );
  }

  Widget _buildPrayerCard(KidsPrayer prayer, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: prayer.color.withValues(alpha: isDark ? 0.35 : 0.2),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: prayer.color.withValues(alpha: isDark ? 0.15 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: prayer.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text(prayer.icon, style: const TextStyle(fontSize: 22))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prayer.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                    ),
                    Text(
                      prayer.timing,
                      style: TextStyle(fontSize: 11, color: isDark ? Colors.white54 : Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF141414) : const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
            ),
            child: Text(
              prayer.text,
              style: const TextStyle(fontSize: 14, height: 1.8, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            prayer.psalmLine,
            style: TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: prayer.color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ==========================================
  // تبويب 3: آيات للحفظ
  // ==========================================
  Widget _buildVersesTab(bool isDark) {
    final verses = KidsData.memoryVerses;
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
      itemCount: verses.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE91E63).withValues(alpha: isDark ? 0.2 : 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE91E63).withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Text('⭐', style: TextStyle(fontSize: 32)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'كنز الآيات الذهبية في قلبي',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'حفظت ${_memorizedVerses.length} من ${verses.length} آيات! اضغط على النجمة عند الحفظ.',
                            style: const TextStyle(fontSize: 12, height: 1.3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        }
        final verse = verses[index - 1];
        final isDone = _memorizedVerses.contains(verse.id);
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDone ? Colors.green : verse.color.withValues(alpha: isDark ? 0.35 : 0.2),
              width: isDone ? 1.8 : 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(verse.icon, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      verse.reference,
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: verse.color),
                    ),
                  ),
                  InkWell(
                    onTap: () => _toggleMemorized(verse.id),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDone ? Colors.green.withValues(alpha: 0.15) : Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isDone ? Colors.green : Colors.grey.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isDone ? Icons.star_rounded : Icons.star_border_rounded,
                            size: 16,
                            color: isDone ? Colors.green : Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isDone ? 'حفظتها! 🎉' : 'أحفظها',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isDone ? Colors.green : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                verse.verse,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.6),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '💡 ماذا تعني؟ ${verse.explanation}',
                style: TextStyle(fontSize: 12, color: isDark ? Colors.white60 : Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================
  // تبويب 4: ركن التلوين والأنشطة
  // ==========================================
  Widget _buildColoringTab(bool isDark) {
    final outlines = KidsData.coloringOutlines;
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
      itemCount: outlines.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF57C00).withValues(alpha: isDark ? 0.2 : 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF57C00).withValues(alpha: 0.3)),
                ),
                child: const Row(
                  children: [
                    Text('🎨', style: TextStyle(fontSize: 32)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'رسم وتلوين كنسي تفاعلي',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'اختر قالباً وابدأ التلوين بأجمل الألوان المبهجة بأصابعك!',
                            style: TextStyle(fontSize: 12, height: 1.3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        }
        final outline = outlines[index - 1];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFF57C00).withValues(alpha: 0.3)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Text(outline['icon'] as String, style: const TextStyle(fontSize: 32)),
            title: Text(
              outline['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            subtitle: Text(
              outline['description'] as String,
              style: TextStyle(fontSize: 12, color: isDark ? Colors.white60 : Colors.grey[700]),
            ),
            trailing: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF57C00),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.brush_rounded, size: 16),
              label: const Text('لوّن الآن'),
              onPressed: () {
                HapticFeedback.lightImpact();
                context.push('/kids/coloring?id=${outline['id']}');
              },
            ),
          ),
        );
      },
    );
  }
}
