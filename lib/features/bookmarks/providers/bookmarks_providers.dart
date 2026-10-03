import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/bookmarks_repository.dart';

final bookmarksRepositoryProvider = Provider((ref) => BookmarksRepository());

final bookmarksProvider = FutureProvider<List<Bookmark>>((ref) {
  return ref.read(bookmarksRepositoryProvider).getAll();
});

final isBookmarkedProvider = FutureProvider.family<
    bool,
    ({String contentType, String contentId})>((ref, params) {
  return ref.read(bookmarksRepositoryProvider).isBookmarked(
        params.contentType,
        params.contentId,
      );
});
