import 'package:drift/drift.dart';
import '../../../core/utils/search_normalizer.dart';
import '../app_database.dart';
import '../tables/theology_tables.dart';

part 'theology_dao.g.dart';

@DriftAccessor(tables: [TheologyArticles])
class TheologyDao extends DatabaseAccessor<AppDatabase> with _$TheologyDaoMixin {
  TheologyDao(super.db);

  /// جلب كافة المقالات اللاهوتية والعقائدية
  Future<List<TheologyArticle>> getAllArticles() {
    return (select(theologyArticles)
          ..orderBy([
            (t) => OrderingTerm.asc(t.category),
            (t) => OrderingTerm.asc(t.articleOrder),
          ]))
        .get();
  }

  /// جلب المقالات حسب الفئة مع دعم الأسماء البديلة والتوافق الكامل
  Future<List<TheologyArticle>> getArticlesByCategory(String category) {
    String primary = category;
    String alias = category;
    if (category == 'nature_of_christ' || category == 'incarnation') {
      primary = 'incarnation';
      alias = 'nature_of_christ';
    } else if (category == 'intercession' || category == 'theotokos') {
      primary = 'theotokos';
      alias = 'intercession';
    } else if (category == 'councils' || category == 'ecumenical_councils') {
      primary = 'ecumenical_councils';
      alias = 'councils';
    }

    return (select(theologyArticles)
          ..where((t) => t.category.equals(primary) | t.category.equals(alias))
          ..orderBy([(t) => OrderingTerm.asc(t.articleOrder)]))
        .get();
  }

  /// جلب مقال بالمعرف
  Future<TheologyArticle?> getArticleById(String id) {
    return (select(theologyArticles)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// بحث في المقالات اللاهوتية والعقائدية بدون تشكيل
  Future<List<TheologyArticle>> searchArticles(String query) async {
    final all = await getAllArticles();
    if (query.trim().isEmpty) return all;

    return all.where((article) {
      return SearchNormalizer.matches(article.title, query) ||
          SearchNormalizer.matches(article.content, query) ||
          SearchNormalizer.matches(article.categoryAr, query);
    }).toList();
  }
}
