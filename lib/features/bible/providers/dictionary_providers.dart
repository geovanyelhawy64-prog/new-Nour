import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/coptic_dictionary_entry.dart';
import '../../../data/repositories/dictionary_repository.dart';

final dictionaryRepositoryProvider = Provider(
  (ref) => DictionaryRepository(),
);

final dictionarySearchProvider = FutureProvider.family<
    List<CopticDictionaryEntry>, String>((ref, query) {
  if (query.trim().isEmpty) return Future.value([]);
  return ref.read(dictionaryRepositoryProvider).search(query);
});

final dictionaryByLetterProvider = FutureProvider.family<
    List<CopticDictionaryEntry>, String>((ref, letter) {
  return ref.read(dictionaryRepositoryProvider).getByLetter(letter);
});

final dictionaryCountProvider = FutureProvider<int>((ref) {
  return ref.read(dictionaryRepositoryProvider).getCount();
});

final dictionaryLettersProvider = FutureProvider<List<String>>((ref) {
  return ref.read(dictionaryRepositoryProvider).getDistinctLetters();
});
