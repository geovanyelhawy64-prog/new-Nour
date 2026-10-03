import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/database_service.dart';
import '../../../data/database/app_database.dart' hide Rite, RiteSection;
import '../../../data/models/rite.dart';
import '../../../data/repositories/rite_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => DatabaseService.instance);

final riteRepositoryProvider = Provider<RiteRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return RiteRepository(db.riteDao);
});

final allRitesProvider = FutureProvider<List<Rite>>((ref) =>
    ref.watch(riteRepositoryProvider).getAllRites());

final ritesByCategoryProvider =
    FutureProvider.family<List<Rite>, String>((ref, cat) =>
        ref.watch(riteRepositoryProvider).getByCategory(cat));

final riteByIdProvider =
    FutureProvider.family<Rite?, int>((ref, id) =>
        ref.watch(riteRepositoryProvider).getById(id));

final riteSectionsProvider =
    FutureProvider.family<List<RiteSection>, int>((ref, riteId) =>
        ref.watch(riteRepositoryProvider).getSections(riteId));

final riteCountProvider = FutureProvider<int>((ref) =>
    ref.watch(riteRepositoryProvider).getCount());

final riteCategoriesProvider = FutureProvider<List<String>>((ref) =>
    ref.watch(riteRepositoryProvider).getCategories());
