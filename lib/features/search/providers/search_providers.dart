import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/search_result.dart';
import '../../../data/repositories/search_repository.dart';

final searchRepositoryProvider = Provider((ref) => SearchRepository());

final searchQueryProvider = StateProvider<String>((ref) => '');
final searchFilterProvider = StateProvider<String?>((ref) => null);

final searchResultsProvider = FutureProvider<List<SearchResult>>((ref) {
  final query = ref.watch(searchQueryProvider);
  final filter = ref.watch(searchFilterProvider);
  if (query.trim().isEmpty) return Future.value([]);
  return ref.read(searchRepositoryProvider).search(
    query,
    filterType: filter,
  );
});
