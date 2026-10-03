import 'package:drift/drift.dart';
import '../../../core/utils/search_normalizer.dart';
import '../../../core/utils/text_utils.dart';
import '../app_database.dart';
import '../tables/agpeya_tables.dart';
import '../tables/bible_tables.dart';
import '../tables/hymns_tables.dart';
import '../tables/liturgy_tables.dart';
import '../tables/prayers_tables.dart';
import '../tables/saints_tables.dart';
import '../tables/synaxarium_tables.dart';
import '../tables/theology_tables.dart';

part 'search_dao.g.dart';

/// نتيجة بحث موحدة
class UnifiedSearchResult {
  final String type; // bible, agpeya, liturgy, hymns, synaxarium, saints, prayers, theology
  final String typeAr;
  final String id;
  final String title;
  final String snippet;

  const UnifiedSearchResult({
    required this.type,
    required this.typeAr,
    required this.id,
    required this.title,
    required this.snippet,
  });
}

@DriftAccessor(tables: [
  BibleVerses,
  BibleBooks,
  AgpeyaSections,
  LiturgyParts,
  Hymns,
  SynaxariumEntries,
  Saints,
  OccasionalPrayers,
  TheologyArticles,
])
class SearchDao extends DatabaseAccessor<AppDatabase> with _$SearchDaoMixin {
  SearchDao(super.db);

  /// بحث شامل في كل المحتوى
  Future<List<UnifiedSearchResult>> globalSearch(
    String rawQuery, {
    String? filterType,
    int limit = 30,
  }) async {
    final query = SearchNormalizer.normalize(rawQuery);
    if (query.isEmpty) return [];

    final results = <UnifiedSearchResult>[];

    if (filterType == null || filterType == 'bible') {
      results.addAll(await _searchBible(query));
    }
    if (filterType == null || filterType == 'agpeya') {
      results.addAll(await _searchAgpeya(query));
    }
    if (filterType == null || filterType == 'liturgy') {
      results.addAll(await _searchLiturgy(query));
    }
    if (filterType == null || filterType == 'hymns') {
      results.addAll(await _searchHymns(query));
    }
    if (filterType == null || filterType == 'synaxarium') {
      results.addAll(await _searchSynaxarium(query));
    }
    if (filterType == null || filterType == 'saints') {
      results.addAll(await _searchSaints(query));
    }
    if (filterType == null || filterType == 'prayers') {
      results.addAll(await _searchPrayers(query));
    }
    if (filterType == null || filterType == 'theology') {
      results.addAll(await _searchTheology(query));
    }
    if (filterType == null || filterType == 'emotions') {
      results.addAll(await _searchEmotions(query));
    }
    if (filterType == null || filterType == 'dictionary') {
      results.addAll(await _searchDictionary(query));
    }
    if (filterType == null || filterType == 'commentary') {
      results.addAll(await _searchCommentaries(query));
    }

    return results.take(limit).toList();
  }

  Future<List<UnifiedSearchResult>> _searchBible(String query) async {
    final matchQuery = SearchNormalizer.toFts5Query(query);
    if (matchQuery.isEmpty) return [];
    final hasFts = await customSelect(
      "SELECT 1 FROM sqlite_master "
      "WHERE type = 'table' AND name = 'bible_verses_fts' LIMIT 1",
    ).getSingleOrNull();

    if (hasFts == null) {
      final verses = await (select(bibleVerses)
            ..where((verse) => verse.content.contains(query))
            ..limit(10))
          .get();
      final results = <UnifiedSearchResult>[];
      for (final verse in verses) {
        final book = await (select(bibleBooks)
              ..where((candidate) => candidate.id.equals(verse.bookId)))
            .getSingle();
        results.add(_bibleResult(verse, book.nameAr, query));
      }
      return results;
    }

    final rows = await customSelect(
      '''
      SELECT v.id, v.book_id, v.chapter, v.verse_number, v.text,
             v.text_with_tashkeel, b.name_ar
      FROM bible_verses_fts
      JOIN bible_verses v ON v.id = bible_verses_fts.verse_id
      JOIN bible_books b ON b.id = v.book_id
      WHERE bible_verses_fts MATCH ?
      ORDER BY bm25(bible_verses_fts), v.id
      LIMIT 10
      ''',
      variables: [Variable<String>(matchQuery)],
      readsFrom: {bibleVerses, bibleBooks},
    ).get();
    return rows
        .map(
          (row) => UnifiedSearchResult(
            type: 'bible',
            typeAr: 'الكتاب المقدس',
            id: '${row.read<int>('book_id')}/${row.read<int>('chapter')}',
            title:
                '${row.read<String>('name_ar')} ${row.read<int>('chapter')}:${row.read<int>('verse_number')}',
            snippet: TextUtils.extractSnippet(row.read<String>('text'), query),
          ),
        )
        .toList();
  }

  UnifiedSearchResult _bibleResult(
    BibleVerse verse,
    String bookName,
    String query,
  ) {
    return UnifiedSearchResult(
      type: 'bible',
      typeAr: 'الكتاب المقدس',
      id: '${verse.bookId}/${verse.chapter}',
      title: '$bookName ${verse.chapter}:${verse.verseNumber}',
      snippet: TextUtils.extractSnippet(verse.content, query),
    );
  }

  Future<List<UnifiedSearchResult>> _searchAgpeya(String query) async {
    final sections = await (select(agpeyaSections)
          ..where((s) => s.textAr.contains(query))
          ..limit(5))
        .get();

    return sections
        .map((s) => UnifiedSearchResult(
              type: 'agpeya',
              typeAr: 'الصلوات',
              id: s.hourId,
              title: s.title,
              snippet: TextUtils.extractSnippet(s.textAr, query),
            ))
        .toList();
  }

  Future<List<UnifiedSearchResult>> _searchLiturgy(String query) async {
    final parts = await (select(liturgyParts)
          ..where((p) => p.textAr.contains(query))
          ..limit(5))
        .get();

    return parts
        .map((p) => UnifiedSearchResult(
              type: 'liturgy',
              typeAr: 'القداس',
              id: p.sectionId,
              title: 'صلاة من القداس',
              snippet: TextUtils.extractSnippet(p.textAr, query),
            ))
        .toList();
  }

  Future<List<UnifiedSearchResult>> _searchHymns(String query) async {
    final hymnsList = await (select(hymns)
          ..where((h) => h.nameAr.contains(query))
          ..limit(5))
        .get();

    return hymnsList
        .map((h) => UnifiedSearchResult(
              type: 'hymns',
              typeAr: 'الألحان',
              id: h.id,
              title: h.nameAr,
              snippet: h.occasion,
            ))
        .toList();
  }

  Future<List<UnifiedSearchResult>> _searchSynaxarium(String query) async {
    final entries = await (select(synaxariumEntries)
          ..where((s) => s.title.contains(query) | s.fullText.contains(query))
          ..limit(5))
        .get();

    return entries
        .map((s) => UnifiedSearchResult(
              type: 'synaxarium',
              typeAr: 'التذكارات',
              id: '${s.copticMonth}/${s.copticDay}',
              title: s.title,
              snippet: TextUtils.extractSnippet(s.shortText, query),
            ))
        .toList();
  }

  Future<List<UnifiedSearchResult>> _searchSaints(String query) async {
    final saintsList = await (select(saints)
          ..where((s) => s.nameAr.contains(query))
          ..limit(5))
        .get();

    return saintsList
        .map((s) => UnifiedSearchResult(
              type: 'saints',
              typeAr: 'القديسين',
              id: s.id,
              title: s.nameAr,
              snippet: s.shortBio,
            ))
        .toList();
  }

  Future<List<UnifiedSearchResult>> _searchPrayers(String query) async {
    final prayersList = await (select(occasionalPrayers)
          ..where((p) => p.title.contains(query) | p.content.contains(query))
          ..limit(5))
        .get();

    return prayersList
        .map((p) => UnifiedSearchResult(
              type: 'prayers',
              typeAr: 'صلوات',
              id: p.category,
              title: p.title,
              snippet: TextUtils.extractSnippet(p.content, query),
            ))
        .toList();
  }

  Future<List<UnifiedSearchResult>> _searchTheology(String query) async {
    final articles = await (select(theologyArticles)
          ..where((t) => t.title.contains(query) | t.content.contains(query))
          ..limit(5))
        .get();

    return articles
        .map((t) => UnifiedSearchResult(
              type: 'theology',
              typeAr: 'العقيدة',
              id: t.id,
              title: t.title,
              snippet: TextUtils.extractSnippet(t.content, query),
            ))
        .toList();
  }

  Future<List<UnifiedSearchResult>> _searchEmotions(String query) async {
    final list = await (db.select(db.emotionPrayers)
          ..where((e) =>
              e.title.contains(query) |
              e.verseText.contains(query) |
              e.meditation.contains(query))
          ..limit(5))
        .get();

    return list
        .map((e) => UnifiedSearchResult(
              type: 'emotions',
              typeAr: 'صيدلية المشاعر',
              id: e.category,
              title: e.title,
              snippet: TextUtils.extractSnippet('${e.verseText} - ${e.meditation}', query),
            ))
        .toList();
  }

  Future<List<UnifiedSearchResult>> _searchDictionary(String query) async {
    final list = await (db.select(db.copticDictionary)
          ..where((d) =>
              d.coptic.contains(query) |
              d.phonetic.contains(query) |
              d.arabic.contains(query) |
              d.english.contains(query))
          ..limit(5))
        .get();

    return list
        .map((d) => UnifiedSearchResult(
              type: 'dictionary',
              typeAr: 'القاموس القبطي',
              id: d.id.toString(),
              title: '${d.coptic} (${d.phonetic}) - ${d.arabic}',
              snippet: d.usage ?? d.arabic,
            ))
        .toList();
  }

  Future<List<UnifiedSearchResult>> _searchCommentaries(String query) async {
    final list = await (db.select(db.bibleCommentaries)
          ..where((c) => c.content.contains(query) | c.summary.contains(query))
          ..limit(5))
        .get();

    final results = <UnifiedSearchResult>[];
    for (final c in list) {
      final book = await (select(bibleBooks)..where((b) => b.id.equals(c.bookId))).getSingleOrNull();
      final bookName = book?.nameAr ?? 'سفر';
      results.add(UnifiedSearchResult(
        type: 'commentary',
        typeAr: 'التفاسير',
        id: '${c.bookId}/${c.chapter}',
        title: 'تفسير $bookName - إصحاح ${c.chapter} (${c.author})',
        snippet: TextUtils.extractSnippet(c.summary.isNotEmpty ? c.summary : c.content, query),
      ));
    }
    return results;
  }
}
