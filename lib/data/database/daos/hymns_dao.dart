import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/hymns_tables.dart';

part 'hymns_dao.g.dart';

@DriftAccessor(tables: [HymnBooks, Hymns, HymnSegments])
class HymnsDao extends DatabaseAccessor<AppDatabase> with _$HymnsDaoMixin {
  HymnsDao(super.db);

  /// جلب كل كتب الألحان (مجلدات أسامة لطفي)
  Future<List<HymnBook>> getAllBooks() {
    return (select(hymnBooks)..orderBy([(b) => OrderingTerm.asc(b.bookOrder)])).get();
  }

  /// جلب كتاب معين
  Future<HymnBook> getBook(String bookId) {
    return (select(hymnBooks)..where((b) => b.id.equals(bookId))).getSingle();
  }

  /// جلب ألحان كتاب معين
  Future<List<Hymn>> getHymnsForBook(String bookId) {
    return (select(hymns)
          ..where((h) => h.bookId.equals(bookId))
          ..orderBy([(h) => OrderingTerm.asc(h.hymnOrder)]))
        .get();
  }

  /// جلب ألحان تصنيف أو مناسبة أو مجلد معين
  Future<List<Hymn>> getHymnsForCategory(String categoryId) {
    final query = select(hymns);
    if (categoryId.startsWith('osama_lotfy_')) {
      query.where((h) => h.bookId.equals(categoryId));
    } else {
      switch (categoryId) {
        case 'annual':
          query.where((h) => h.bookId.equals('osama_lotfy_01') | h.bookId.equals('osama_lotfy_02') | h.tone.equals('annual') | h.occasion.equals('liturgy'));
          break;
        case 'kiahk':
          query.where((h) => h.bookId.equals('osama_lotfy_03') | h.tone.equals('kiahki'));
          break;
        case 'lent':
          query.where((h) => h.bookId.equals('osama_lotfy_04') | h.bookId.equals('osama_lotfy_05') | h.tone.equals('lenten'));
          break;
        case 'pascha':
          query.where((h) => h.bookId.equals('osama_lotfy_04') | h.bookId.equals('osama_lotfy_07') | h.bookId.equals('osama_lotfy_08') | h.occasion.equals('burial'));
          break;
        case 'resurrection':
          query.where((h) => h.bookId.equals('osama_lotfy_03') | h.bookId.equals('osama_lotfy_09') | h.tone.equals('festive'));
          break;
        case 'tasbeha':
          query.where((h) => h.bookId.equals('osama_lotfy_01') | h.occasion.equals('matins'));
          break;
        default:
          query.where((h) => h.bookId.equals(categoryId) | h.occasion.equals(categoryId) | h.tone.equals(categoryId));
          break;
      }
    }
    query.orderBy([(h) => OrderingTerm.asc(h.hymnOrder)]);
    return query.get();
  }

  /// جلب لحن بالمعرف
  Future<Hymn> getHymn(String hymnId) {
    return (select(hymns)..where((h) => h.id.equals(hymnId))).getSingle();
  }

  /// جلب قائمة ألحان بمعرفاتها
  Future<List<Hymn>> getHymnsByIds(List<String> ids) {
    if (ids.isEmpty) return Future.value([]);
    return (select(hymns)
          ..where((h) => h.id.isIn(ids))
          ..orderBy([(h) => OrderingTerm.asc(h.hymnOrder)]))
        .get();
  }

  /// جلب مقاطع وهزات اللحن مرتبة
  Future<List<HymnSegment>> getSegmentsForHymn(String hymnId) {
    return (select(hymnSegments)
          ..where((s) => s.hymnId.equals(hymnId))
          ..orderBy([(s) => OrderingTerm.asc(s.segmentOrder)]))
        .get();
  }
}
