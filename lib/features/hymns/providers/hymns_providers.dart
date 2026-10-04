import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/hymns_repository.dart';

final hymnsRepositoryProvider = Provider((ref) => HymnsRepository());

final hymnBooksProvider = FutureProvider<List<HymnBook>>((ref) {
  return ref.read(hymnsRepositoryProvider).getAllBooks();
});

final hymnsByCategoryProvider = FutureProvider.family<List<Hymn>, String>((ref, catId) {
  return ref.read(hymnsRepositoryProvider).getHymnsByCategory(catId);
});

final hymnSegmentsProvider = FutureProvider.family<List<HymnSegment>, String>((ref, hymnId) {
  return ref.read(hymnsRepositoryProvider).getHymnSegments(hymnId);
});
