import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite3/sqlite3.dart' as sq;
import '../../core/constants/app_constants.dart';
import '../../core/services/logger_service.dart';
export 'bookmark_model.dart';

// الجداول
import 'tables/agpeya_tables.dart';
import 'tables/bible_tables.dart';
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
import 'tables/psalms_mapping_tables.dart';

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
    // خريطة ترقيم المزامير
    PsalmsMapping,
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
    MonasteriesDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());
  AppDatabase.test([QueryExecutor? e]) : super(e ?? NativeDatabase.memory());

  @override
  int get schemaVersion => 18;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
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
      final file = File(p.join(dbFolder.path, 'noor.db'));
      final prefs = await SharedPreferences.getInstance();
      final installedVersion = prefs.getInt(AppConstants.prefInstalledDbVersion) ?? 0;

      final bool fileValid = await file.exists() && (await file.length()) > 1024 * 1024;
      final bool needsUpdate = !fileValid || installedVersion < AppConstants.currentDbVersion;

      if (needsUpdate) {
        try {
          // If file already exists and has user data, preserve bookmarks if any
          final savedBookmarks = <Map<String, dynamic>>[];
          if (fileValid) {
            try {
              final oldRawDb = sq.sqlite3.open(file.path);
              try {
                final rows = oldRawDb.select('SELECT content_type, content_id, display_title, note, created_at FROM bookmarks');
                for (final row in rows) {
                  savedBookmarks.add({
                    'content_type': row['content_type'],
                    'content_id': row['content_id'],
                    'display_title': row['display_title'],
                    'note': row['note'],
                    'created_at': row['created_at'],
                  });
                }
              } catch (_) {
                try {
                  final rows = oldRawDb.select('SELECT item_type, item_id, title, subtitle, created_at FROM bookmarks');
                  for (final row in rows) {
                    savedBookmarks.add({
                      'content_type': row['item_type'],
                      'content_id': row['item_id'],
                      'display_title': row['title'],
                      'note': row['subtitle'],
                      'created_at': row['created_at'],
                    });
                  }
                } catch (e, st) {
                  LoggerService.error('فشل استخراج الإشارات المرجعية من المخطط البديل', e, st);
                }
              }
              oldRawDb.close();
            } catch (e, st) {
              LoggerService.error('فشل الوصول لقاعدة البيانات القديمة لنقل الإشارات المرجعية', e, st);
            }
          }

          final data = await rootBundle.load('assets/databases/noor.db');
          final bytes = data.buffer.asUint8List();
          await file.parent.create(recursive: true);
          await file.writeAsBytes(bytes, flush: true);

          // Restore bookmarks if we had any
          if (savedBookmarks.isNotEmpty) {
            try {
              final newRawDb = sq.sqlite3.open(file.path);
              for (final b in savedBookmarks) {
                newRawDb.execute(
                  'INSERT OR IGNORE INTO bookmarks (content_type, content_id, display_title, note, created_at) VALUES (?, ?, ?, ?, ?)',
                  [b['content_type'], b['content_id'], b['display_title'], b['note'], b['created_at']],
                );
              }
              newRawDb.close();
            } catch (e, st) {
              LoggerService.error('فشل استرجاع الإشارات المرجعية في قاعدة البيانات الجديدة', e, st);
            }
          }

          await prefs.setInt(AppConstants.prefInstalledDbVersion, AppConstants.currentDbVersion);
        } catch (e, st) {
          LoggerService.error('فشل تثبيت أو تحديث ملف قاعدة البيانات', e, st);
        }
      }

      return NativeDatabase.createInBackground(
        file,
        setup: (rawDb) {
          rawDb.execute('PRAGMA journal_mode=WAL;');
          rawDb.execute('PRAGMA synchronous=NORMAL;');
          rawDb.execute('PRAGMA foreign_keys=ON;');
          rawDb.execute('PRAGMA temp_store=MEMORY;');
          rawDb.execute('PRAGMA cache_size=-65536;'); // 64 MB
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


