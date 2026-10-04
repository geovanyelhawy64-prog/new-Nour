import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/database_service.dart';
import '../../../data/database/app_database.dart' hide EmotionPrayer;
import '../../../data/models/emotion_prayer.dart';
import '../../../data/repositories/emotion_prayer_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => DatabaseService.instance);

final emotionPrayerRepositoryProvider = Provider<EmotionPrayerRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return EmotionPrayerRepository(db.emotionPrayerDao);
});

final allEmotionPrayersProvider = FutureProvider<List<EmotionPrayer>>((ref) =>
    ref.watch(emotionPrayerRepositoryProvider).getAll());

final emotionPrayersByCategoryProvider =
    FutureProvider.family<List<EmotionPrayer>, String>((ref, category) =>
        ref.watch(emotionPrayerRepositoryProvider).getByCategory(category));

final emotionPrayerByIdProvider =
    FutureProvider.family<EmotionPrayer?, int>((ref, id) =>
        ref.watch(emotionPrayerRepositoryProvider).getById(id));

final emotionCategoriesProvider = FutureProvider<List<String>>((ref) =>
    ref.watch(emotionPrayerRepositoryProvider).getCategories());
