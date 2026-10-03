import '../models/search_result.dart';
import '../../core/services/database_service.dart';

class SearchRepository {
  final _db = DatabaseService.instance;

  Future<List<SearchResult>> search(
    String query, {
    String? filterType,
  }) async {
    final rows = await _db.searchDao.globalSearch(
      query,
      filterType: filterType,
    );
    return rows
        .map((r) => SearchResult(
              type: r.type,
              typeAr: r.typeAr,
              id: r.id,
              title: r.title,
              snippet: r.snippet,
            ))
        .toList();
  }
}
