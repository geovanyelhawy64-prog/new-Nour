import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/pascha_tables.dart';

part 'pascha_dao.g.dart';

@DriftAccessor(tables: [PaschaReadings])
class PaschaDao extends DatabaseAccessor<AppDatabase> with _$PaschaDaoMixin {
  PaschaDao(super.db);

  /// جلب قراءات ساعة محددة من يوم معين
  Future<List<PaschaReading>> getReadingsForHour(String dayId, int hourNumber) {
    return (select(paschaReadings)
          ..where((r) => r.dayId.equals(dayId) & r.hourNumber.equals(hourNumber))
          ..orderBy([(r) => OrderingTerm.asc(r.readingOrder)]))
        .get();
  }

  /// جلب كل قراءات يوم معين
  Future<List<PaschaReading>> getReadingsForDay(String dayId) {
    return (select(paschaReadings)
          ..where((r) => r.dayId.equals(dayId))
          ..orderBy([
            (r) => OrderingTerm.asc(r.hourNumber),
            (r) => OrderingTerm.asc(r.readingOrder),
          ]))
        .get();
  }

  /// جلب السواعي المتوفرة ليوم معين
  Future<List<int>> getHoursForDay(String dayId) async {
    final query = selectOnly(paschaReadings, distinct: true)
      ..where(paschaReadings.dayId.equals(dayId))
      ..addColumns([paschaReadings.hourNumber])
      ..orderBy([OrderingTerm.asc(paschaReadings.hourNumber)]);

    final rows = await query.get();
    return rows.map((r) => r.read(paschaReadings.hourNumber)!).toList();
  }

  /// جلب النبوات لساعة معينة
  Future<List<PaschaReading>> getProphecies(String dayId, int hourNumber) {
    return (select(paschaReadings)
          ..where((r) =>
              r.dayId.equals(dayId) &
              r.hourNumber.equals(hourNumber) &
              r.readingType.equals('prophecy'))
          ..orderBy([(r) => OrderingTerm.asc(r.readingOrder)]))
        .get();
  }

  /// جلب الأناجيل لساعة معينة
  Future<List<PaschaReading>> getGospels(String dayId, int hourNumber) {
    return (select(paschaReadings)
          ..where((r) =>
              r.dayId.equals(dayId) &
              r.hourNumber.equals(hourNumber) &
              (r.readingType.equals('gospel') | r.readingType.equals('gospel_coptic')))
          ..orderBy([(r) => OrderingTerm.asc(r.readingOrder)]))
        .get();
  }
}
