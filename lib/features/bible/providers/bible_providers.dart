import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/bible_repository.dart';

final bibleRepositoryProvider = Provider((ref) => BibleRepository());

final oldTestamentBooksProvider = FutureProvider<List<BibleBook>>((ref) {
  return ref.read(bibleRepositoryProvider).getBooksByTestament('old');
});

final newTestamentBooksProvider = FutureProvider<List<BibleBook>>((ref) {
  return ref.read(bibleRepositoryProvider).getBooksByTestament('new');
});

final deuteroBooksProvider = FutureProvider<List<BibleBook>>((ref) {
  return ref.read(bibleRepositoryProvider).getBooksByTestament('deutero');
});

final booksByTestamentProvider = FutureProvider.family<List<BibleBook>, String>((ref, testament) {
  return ref.read(bibleRepositoryProvider).getBooksByTestament(testament);
});

final chapterVersesProvider = FutureProvider.family<
    List<BibleVerse>,
    ({int bookId, int chapter})>((ref, params) {
  return ref
      .read(bibleRepositoryProvider)
      .getChapterVerses(params.bookId, params.chapter);
});

final bookInfoProvider = FutureProvider.family<BibleBook, int>((ref, bookId) {
  return ref.read(bibleRepositoryProvider).getBook(bookId);
});

final bibleSearchProvider = FutureProvider.family<
    List<BibleVerse>,
    String>((ref, query) {
  if (query.trim().isEmpty) return Future.value([]);
  return ref.read(bibleRepositoryProvider).search(query);
});

final chapterHighlightsProvider = FutureProvider.family<
    Map<int, String>,
    ({int bookId, int chapter})>((ref, params) {
  return ref
      .read(bibleRepositoryProvider)
      .getChapterHighlights(params.bookId, params.chapter);
});
