import 'dart:io';
import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/data/database/app_database.dart';
import 'package:noor_app/data/database/user_data_store.dart';

void main() {
  late AppDatabase db;

  setUpAll(() {
    drift.driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  setUp(() {
    // قاعدة بيانات سريعة في الذاكرة للاختبار
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('Drift Database & DAOs Unit Tests', () {
    test('BibleDao can insert and retrieve books and verses', () async {
      // 1. Insert Genesis
      final bookId = await db.into(db.bibleBooks).insert(
            BibleBooksCompanion.insert(
              nameAr: 'التكوين',
              nameEn: 'Genesis',
              testament: 'old',
              testamentAr: 'العهد القديم',
              category: 'law',
              categoryAr: 'التوراة',
              bookOrder: 1,
              chapterCount: 50,
            ),
          );

      // 2. Insert verse 1:1
      await db.into(db.bibleVerses).insert(
            BibleVersesCompanion.insert(
              bookId: bookId,
              chapter: 1,
              verseNumber: 1,
              content: 'في البدء خلق الله السماوات والارض',
            ),
          );

      // 3. Query via BibleDao
      final book = await db.bibleDao.getBook(bookId);
      expect(book.nameAr, 'التكوين');

      final verses = await db.bibleDao.getChapterVerses(bookId, 1);
      expect(verses.length, 1);
      expect(verses.first.content, contains('خلق الله'));

      // 4. Search via BibleDao
      final searchResults = await db.bibleDao.searchVerses('السماوات');
      expect(searchResults.length, 1);
    });

    test('AgpeyaDao can insert and retrieve hours and sections', () async {
      // 1. Insert Prime Hour (باكر)
      await db.into(db.agpeyaHours).insert(
            AgpeyaHoursCompanion.insert(
              id: 'prime',
              nameAr: 'صلاة باكر',
              nameEn: 'Prime',
              hourOrder: 1,
              description: const drift.Value('تذكار قيامة ربنا يسوع المسيح'),
            ),
          );

      // 2. Insert Section
      await db.into(db.agpeyaSections).insert(
            const AgpeyaSectionsCompanion(
              hourId: drift.Value('prime'),
              sectionOrder: drift.Value(1),
              type: drift.Value('introduction'),
              title: drift.Value('مقدمة الصلوات'),
              role: drift.Value('all'),
              textAr: drift.Value('باسم الآب والابن والروح القدس، إله واحد. آمين.'),
            ),
          );

      // 3. Query via AgpeyaDao
      final hours = await db.agpeyaDao.getAllHours();
      expect(hours.length, 1);
      expect(hours.first.nameAr, 'صلاة باكر');

      final sections = await db.agpeyaDao.getSectionsForHour('prime');
      expect(sections.length, 1);
      expect(sections.first.title, 'مقدمة الصلوات');
    });

    test('Bookmarks (user store) supports adding, querying, and checking status', () async {
      final userStore = UserDataStore.memory();
      // 1. Add Bookmark
      final id = await userStore.addBookmark(
        contentType: 'bible',
        contentId: '1_1_1',
        displayTitle: 'التكوين 1:1',
        note: 'آية الخليقة',
      );
      expect(id, isPositive);

      // 2. Check isBookmarked
      final exists = await userStore.isBookmarked('bible', '1_1_1');
      expect(exists, isTrue);

      final notExists = await userStore.isBookmarked('bible', '1_1_2');
      expect(notExists, isFalse);

      // 3. Remove Bookmark
      await userStore.removeBookmark(id);
      final existsAfterDelete = await userStore.isBookmarked('bible', '1_1_1');
      expect(existsAfterDelete, isFalse);
    });

    test('SearchDao performs normalized cross-module search', () async {
      // Insert a saint
      await db.into(db.saints).insert(
            SaintsCompanion.insert(
              id: 'st_george',
              nameAr: 'الشهيد مارجرجس الروماني',
              type: 'martyr',
              biography: 'أمير الشهداء القديس العظيم مارجرجس',
              shortBio: 'أمير الشهداء',
            ),
          );

      // Search with normalized query (e.g. searching 'مارجرجس' or 'الشهيد')
      final results = await db.searchDao.globalSearch('مارجرجس');
      expect(results.length, 1);
      expect(results.first.type, 'saints');
      expect(results.first.title, 'الشهيد مارجرجس الروماني');
    });

    test('LiturgyDao supports inserting, querying, and filtering by role and secret', () async {
      // 1. Insert Liturgy
      await db.into(db.liturgies).insert(
            const LiturgiesCompanion(
              id: drift.Value('basil'),
              nameAr: drift.Value('القداس الباسيلي'),
              nameEn: drift.Value('Liturgy of St. Basil'),
              liturgyOrder: drift.Value(1),
            ),
          );

      // 2. Insert Section
      await db.into(db.liturgySections).insert(
            const LiturgySectionsCompanion(
              id: drift.Value('sec_recon'),
              liturgyId: drift.Value('basil'),
              nameAr: drift.Value('صلاة الصلح'),
              sectionOrder: drift.Value(1),
            ),
          );

      // 3. Insert Parts
      await db.into(db.liturgyParts).insert(
            const LiturgyPartsCompanion(
              sectionId: drift.Value('sec_recon'),
              partOrder: drift.Value(1),
              role: drift.Value('priest'),
              type: drift.Value('prayer'),
              textAr: drift.Value('صلوا من أجل السلام الكامل والمحبة'),
              isSecret: drift.Value(false),
            ),
          );

      await db.into(db.liturgyParts).insert(
            const LiturgyPartsCompanion(
              sectionId: drift.Value('sec_recon'),
              partOrder: drift.Value(2),
              role: drift.Value('priest'),
              type: drift.Value('prayer'),
              textAr: drift.Value('صلاة سرية خاصة بالأب الكاهن'),
              isSecret: drift.Value(true),
            ),
          );

      await db.into(db.liturgyParts).insert(
            const LiturgyPartsCompanion(
              sectionId: drift.Value('sec_recon'),
              partOrder: drift.Value(3),
              role: drift.Value('deacon'),
              type: drift.Value('response'),
              textAr: drift.Value('قبلوا بعضكم بعضاً بقبلة مقدسة'),
              isSecret: drift.Value(false),
            ),
          );

      // Query all parts
      final allParts = await db.liturgyDao.getPartsForSection('sec_recon', includeSecret: true);
      expect(allParts.length, 3);

      // Filter out secret prayers
      final noSecretParts = await db.liturgyDao.getPartsForSection('sec_recon', includeSecret: false);
      expect(noSecretParts.length, 2);
      expect(noSecretParts.any((p) => p.isSecret), isFalse);

      // Filter by role (deacon only)
      final deaconParts = await db.liturgyDao.getPartsForSection('sec_recon', roleFilter: 'deacon');
      expect(deaconParts.length, 1);
      expect(deaconParts.first.role, 'deacon');

      // Test getFullLiturgyParts
      final fullParts = await db.liturgyDao.getFullLiturgyParts('basil', includeSecret: true);
      expect(fullParts.length, 3);
      expect(fullParts.first.section.nameAr, 'صلاة الصلح');
    });

    test('Pre-populated assets/databases/noor.db contains complete 73 books, 35k verses, 323 Agpeya sections, and 4 Liturgies', () async {
      final file = File('assets/databases/noor.db');
      expect(file.existsSync(), isTrue);

      final assetDb = AppDatabase(NativeDatabase(file));
      final books = await assetDb.bibleDao.getAllBooks();
      expect(books.length, 73);

      final oldTestament = await assetDb.bibleDao.getBooksByTestament('old');
      expect(oldTestament.length, 39);

      final deutero = await assetDb.bibleDao.getBooksByTestament('deutero');
      expect(deutero.length, 7);

      final newTestament = await assetDb.bibleDao.getBooksByTestament('new');
      expect(newTestament.length, 27);

      // Check Genesis 1
      final genesisVerses = await assetDb.bibleDao.getChapterVerses(1, 1);
      expect(genesisVerses.length, 31);
      expect(genesisVerses.first.content, contains('الله'));

      // Check Matthew 1
      final matthewVerses = await assetDb.bibleDao.getChapterVerses(47, 1);
      expect(matthewVerses.length, 25);
      expect(matthewVerses.first.content, contains('يسوع المسيح'));

      // Check Agpeya Hours & complete sections
      final hours = await assetDb.agpeyaDao.getAllHours();
      expect(hours.length, 8);

      final primeSections = await assetDb.agpeyaDao.getSectionsForHour('prime');
      expect(primeSections.length, 43);

      final terceSections = await assetDb.agpeyaDao.getSectionsForHour('terce');
      expect(terceSections.length, 29);

      // Check Liturgies
      final liturgies = await assetDb.liturgyDao.getAllLiturgies();
      expect(liturgies.length, 4);

      final basilLiturgy = await assetDb.liturgyDao.getLiturgy('basil');
      expect(basilLiturgy.nameAr, 'القداس الباسيلي');

      final basilSections = await assetDb.liturgyDao.getSectionsForLiturgy('basil');
      expect(basilSections.length, 50);

      final basilParts = await assetDb.liturgyDao.getFullLiturgyParts('basil', includeSecret: true);
      expect(basilParts.length, greaterThan(400));

      final gregoryParts = await assetDb.liturgyDao.getFullLiturgyParts('gregory', includeSecret: true);
      expect(gregoryParts.length, greaterThan(400));

      // Check Hymns Books & Canonical Hymns from manuscripts (Deacon Osama Lotfy 11 volumes)
      final hymnBooks = await assetDb.hymnsDao.getAllBooks();
      expect(hymnBooks.length, 11);

      final volume2Hymns = await assetDb.hymnsDao.getHymnsForBook('osama_lotfy_02');
      expect(volume2Hymns.length, 10);
      expect(volume2Hymns.first.nameAr, contains('إبؤرو'));

      final epouroSegments = await assetDb.hymnsDao.getSegmentsForHymn('ol02_01');
      expect(epouroSegments.length, 2);
      expect(epouroSegments.first.syllablesJson, isNotNull);
      expect(epouroSegments.first.coptic, contains('Ⲉⲡⲟⲩⲣⲟ'));

      // Verify category query
      final paschaHymns = await assetDb.hymnsDao.getHymnsForCategory('pascha');
      expect(paschaHymns.any((h) => h.id == 'ol07_01'), isTrue);

      // Check Synaxarium (السنكسار القبطي المقدس)
      final thout1Entries = await assetDb.synaxariumDao.getEntriesForDay(1, 1);
      expect(thout1Entries.length, 5);
      expect(thout1Entries.first.title, contains('النيروز'));
      expect(thout1Entries.first.fullText, contains('تقويم الشهداء'));

      final bartholomewSearch = await assetDb.synaxariumDao.searchEntries('برثولماوس');
      expect(bartholomewSearch.isNotEmpty, isTrue);

      // Check Katameros (القطمارس اليومي)
      final thout1Readings = await assetDb.katamerosDao.getReadingsForDay(1, 1);
      expect(thout1Readings.length, greaterThanOrEqualTo(7));

      final liturgyReadings = await assetDb.katamerosDao.getReadingsForService(1, 1, 'liturgy');
      expect(liturgyReadings.length, 5); // pauline, catholic, acts, psalm, gospel

      final pauline = await assetDb.katamerosDao.getSpecificReading(1, 1, 'liturgy', 'pauline');
      expect(pauline, isNotNull);
      expect(pauline!.reference, contains('كورنثوس'));
      expect(pauline.content.length, greaterThan(100));

      // Check Pascha (البصخة المقدسة وأسبوع الآلام)
      final mondayDay1 = await assetDb.paschaDao.getReadingsForHour('monday_day', 1);
      expect(mondayDay1.length, 11);
      expect(mondayDay1.first.readingType, 'prophecy');
      expect(mondayDay1.any((r) => r.readingType == 'hymn'), isTrue);

      final goodFriday12 = await assetDb.paschaDao.getReadingsForHour('good_friday', 12);
      expect(goodFriday12.isNotEmpty, isTrue);

      final prophecies = await assetDb.paschaDao.getProphecies('monday_day', 1);
      expect(prophecies.isNotEmpty, isTrue);
      expect(prophecies.first.content, contains('الْتَّكْوِينِ'));

      await assetDb.close();
    });

    test('HymnsDao supports inserting, querying by category, and segment notations in memory', () async {
      // 1. Insert book
      await db.into(db.hymnBooks).insert(
            const HymnBooksCompanion(
              id: drift.Value('annual'),
              nameAr: drift.Value('كتاب الألحان السنوية'),
              bookOrder: drift.Value(1),
            ),
          );

      // 2. Insert hymn
      await db.into(db.hymns).insert(
            const HymnsCompanion(
              id: drift.Value('epouro'),
              bookId: drift.Value('annual'),
              nameAr: drift.Value('لحن إبؤرو'),
              nameCoptic: drift.Value('Ⲉⲡⲟⲩⲣⲟ'),
              occasion: drift.Value('liturgy'),
              tone: drift.Value('annual'),
              hymnOrder: drift.Value(1),
            ),
          );

      // 3. Insert segment with syllables notation
      await db.into(db.hymnSegments).insert(
            const HymnSegmentsCompanion(
              hymnId: drift.Value('epouro'),
              segmentOrder: drift.Value(1),
              lineNumber: drift.Value(1),
              coptic: drift.Value('Ⲉⲡⲟⲩⲣⲟ ⲛ̀ⲧⲉ ϯϩⲓⲣⲏⲛⲏ'),
              phonetic: drift.Value('إبؤرو إنتي تي هيريني'),
              arabic: drift.Value('يا ملك السلام'),
              syllablesJson: drift.Value('[{"s":"إب","c":"Ⲉ","v":2,"p":"medium","ms":800}]'),
            ),
          );

      // 4. Query via HymnsDao
      final books = await db.hymnsDao.getAllBooks();
      expect(books.length, 1);
      expect(books.first.id, 'annual');

      final hymns = await db.hymnsDao.getHymnsForBook('annual');
      expect(hymns.length, 1);
      expect(hymns.first.nameAr, 'لحن إبؤرو');

      final categoryHymns = await db.hymnsDao.getHymnsForCategory('annual');
      expect(categoryHymns.length, 1);

      final segments = await db.hymnsDao.getSegmentsForHymn('epouro');
      expect(segments.length, 1);
      expect(segments.first.coptic, contains('Ⲉⲡⲟⲩⲣⲟ'));
      expect(segments.first.syllablesJson, contains('medium'));
    });

    test('FeastsDao supports querying major, minor, fasts, and movable feasts', () async {
      // 1. Insert sample feasts
      await db.into(db.feastsAndFasts).insert(
            const FeastsAndFastsCompanion(
              id: drift.Value('nativity'),
              nameAr: drift.Value('عيد الميلاد المجيد'),
              type: drift.Value('major_feast'),
              copticMonth: drift.Value(4),
              copticDay: drift.Value(29),
              isMovable: drift.Value(false),
              rite: drift.Value('festive'),
              description: drift.Value('ميلاد مخلصنا الصالح بالجسد'),
              durationDays: drift.Value(1),
            ),
          );

      await db.into(db.feastsAndFasts).insert(
            const FeastsAndFastsCompanion(
              id: drift.Value('circumcision'),
              nameAr: drift.Value('عيد الختان المجيد'),
              type: drift.Value('minor_feast'),
              copticMonth: drift.Value(5),
              copticDay: drift.Value(6),
              isMovable: drift.Value(false),
              rite: drift.Value('festive'),
              description: drift.Value('ختان الطفل يسوع في اليوم الثامن'),
              durationDays: drift.Value(1),
            ),
          );

      await db.into(db.feastsAndFasts).insert(
            const FeastsAndFastsCompanion(
              id: drift.Value('great_lent'),
              nameAr: drift.Value('الصوم الكبير'),
              type: drift.Value('fast'),
              isMovable: drift.Value(true),
              calculationRule: drift.Value('easter - 55'),
              rite: drift.Value('lenten'),
              description: drift.Value('أقدس أصوام السنة ٥٥ يوماً'),
              durationDays: drift.Value(55),
            ),
          );

      // 2. Test queries
      final all = await db.feastsDao.getAllFeastsAndFasts();
      expect(all.length, 3);

      final major = await db.feastsDao.getMajorFeasts();
      expect(major.length, 1);
      expect(major.first.id, 'nativity');

      final minor = await db.feastsDao.getMinorFeasts();
      expect(minor.length, 1);
      expect(minor.first.id, 'circumcision');

      final fasts = await db.feastsDao.getFasts();
      expect(fasts.length, 1);
      expect(fasts.first.id, 'great_lent');

      final movable = await db.feastsDao.getMovable();
      expect(movable.length, 1);
      expect(movable.first.calculationRule, 'easter - 55');

      final kiahkFeasts = await db.feastsDao.getForMonth(4);
      expect(kiahkFeasts.length, 1);
      expect(kiahkFeasts.first.nameAr, 'عيد الميلاد المجيد');
    });

    test('PrayersDao supports querying, filtering by category, and text search', () async {
      // 1. Insert sample occasional prayers
      await db.into(db.occasionalPrayers).insert(
            const OccasionalPrayersCompanion(
              id: drift.Value('communion_before'),
              category: drift.Value('communion'),
              categoryAr: drift.Value('صلوات التناول المقدس'),
              title: drift.Value('صلاة قبل التناول'),
              content: drift.Value('يا رب إني غير مستحق أن تدخل تحت سقف بيتي...'),
              prayerOrder: drift.Value(1),
            ),
          );

      await db.into(db.occasionalPrayers).insert(
            const OccasionalPrayersCompanion(
              id: drift.Value('study_exam'),
              category: drift.Value('study'),
              categoryAr: drift.Value('صلوات الطلبة والدارسين'),
              title: drift.Value('صلاة قبل دخول الامتحان'),
              content: drift.Value('يا إلهي القدير، أعطني حكمة وفهماً في هذا الامتحان...'),
              prayerOrder: drift.Value(2),
            ),
          );

      // 2. Test queries
      final allPrayers = await db.prayersDao.getAllPrayers();
      expect(allPrayers.length, 2);

      final communionPrayers = await db.prayersDao.getPrayersByCategory('communion');
      expect(communionPrayers.length, 1);
      expect(communionPrayers.first.title, 'صلاة قبل التناول');

      final prayer = await db.prayersDao.getPrayerById('study_exam');
      expect(prayer, isNotNull);
      expect(prayer!.category, 'study');

      // 3. Search query
      final searchResults = await db.prayersDao.searchPrayers('الامتحان');
      expect(searchResults.length, 1);
      expect(searchResults.first.id, 'study_exam');
    });

    test('SacramentsDao supports querying sacraments, sections, and search', () async {
      // 1. Insert sample sacrament
      await db.into(db.sacraments).insert(
            const SacramentsCompanion(
              id: drift.Value('baptism'),
              nameAr: drift.Value('سر المعمودية المقدس'),
              sacramentOrder: drift.Value(1),
            ),
          );

      // 2. Insert sample sacrament section
      await db.into(db.sacramentSections).insert(
            const SacramentSectionsCompanion(
              sacramentId: drift.Value('baptism'),
              title: drift.Value('التعريف والمعنى اللاهوتي'),
              content: drift.Value('المعمودية هي باب الأسرار والولادة من الماء والروح'),
              scriptures: drift.Value('يوحنا ٣: ٥'),
              sectionOrder: drift.Value(1),
            ),
          );

      // 3. Test queries
      final all = await db.sacramentsDao.getAllSacraments();
      expect(all.length, 1);
      expect(all.first.id, 'baptism');

      final sacrament = await db.sacramentsDao.getSacramentById('baptism');
      expect(sacrament, isNotNull);
      expect(sacrament!.nameAr, 'سر المعمودية المقدس');

      final sections = await db.sacramentsDao.getSectionsForSacrament('baptism');
      expect(sections.length, 1);
      expect(sections.first.title, 'التعريف والمعنى اللاهوتي');
      expect(sections.first.scriptures, 'يوحنا ٣: ٥');

      // 4. Test search
      final searchRes = await db.sacramentsDao.searchSections('الماء والروح');
      expect(searchRes.length, 1);
      expect(searchRes.first.sacramentId, 'baptism');
    });

    test('SaintsDao supports querying by type, id, coptic month and diacritic-insensitive search', () async {
      await db.into(db.saints).insert(
            const SaintsCompanion(
              id: drift.Value('saint_george'),
              nameAr: drift.Value('الشهيد العظيم مارجرجس الروماني'),
              nameCoptic: drift.Value('Ⲡⲓⲁⲅⲓⲟⲥ Ⲅⲉⲱⲣⲅⲓⲟⲥ'),
              nameEn: drift.Value('Saint George'),
              type: drift.Value('martyrs'),
              feastMonth: drift.Value(8),
              feastDay: drift.Value(23),
              biography: drift.Value('أمير الشهداء القديس جاورجيوس الروماني استشهد في عهد دقلديانوس.'),
              shortBio: drift.Value('أمير الشهداء وكوكب الصبح المنير'),
            ),
          );

      await db.into(db.saints).insert(
            const SaintsCompanion(
              id: drift.Value('saint_anthony'),
              nameAr: drift.Value('القديس العظيم أنبا أنطونيوس كوكب البرية'),
              nameCoptic: drift.Value('Ⲁⲃⲃⲁ Ⲁⲛⲧⲱⲛⲓ'),
              nameEn: drift.Value('Saint Anthony'),
              type: drift.Value('monks'),
              feastMonth: drift.Value(5),
              feastDay: drift.Value(22),
              biography: drift.Value('أبو الرهبان ومؤسس الرهبنة في العالم كله ولد بقمن العروس.'),
              shortBio: drift.Value('أبو الرهبان في العالم'),
            ),
          );

      // 1. All saints
      final all = await db.saintsDao.getAllSaints();
      expect(all.length, 2);

      // 2. Query by type
      final martyrs = await db.saintsDao.getSaintsByType('martyrs');
      expect(martyrs.length, 1);
      expect(martyrs.first.id, 'saint_george');

      final monks = await db.saintsDao.getSaintsByType('monks');
      expect(monks.length, 1);
      expect(monks.first.id, 'saint_anthony');

      // 3. Query by id
      final stGeorge = await db.saintsDao.getSaintById('saint_george');
      expect(stGeorge, isNotNull);
      expect(stGeorge!.nameEn, 'Saint George');
      expect(stGeorge.feastMonth, 8);

      // 4. Query by month
      final month5Saints = await db.saintsDao.getSaintsForMonth(5);
      expect(month5Saints.length, 1);
      expect(month5Saints.first.id, 'saint_anthony');

      // 5. Search with/without tashkeel
      final searchResults = await db.saintsDao.searchSaints('مارجرجس');
      expect(searchResults.length, 1);
      expect(searchResults.first.id, 'saint_george');

      final searchBio = await db.saintsDao.searchSaints('الرهبنة');
      expect(searchBio.length, 1);
      expect(searchBio.first.id, 'saint_anthony');
    });

    test('DifnarDao supports day, month queries, search and retrieval', () async {
      await db.into(db.difnarEntries).insert(
            const DifnarEntriesCompanion(
              id: drift.Value('difnar_01_01_001'),
              copticMonth: drift.Value(1),
              copticDay: drift.Value(1),
              textCoptic: drift.Value('Ⲡⲓⲁⲅⲓⲟⲥ Ⲅⲉⲱⲣⲅⲓⲟⲥ'),
              textPhonetic: drift.Value('بي أجيوس جيؤرجيوس'),
              textAr: drift.Value('الشهيد مارجرجس\n\nطرح واطس يرتل في عيده المبارك'),
            ),
          );

      await db.into(db.difnarEntries).insert(
            const DifnarEntriesCompanion(
              id: drift.Value('difnar_01_02_002'),
              copticMonth: drift.Value(1),
              copticDay: drift.Value(2),
              textCoptic: drift.Value('Ⲁⲃⲃⲁ Ⲁⲛⲧⲱⲛⲓ'),
              textPhonetic: drift.Value('أفّا أنطوني'),
              textAr: drift.Value('الأنبا أنطونيوس\n\nطرح آدام لأبي الرهبان'),
            ),
          );

      // 1. All difnar
      final all = await db.difnarDao.getAllDifnar();
      expect(all.length, 2);

      // 2. Entries for day
      final day1 = await db.difnarDao.getEntriesForDay(1, 1);
      expect(day1.length, 1);
      expect(day1.first.id, 'difnar_01_01_001');

      // 3. Entries for month
      final month1 = await db.difnarDao.getEntriesForMonth(1);
      expect(month1.length, 2);

      // 4. By ID
      final entry = await db.difnarDao.getEntryById('difnar_01_01_001');
      expect(entry, isNotNull);
      expect(entry!.textPhonetic, contains('جيؤرجيوس'));

      // 5. Search
      final searchRes = await db.difnarDao.searchDifnar('أنطونيوس');
      expect(searchRes.length, 1);
      expect(searchRes.first.id, 'difnar_01_02_002');
    });

    test('TheologyDao supports querying articles by category, id, and diacritic-insensitive search', () async {
      await db.into(db.theologyArticles).insert(
            const TheologyArticlesCompanion(
              id: drift.Value('theology_christ_nature_01'),
              category: drift.Value('nature_of_christ'),
              categoryAr: drift.Value('طبيعة السيد المسيح'),
              title: drift.Value('عقيدة الطبيعة الواحدة المتجسدة لله الكلمة'),
              content: drift.Value('تؤمن الكنيسة القبطية الأرثوذكسية بالطبيعة الواحدة المتجسدة لله الكلمة بغير اختلاط ولا امتزاج ولا تغيير.'),
              articleOrder: drift.Value(1),
            ),
          );

      await db.into(db.theologyArticles).insert(
            const TheologyArticlesCompanion(
              id: drift.Value('theology_salvation_01'),
              category: drift.Value('salvation'),
              categoryAr: drift.Value('مفهوم الخلاص والجهاد'),
              title: drift.Value('عقيدة الخلاص في المفهوم الأرثوذكسي'),
              content: drift.Value('الخلاص يقوم على الفداء المجاني بدم المسيح والإيمان الحي العامل بالمحبة والمعمودية والجهاد.'),
              articleOrder: drift.Value(1),
            ),
          );

      // 1. All articles
      final all = await db.theologyDao.getAllArticles();
      expect(all.length, 2);

      // 2. By category
      final christArticles = await db.theologyDao.getArticlesByCategory('nature_of_christ');
      expect(christArticles.length, 1);
      expect(christArticles.first.title, 'عقيدة الطبيعة الواحدة المتجسدة لله الكلمة');

      // 3. By ID
      final article = await db.theologyDao.getArticleById('theology_salvation_01');
      expect(article, isNotNull);
      expect(article!.categoryAr, 'مفهوم الخلاص والجهاد');

      // 4. Search with/without tashkeel
      final searchResults = await db.theologyDao.searchArticles('المتجسدة');
      expect(searchResults.length, 1);
      expect(searchResults.first.id, 'theology_christ_nature_01');

      final searchContent = await db.theologyDao.searchArticles('المعمودية');
      expect(searchContent.length, 1);
      expect(searchContent.first.id, 'theology_salvation_01');
    });
  });
}
