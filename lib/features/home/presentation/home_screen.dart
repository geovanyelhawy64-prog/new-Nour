import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/coptic_calendar/coptic_date.dart';
import '../../../core/coptic_calendar/rite_determiner.dart';
import '../../../core/services/preferences_service.dart';
import 'widgets/daily_verse_card.dart';
import 'widgets/ecclesiastical_header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final copticDate = CopticDate.fromGregorian(today);
    final riteInfo = DayRiteInfo.pendingReview(today);

    return Scaffold(
      appBar: AppBar(
        title: const Text('نور'),
        actions: [
          IconButton(
            tooltip: 'الإعدادات',
            onPressed: () => context.push('/settings'),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsetsDirectional.only(bottom: 32),
          children: [
            EcclesiasticalHeaderWidget(
              copticDate: copticDate,
              riteInfo: riteInfo,
            ),
            const _CurrentPrayerCard(),
            const _TodayReadingsAndSynaxariumCard(),
            const DailyVerseCard(),
            const _ContinueReadingCard(),
          ],
        ),
      ),
    );
  }
}

class _CurrentPrayerCard extends StatelessWidget {
  const _CurrentPrayerCard();

  ({String title, String id}) _currentPrayer() {
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 9) return (title: 'صلاة باكر', id: 'prime');
    if (hour >= 9 && hour < 12) return (title: 'صلاة الساعة الثالثة', id: 'terce');
    if (hour >= 12 && hour < 15) return (title: 'صلاة الساعة السادسة', id: 'sext');
    if (hour >= 15 && hour < 18) return (title: 'صلاة الساعة التاسعة', id: 'none');
    if (hour >= 18 && hour < 21) return (title: 'صلاة الغروب', id: 'vespers');
    if (hour >= 21) return (title: 'صلاة النوم', id: 'compline');
    return (title: 'صلاة نصف الليل', id: 'midnight');
  }

  @override
  Widget build(BuildContext context) {
    final prayer = _currentPrayer();
    return _HomeCard(
      semanticLabel: 'صلاة هذه الساعة، ${prayer.title}',
      child: ListTile(
        minTileHeight: 72,
        leading: const Icon(Icons.schedule_rounded),
        title: const Text('صلاة هذه الساعة'),
        subtitle: Text(prayer.title),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () => context.push('/agpeya/hour/${prayer.id}'),
      ),
    );
  }
}

class _TodayReadingsAndSynaxariumCard extends StatelessWidget {
  const _TodayReadingsAndSynaxariumCard();

  @override
  Widget build(BuildContext context) {
    return _HomeCard(
      semanticLabel: 'قراءات اليوم وسنكسار اليوم',
      child: Column(
        children: [
          ListTile(
            minTileHeight: 64,
            leading: const Icon(Icons.auto_stories_outlined),
            title: const Text('قراءات اليوم'),
            subtitle: const Text('عشية وباكر والقداس'),
            onTap: () => context.push('/today-liturgy'),
          ),
          const Divider(height: 1),
          ListTile(
            minTileHeight: 64,
            leading: const Icon(Icons.history_edu_outlined),
            title: const Text('سنكسار اليوم'),
            subtitle: const Text('تذكارات اليوم بحسب التاريخ القبطي'),
            onTap: () => context.push('/synaxarium'),
          ),
        ],
      ),
    );
  }
}

class _ContinueReadingCard extends StatelessWidget {
  const _ContinueReadingCard();

  @override
  Widget build(BuildContext context) {
    final saved = PreferencesService.getLastBibleRead();
    final parts = saved?.split(':');
    final bookId = parts != null && parts.isNotEmpty ? int.tryParse(parts[0]) : null;
    final chapter = parts != null && parts.length > 1 ? int.tryParse(parts[1]) : null;
    final canContinue = bookId != null && chapter != null;

    return _HomeCard(
      semanticLabel: canContinue ? 'تابع القراءة، الإصحاح $chapter' : 'ابدأ القراءة',
      child: ListTile(
        minTileHeight: 72,
        leading: const Icon(Icons.bookmark_added_outlined),
        title: Text(canContinue ? 'تابع القراءة' : 'ابدأ القراءة'),
        subtitle: Text(
          canContinue ? 'الإصحاح $chapter من آخر موضع محفوظ' : 'اختر سفراً من الكتاب المقدس',
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () => canContinue
            ? context.push('/bible/read/$bookId/$chapter')
            : context.push('/bible'),
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  const _HomeCard({required this.semanticLabel, required this.child});

  final String semanticLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: semanticLabel,
      child: Card(
        margin: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 6),
        child: child,
      ),
    );
  }
}
