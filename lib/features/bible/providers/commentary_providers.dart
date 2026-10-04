import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/bible_commentary.dart';
import '../../../data/repositories/commentary_repository.dart';

final commentaryRepositoryProvider = Provider(
  (ref) => CommentaryRepository(),
);

final chapterCommentaryProvider = FutureProvider.family<
    List<BibleCommentary>,
    ({int bookId, int chapter})>((ref, params) {
  return ref
      .read(commentaryRepositoryProvider)
      .getChapterCommentary(params.bookId, params.chapter);
});

final verseCommentaryProvider = FutureProvider.family<
    List<BibleCommentary>,
    ({int bookId, int chapter, int verse})>((ref, params) {
  return ref
      .read(commentaryRepositoryProvider)
      .getVerseCommentary(params.bookId, params.chapter, params.verse);
});
