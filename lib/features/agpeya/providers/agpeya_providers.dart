import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/agpeya_repository.dart';

final agpeyaRepositoryProvider = Provider((ref) => AgpeyaRepository());

final agpeyaHoursProvider = FutureProvider<List<AgpeyaHour>>((ref) {
  return ref.read(agpeyaRepositoryProvider).getAllHours();
});

final hourSectionsProvider = FutureProvider.family<
    List<AgpeyaSection>,
    String>((ref, hourId) {
  return ref.read(agpeyaRepositoryProvider).getHourSections(hourId);
});
