import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/agpeya/presentation/agpeya_home_screen.dart';
import '../features/agpeya/presentation/hour_reader_screen.dart';
import '../features/bible/presentation/bible_home_screen.dart';
import '../features/bible/presentation/book_list_screen.dart';
import '../features/bible/presentation/chapter_list_screen.dart';
import '../features/bible/presentation/chapter_reader_screen.dart';
import '../features/bible/presentation/commentary_screen.dart';
import '../features/bible/presentation/dictionary_screen.dart';
import '../features/bookmarks/presentation/bookmarks_screen.dart';
import '../features/content_library/presentation/library_portals_screen.dart';
import '../features/difnar/presentation/difnar_home_screen.dart';
import '../features/feasts/presentation/feasts_home_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/more/presentation/more_screen.dart';
import '../features/hymns/presentation/hymn_reader_screen.dart';
import '../features/hymns/presentation/hymns_home_screen.dart';
import '../features/hymns/presentation/psali_home_screen.dart';
import '../features/hymns/presentation/psali_hos_screen.dart';
import '../features/hymns/presentation/psali_category_screens.dart';
import '../features/hymns/presentation/psali_reader_screen.dart';
import '../features/rites/presentation/rites_home_screen.dart';
import '../features/rites/presentation/rite_reader_screen.dart';
import '../features/simple_mode/presentation/simple_home_screen.dart';
import '../features/katameros/presentation/katameros_home_screen.dart';
import '../features/katameros/presentation/katameros_reader_screen.dart';
import '../features/liturgy/presentation/liturgy_home_screen.dart';
import '../features/liturgy/presentation/liturgy_reader_screen.dart';
import '../features/pascha/presentation/pascha_home_screen.dart';
import '../features/pascha/presentation/pascha_reader_screen.dart';
import '../features/prayers/presentation/prayers_home_screen.dart';
import '../features/prayers/presentation/prayer_reader_screen.dart';
import '../features/prayers/presentation/feelings_screen.dart';
import '../features/sacraments/presentation/sacraments_home_screen.dart';
import '../features/sacraments/presentation/sacrament_detail_screen.dart';
import '../features/saints/presentation/saints_home_screen.dart';
import '../features/saints/presentation/saint_category_screen.dart';
import '../features/saints/presentation/saint_reader_screen.dart';
import '../features/search/presentation/search_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/synaxarium/presentation/synaxarium_home_screen.dart';
import '../features/synaxarium/presentation/synaxarium_story_screen.dart';
import '../features/theology/presentation/theology_home_screen.dart';
import '../features/theology/presentation/theology_topic_screen.dart';
import '../features/theology/presentation/theology_article_reader_screen.dart';
import '../features/church_mode/presentation/church_mode_screen.dart';
import '../features/prayer_tracker/presentation/prayer_tracker_screen.dart';
import '../features/reading_plan/presentation/reading_plan_screen.dart';
import '../features/holy_places/presentation/holy_places_home_screen.dart';
import '../features/holy_places/presentation/holy_place_detail_screen.dart';
import '../features/prayers/presentation/emotion_prayers_screen.dart';
import '../features/today_liturgy/presentation/today_liturgy_screen.dart';
import '../widgets/navigation/app_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      // الغلاف الرئيسي مع شريط التنقل السفلي (BottomNavigationBar: اليوم | الكتاب | الألحان | المزيد)
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/bible',
            builder: (context, state) => const BibleHomeScreen(),
            routes: [
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: 'books/:testament',
                builder: (context, state) => BookListScreen(
                  testament: state.pathParameters['testament']!,
                ),
              ),
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: 'chapters/:bookId',
                builder: (context, state) => ChapterListScreen(
                  bookId: int.parse(state.pathParameters['bookId']!),
                ),
              ),
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: 'read/:bookId/:chapter',
                builder: (context, state) => ChapterReaderScreen(
                  bookId: int.parse(state.pathParameters['bookId']!),
                  chapter: int.parse(state.pathParameters['chapter']!),
                ),
              ),
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: 'reader/:contentId',
                builder: (context, state) {
                  final raw = state.pathParameters['contentId'] ?? '1_1';
                  final parts = raw.split(RegExp(r'[/_]'));
                  final bId = parts.isNotEmpty ? (int.tryParse(parts[0]) ?? 1) : 1;
                  final ch = parts.length > 1 ? (int.tryParse(parts[1]) ?? 1) : 1;
                  return ChapterReaderScreen(bookId: bId, chapter: ch);
                },
              ),
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: 'commentary/:bookId/:chapter',
                builder: (context, state) {
                  final bookId = int.parse(state.pathParameters['bookId']!);
                  final chapter = int.parse(state.pathParameters['chapter']!);
                  final bookName = state.uri.queryParameters['bookName'] ?? '';
                  return CommentaryScreen(
                    bookId: bookId,
                    chapter: chapter,
                    bookName: bookName,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/hymns',
            builder: (context, state) => const HymnsHomeScreen(),
            routes: [
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: 'category/:categoryId',
                builder: (context, state) => HymnReaderScreen(
                  categoryId: state.pathParameters['categoryId']!,
                  initialHymnId: state.uri.queryParameters['hymnId'],
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/more',
            builder: (context, state) => const MoreHubScreen(),
          ),
          GoRoute(
            path: '/library',
            builder: (context, state) => const LibraryPortalsScreen(),
            routes: [
              GoRoute(
                path: ':portalId',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => LibraryPortalScreen(
                  portalId: state.pathParameters['portalId'] ?? 'prayer',
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/content',
            redirect: (context, state) => '/library',
          ),
          GoRoute(
            path: '/bookmarks',
            builder: (context, state) => const BookmarksScreen(),
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) => const SearchScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),

      // ========== الأجبية المقدسة ==========
      GoRoute(
        path: '/agpeya',
        builder: (context, state) => const AgpeyaHomeScreen(),
        routes: [
          GoRoute(
            path: 'hour/:hourId',
            builder: (context, state) => HourReaderScreen(
              hourId: state.pathParameters['hourId']!,
            ),
          ),
          GoRoute(
            path: 'hours/:hourId',
            builder: (context, state) => HourReaderScreen(
              hourId: state.pathParameters['hourId']!,
            ),
          ),
        ],
      ),

      // ========== الخولاجي المقدس ==========
      GoRoute(
        path: '/liturgy',
        builder: (context, state) => const LiturgyHomeScreen(),
        routes: [
          GoRoute(
            path: 'read/:liturgyId',
            builder: (context, state) => LiturgyReaderScreen(
              liturgyId: state.pathParameters['liturgyId']!,
            ),
          ),
        ],
      ),

      // ========== القطمارس ==========
      GoRoute(
        path: '/katameros',
        builder: (context, state) => const KatamerosHomeScreen(),
        routes: [
          GoRoute(
            path: 'read/:sectionId',
            builder: (context, state) => KatamerosReaderScreen(
              sectionId: state.pathParameters['sectionId']!,
            ),
          ),
          GoRoute(
            path: 'readings/:month/:day',
            builder: (context, state) => const KatamerosReaderScreen(
              sectionId: 'today',
            ),
          ),
        ],
      ),

      // ========== السنكسار ==========
      GoRoute(
        path: '/synaxarium',
        builder: (context, state) => const SynaxariumHomeScreen(),
        routes: [
          GoRoute(
            path: 'story/:month/:day',
            builder: (context, state) => SynaxariumStoryScreen(
              month: int.parse(state.pathParameters['month']!),
              day: int.parse(state.pathParameters['day']!),
            ),
          ),
          GoRoute(
            path: 'day/:month/:day',
            builder: (context, state) => SynaxariumStoryScreen(
              month: int.parse(state.pathParameters['month']!),
              day: int.parse(state.pathParameters['day']!),
            ),
          ),
        ],
      ),

      // ========== القديسون ==========
      GoRoute(
        path: '/saints',
        builder: (context, state) => const SaintsHomeScreen(),
        routes: [
          GoRoute(
            path: 'category/:categoryId',
            builder: (context, state) => SaintCategoryScreen(
              categoryId: state.pathParameters['categoryId']!,
            ),
          ),
          GoRoute(
            path: 'detail/:saintId',
            builder: (context, state) => SaintReaderScreen(
              saintId: state.pathParameters['saintId']!,
            ),
          ),
        ],
      ),

      // ========== الدفنار ==========
      GoRoute(
        path: '/difnar',
        builder: (context, state) => const DifnarHomeScreen(),
      ),

      // ========== البصخة المقدسة ==========
      GoRoute(
        path: '/pascha',
        builder: (context, state) => const PaschaHomeScreen(),
        routes: [
          GoRoute(
            path: 'day/:dayId',
            builder: (context, state) => PaschaReaderScreen(
              dayId: state.pathParameters['dayId']!,
            ),
          ),
        ],
      ),

      // ========== الأعياد والأصوام ==========
      GoRoute(
        path: '/feasts',
        builder: (context, state) => const FeastsHomeScreen(),
      ),

      // ========== الأسرار المقدسة ==========
      GoRoute(
        path: '/sacraments',
        builder: (context, state) => const SacramentsHomeScreen(),
        routes: [
          GoRoute(
            path: 'detail/:sacramentId',
            builder: (context, state) => SacramentDetailScreen(
              sacramentId: state.pathParameters['sacramentId']!,
            ),
          ),
        ],
      ),

      // ========== الصلوات والطلبات ==========
      GoRoute(
        path: '/prayers',
        builder: (context, state) => const PrayersHomeScreen(),
        routes: [
          GoRoute(
            path: 'feelings',
            builder: (context, state) => FeelingsScreen(
              initialFeeling: state.uri.queryParameters['feeling'],
            ),
          ),
          GoRoute(
            path: 'emotions',
            builder: (context, state) => EmotionPrayersScreen(
              initialCategory: state.uri.queryParameters['category'],
            ),
          ),
          GoRoute(
            path: 'category/:categoryId',
            builder: (context, state) => PrayerReaderScreen(
              categoryId: state.pathParameters['categoryId']!,
            ),
          ),
          GoRoute(
            path: 'detail/:prayerId',
            builder: (context, state) => PrayerReaderScreen(
              categoryId: state.pathParameters['prayerId']!,
            ),
          ),
        ],
      ),

      // ========== اللاهوت والعقيدة ==========
      GoRoute(
        path: '/theology',
        builder: (context, state) => const TheologyHomeScreen(),
        routes: [
          GoRoute(
            path: 'topic/:topicId',
            builder: (context, state) => TheologyTopicScreen(
              topicId: state.pathParameters['topicId']!,
            ),
          ),
          GoRoute(
            path: 'article/:articleId',
            builder: (context, state) => TheologyArticleReaderScreen(
              articleId: state.pathParameters['articleId']!,
            ),
          ),
        ],
      ),

      // ========== وضع الكنيسة (Church Mode) ==========
      GoRoute(
        path: '/church-mode',
        builder: (context, state) => const ChurchModeScreen(),
      ),

      // ========== سجل الصلاة اليومي (Prayer Tracker) ==========
      GoRoute(
        path: '/prayer-tracker',
        builder: (context, state) => const PrayerTrackerScreen(),
      ),

      // ========== خطة قراءة الكتاب المقدس (Reading Plan) ==========
      GoRoute(
        path: '/reading-plan',
        builder: (context, state) => const ReadingPlanScreen(),
      ),

      // ========== الأماكن المقدسة والأديرة ومسار العائلة المقدسة ==========
      GoRoute(
        path: '/holy-places',
        builder: (context, state) => const HolyPlacesHomeScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 1;
              return HolyPlaceDetailScreen(placeId: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/monasteries',
        builder: (context, state) => const HolyPlacesHomeScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 1;
              return HolyPlaceDetailScreen(placeId: id);
            },
          ),
        ],
      ),

      // ========== القاموس القبطي ==========
      GoRoute(
        path: '/dictionary',
        builder: (context, state) => const DictionaryScreen(),
      ),

      // ========== التسبحة الكاملة (الأبصلمودية) ==========
      GoRoute(
        path: '/psali',
        builder: (context, state) => const PsaliHomeScreen(),
      ),
      GoRoute(
        path: '/psali/hos',
        builder: (context, state) => const PsaliHosScreen(),
      ),
      GoRoute(
        path: '/psali/theotokia',
        builder: (context, state) => const PsaliTheotokiaScreen(),
      ),
      GoRoute(
        path: '/psali/kiahki',
        builder: (context, state) => const PsaliKiahkiScreen(),
      ),
      GoRoute(
        path: '/psali/psalmody',
        builder: (context, state) => const PsaliPsalmodyScreen(),
      ),
      GoRoute(
        path: '/psali/lobsh',
        builder: (context, state) => const PsaliLobshScreen(),
      ),
      GoRoute(
        path: '/psali/doxology',
        builder: (context, state) => const PsaliDoxologyScreen(),
      ),
      GoRoute(
        path: '/psali/reader/:psaliId',
        builder: (context, state) {
          final psaliId = state.pathParameters['psaliId']!;
          final title = state.extra as String? ?? 'التسبيحة';
          return PsaliReaderScreen(psaliId: psaliId, title: title);
        },
      ),

      // ========== الطقوس الطقسية ==========
      GoRoute(
        path: '/rites',
        builder: (context, state) => const RitesHomeScreen(),
      ),
      GoRoute(
        path: '/rites/:riteId',
        builder: (context, state) {
          final riteId = int.parse(state.pathParameters['riteId']!);
          return RiteReaderScreen(riteId: riteId);
        },
      ),

      // ========== الوضع المبسط لكبار السن ==========
      GoRoute(
        path: '/simple',
        builder: (context, state) => const SimpleHomeScreen(),
      ),

      // ========== صلاتي وقراءاتي اليوم (المنجلية الذكية) ==========
      GoRoute(
        path: '/today-liturgy',
        builder: (context, state) => const TodayLiturgyScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة غير موجودة'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.church_rounded,
                size: 64,
                color: Color(0xFFD4AF37),
              ),
              const SizedBox(height: 16),
              const Text(
                'عذراً، المسار المطلوب غير متاح',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'الرابط: ${state.uri}',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
                textDirection: TextDirection.ltr,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                icon: const Icon(Icons.home_rounded),
                label: const Text('العودة إلى الصفحة الرئيسية'),
                onPressed: () => context.go('/'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
});
