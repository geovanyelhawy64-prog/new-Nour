import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/liturgy_repository.dart';

final liturgyRepositoryProvider = Provider((ref) => LiturgyRepository());

final allLiturgiesProvider = FutureProvider<List<Liturgy>>((ref) {
  return ref.read(liturgyRepositoryProvider).getAllLiturgies();
});

final liturgySectionsProvider = FutureProvider.family<
    List<LiturgySection>,
    String>((ref, liturgyId) {
  return ref.read(liturgyRepositoryProvider).getSections(liturgyId);
});

final liturgyPartsProvider = FutureProvider.family<
    List<LiturgyPart>,
    String>((ref, sectionId) {
  return ref.read(liturgyRepositoryProvider).getParts(sectionId);
});
