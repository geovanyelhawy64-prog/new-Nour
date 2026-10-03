import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/daily_verse_tables.dart';

part 'daily_verse_dao.g.dart';

@DriftAccessor(tables: [DailyVerses])
class DailyVerseDao extends DatabaseAccessor<AppDatabase>
    with _$DailyVerseDaoMixin {
  DailyVerseDao(super.db);

  Future<DailyVerse?> getVerseForDay(int dayOfYear) {
    return (select(dailyVerses)
          ..where((v) => v.dayOfYear.equals(dayOfYear)))
        .getSingleOrNull();
  }

  Future<DailyVerse?> getTodayVerse() {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    final diff = now.difference(startOfYear).inDays + 1;
    return getVerseForDay(diff);
  }
}
