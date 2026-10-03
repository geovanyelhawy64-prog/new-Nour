import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/psali.dart';
import '../../../data/repositories/psali_repository.dart';

final psaliRepositoryProvider = Provider((ref) => PsaliRepository());

final hosProvider = FutureProvider<List<Psali>>((ref) {
  return ref.read(psaliRepositoryProvider).getHos();
});

final theotokiaProvider = FutureProvider.family<List<Psali>, String>(
  (ref, dayOfWeek) {
    return ref.read(psaliRepositoryProvider).getTheotokiaByDay(dayOfWeek);
  },
);

final kiahkiMadihatProvider = FutureProvider<List<Psali>>((ref) {
  return ref.read(psaliRepositoryProvider).getKiahkiMadihat();
});

final psalmodyProvider = FutureProvider<List<Psali>>((ref) {
  return ref.read(psaliRepositoryProvider).getPsalmody();
});

final psaliByTypeProvider = FutureProvider.family<List<Psali>, String>(
  (ref, type) {
    return ref.read(psaliRepositoryProvider).getByType(type);
  },
);

final psaliSectionsProvider = FutureProvider.family<List<PsaliSection>, String>(
  (ref, psaliId) {
    return ref.read(psaliRepositoryProvider).getSections(psaliId);
  },
);

final psaliCountProvider = FutureProvider<int>((ref) {
  return ref.read(psaliRepositoryProvider).getCount();
});
