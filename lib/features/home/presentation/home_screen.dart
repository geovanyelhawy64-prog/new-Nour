import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/coptic_calendar/coptic_date.dart';
import '../../../core/coptic_calendar/rite_determiner.dart';
import 'widgets/daily_father_quote_card.dart';
import 'widgets/daily_verse_card.dart';
import 'widgets/ecclesiastical_header_widget.dart';
import 'widgets/home_omni_search_bar.dart';
import 'widgets/home_four_portals_grid.dart';
import 'widgets/home_emotion_prayers_section.dart';
import 'widgets/smart_daily_liturgy_card.dart';
import 'widgets/spiritual_tools_card.dart';
import 'widgets/today_prayers_card.dart';
import 'widgets/today_readings_card.dart';
import 'widgets/today_synaxarium_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();
    final copticDate = CopticDate.fromGregorian(today);
    final riteInfo = RiteDeterminer.determineRite(today);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // المستوى 1: الهيدر الطقسي الكنسي الشامل
            SliverToBoxAdapter(
              child: EcclesiasticalHeaderWidget(
                copticDate: copticDate,
                riteInfo: riteInfo,
              ),
            ),

            // المستوى 2: شريط البحث الكنسي الشامل اللحظي
            const SliverToBoxAdapter(
              child: HomeOmniSearchBar(),
            ),

            // المستوى 3: صلاتي وقراءاتي اليوم (المنجلية اليومية التلقائية الذكية)
            SliverToBoxAdapter(
              child: SmartDailyLiturgyCard(
                copticDate: copticDate,
              ),
            ),

            // المستوى 4: أروقة الكاتدرائية الكبرى الـ 4 (لا توجد ميزات مستخبية)
            const SliverToBoxAdapter(
              child: HomeFourPortalsGrid(),
            ),

            // المستوى 5: صيدلية المشاعر والحالة الروحية (بماذا تشعر الآن؟)
            const SliverToBoxAdapter(
              child: HomeEmotionPrayersSection(),
            ),

            // ١. آية اليوم (Verse of the day)
            const SliverToBoxAdapter(
              child: DailyVerseCard(),
            ),

            // ٢. قراءات اليوم (Today's readings): عشية، باكر، القداس
            SliverToBoxAdapter(
              child: TodayReadingsCard(
                copticDate: copticDate,
              ),
            ),

            // ٣. صلوات اليوم (Today's prayers): باكر، الثالثة، السادسة، التاسعة، الحادية عشر، النوم
            // مع حالة تم الصلاة / لم تصلي + "أنت هنا" عند الساعة الحالية
            const SliverToBoxAdapter(
              child: TodayPrayersCard(),
            ),

            // ٤. سنكسار اليوم (Today's synaxarium): القديس الرئيسي + نبذة سريعة
            SliverToBoxAdapter(
              child: TodaySynaxariumCard(
                copticDate: copticDate,
              ),
            ),

            // ٥. قول أب اليوم (Today's father quote)
            const SliverToBoxAdapter(
              child: DailyFatherQuoteCard(),
            ),

            // أدوات الممارسة الروحية الكنسية (وضع الكنيسة المباشر، خطة القراءة، دليل الأديرة)
            const SliverToBoxAdapter(
              child: SpiritualToolsCard(),
            ),

            // مسافة مريحة في الأسفل لشريط التنقل السفلي
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }
}
