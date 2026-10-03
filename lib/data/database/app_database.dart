import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// الجداول
import 'tables/agpeya_tables.dart';
import 'tables/bible_tables.dart';
import 'tables/bookmarks_tables.dart';
import 'tables/daily_verse_tables.dart';
import 'tables/difnar_tables.dart';
import 'tables/feasts_tables.dart';
import 'tables/hymns_tables.dart';
import 'tables/katameros_tables.dart';
import 'tables/liturgy_tables.dart';
import 'tables/pascha_tables.dart';
import 'tables/prayers_tables.dart';
import 'tables/sacraments_tables.dart';
import 'tables/saints_tables.dart';
import 'tables/synaxarium_tables.dart';
import 'tables/theology_tables.dart';
import 'tables/monasteries_tables.dart';
import 'tables/commentary_tables.dart';
import 'tables/dictionary_tables.dart';
import 'tables/cross_reference_tables.dart';
import 'tables/psali_tables.dart';
import 'tables/rite_tables.dart';
import 'tables/holy_place_tables.dart';
import 'tables/emotion_prayer_tables.dart';

// DAOs
import 'daos/agpeya_dao.dart';
import 'daos/bible_dao.dart';
import 'daos/holy_place_dao.dart';
import 'daos/emotion_prayer_dao.dart';
import 'daos/commentary_dao.dart';
import 'daos/dictionary_dao.dart';
import 'daos/cross_reference_dao.dart';
import 'daos/psali_dao.dart';
import 'daos/rite_dao.dart';
import 'daos/bookmarks_dao.dart';
import 'daos/daily_verse_dao.dart';
import 'daos/difnar_dao.dart';
import 'daos/feasts_dao.dart';
import 'daos/hymns_dao.dart';
import 'daos/katameros_dao.dart';
import 'daos/liturgy_dao.dart';
import 'daos/monasteries_dao.dart';
import 'daos/pascha_dao.dart';
import 'daos/prayers_dao.dart';
import 'daos/sacraments_dao.dart';
import 'daos/saints_dao.dart';
import 'daos/search_dao.dart';
import 'daos/synaxarium_dao.dart';
import 'daos/theology_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    // الكتاب المقدس
    BibleBooks,
    BibleVerses,
    // الأجبية
    AgpeyaHours,
    AgpeyaSections,
    // الخولاجي
    Liturgies,
    LiturgySections,
    LiturgyParts,
    // الألحان
    HymnBooks,
    Hymns,
    HymnSegments,
    // السنكسار
    SynaxariumEntries,
    // القطمارس
    KatamerosReadings,
    // القديسين
    Saints,
    // الدفنار
    DifnarEntries,
    // البصخة
    PaschaReadings,
    // الأعياد والأصوام
    FeastsAndFasts,
    // الصلوات
    OccasionalPrayers,
    // اللاهوت والعقيدة
    TheologyArticles,
    // آية اليوم
    DailyVerses,
    // المحفوظات
    Bookmarks,
    // الأسرار الكنسية
    Sacraments,
    SacramentSections,
    // الأديرة والمزارات
    Monasteries,
    // تفاسير الكتاب المقدس
    BibleCommentaries,
    // القاموس القبطي
    CopticDictionary,
    // الآيات المترابطة
    BibleCrossReferences,
    // التسبحة الكاملة
    Psalis,
    PsaliSections,
    // الطقوس الطقسية
    Rites,
    RiteSections,
    // الأماكن المقدسة والأديرة
    HolyPlaces,
    // صلوات المشاعر والحاجة
    EmotionPrayers,
  ],
  daos: [
    BibleDao,
    CommentaryDao,
    DictionaryDao,
    CrossReferenceDao,
    PsaliDao,
    RiteDao,
    HolyPlaceDao,
    EmotionPrayerDao,
    AgpeyaDao,
    DailyVerseDao,
    LiturgyDao,
    HymnsDao,
    SynaxariumDao,
    KatamerosDao,
    PaschaDao,
    FeastsDao,
    PrayersDao,
    SacramentsDao,
    SaintsDao,
    DifnarDao,
    TheologyDao,
    SearchDao,
    BookmarksDao,
    MonasteriesDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());
  AppDatabase.test([QueryExecutor? e]) : super(e ?? NativeDatabase.memory());

  @override
  int get schemaVersion => 17;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 10) {
            await m.createTable(bibleCommentaries);
          }
          if (from < 11) {
            await m.createTable(copticDictionary);
          }
          if (from < 12) {
            await m.createTable(bibleCrossReferences);
          }
          if (from < 13) {
            await m.createTable(psalis);
            await m.createTable(psaliSections);
          }
          if (from < 14) {
            await m.createTable(rites);
            await m.createTable(riteSections);
          }
          if (from < 15) {
            await m.createTable(holyPlaces);
          }
          if (from < 16) {
            await m.createTable(emotionPrayers);
          }
          if (from < 17) {
            // إنشاء الفهارس الحيوية للسرعة الفائقة
            await customStatement('CREATE INDEX IF NOT EXISTS idx_bible_verses_lookup ON bible_verses (book_id, chapter, verse_number);');
            await customStatement('CREATE INDEX IF NOT EXISTS idx_bible_verses_book_chap ON bible_verses (book_id, chapter);');
            await customStatement('CREATE INDEX IF NOT EXISTS idx_katameros_date ON katameros_readings (coptic_month, coptic_day);');
            await customStatement('CREATE INDEX IF NOT EXISTS idx_synaxarium_date ON synaxarium_entries (coptic_month, coptic_day);');
            await customStatement('CREATE INDEX IF NOT EXISTS idx_difnar_date ON difnar_entries (coptic_month, coptic_day);');
            await customStatement('CREATE INDEX IF NOT EXISTS idx_agpeya_sections ON agpeya_sections (hour_id, section_order);');
            await customStatement('CREATE INDEX IF NOT EXISTS idx_liturgy_parts ON liturgy_parts (section_id, part_order);');
            await customStatement('CREATE INDEX IF NOT EXISTS idx_hymns_book ON hymns (book_id, hymn_order);');
            await customStatement('CREATE INDEX IF NOT EXISTS idx_hymn_segments ON hymn_segments (hymn_id, segment_order);');
            await customStatement('CREATE INDEX IF NOT EXISTS idx_pascha_readings ON pascha_readings (day_id, hour_number, reading_order);');
            await customStatement('CREATE INDEX IF NOT EXISTS idx_psali_sections ON psali_sections (psali_id, section_order);');
            await customStatement('CREATE INDEX IF NOT EXISTS idx_rite_sections ON rite_sections (rite_id, sort_order);');
            await customStatement('CREATE INDEX IF NOT EXISTS idx_holy_places_type ON holy_places (type);');
            await customStatement('CREATE INDEX IF NOT EXISTS idx_holy_places_gov ON holy_places (governorate);');
            await customStatement('CREATE INDEX IF NOT EXISTS idx_emotion_prayers_cat ON emotion_prayers (category);');
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON;');
        },
      );

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'content.db'));
      return NativeDatabase.createInBackground(
        file,
        setup: (rawDb) {
          rawDb.execute('PRAGMA journal_mode=WAL;');
          rawDb.execute('PRAGMA synchronous=NORMAL;');
          rawDb.execute('PRAGMA foreign_keys=ON;');
          rawDb.execute('PRAGMA temp_store=MEMORY;');
          rawDb.execute('PRAGMA cache_size=-65536;');
        },
      );
    });
  }
}

// ============================================================================
// Model Extensions on Drift Generated Data Classes
// ============================================================================

extension BibleBookExtensions on BibleBook {
  bool get isOldTestament => testament == 'old';
  bool get isNewTestament => testament == 'new';
  bool get isDeuterocanonical => testament == 'deutero';
}

extension BibleVerseExtensions on BibleVerse {
  String get text => content;
  String get displayText => textWithTashkeel ?? content;
  String get reference => '$chapter:$verseNumber';
}

extension DailyVerseExtensions on DailyVerse {
  String get text => content;
}

extension LiturgyPartExtensions on LiturgyPart {
  bool get isPriest => role == 'priest';
  bool get isDeacon => role == 'deacon';
  bool get isPeople => role == 'people';
}

extension BibleCommentaryExtensions on BibleCommentary {
  String get text => content;
}
