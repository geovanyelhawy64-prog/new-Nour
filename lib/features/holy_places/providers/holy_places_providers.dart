import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/database_service.dart';
import '../../../data/database/app_database.dart' hide HolyPlace;
import '../../../data/models/holy_place.dart';
import '../../../data/repositories/holy_place_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => DatabaseService.instance);

final holyPlaceRepositoryProvider = Provider<HolyPlaceRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return HolyPlaceRepository(db.holyPlaceDao);
});

final allHolyPlacesProvider = FutureProvider<List<HolyPlace>>((ref) =>
    ref.watch(holyPlaceRepositoryProvider).getAll());

final holyPlacesByTypeProvider =
    FutureProvider.family<List<HolyPlace>, String>((ref, type) =>
        ref.watch(holyPlaceRepositoryProvider).getByType(type));

final holyPlacesByGovProvider =
    FutureProvider.family<List<HolyPlace>, String>((ref, gov) =>
        ref.watch(holyPlaceRepositoryProvider).getByGovernorate(gov));

final holyPlaceByIdProvider =
    FutureProvider.family<HolyPlace?, int>((ref, id) =>
        ref.watch(holyPlaceRepositoryProvider).getById(id));

final holyPlaceSearchProvider =
    FutureProvider.family<List<HolyPlace>, String>((ref, query) =>
        ref.watch(holyPlaceRepositoryProvider).search(query));

final holyPlaceGovernoratesProvider = FutureProvider<List<String>>((ref) =>
    ref.watch(holyPlaceRepositoryProvider).getGovernorates());

final holyPlaceCountProvider = FutureProvider<int>((ref) =>
    ref.watch(holyPlaceRepositoryProvider).getCount());
