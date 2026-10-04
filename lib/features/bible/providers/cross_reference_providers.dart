import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/cross_reference_repository.dart';

final crossReferenceRepositoryProvider = Provider(
  (ref) => CrossReferenceRepository(),
);

final crossReferencesProvider = FutureProvider.family<
    List<({int bookId, int chapter, int verse, String text, String bookName})>,
    ({int bookId, int chapter, int verse})>((ref, params) {
  return ref.read(crossReferenceRepositoryProvider).getCrossReferences(
        params.bookId,
        params.chapter,
        params.verse,
      );
});
