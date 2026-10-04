import 'package:drift/drift.dart';
import '../../../core/coptic_calendar/coptic_date.dart';
import '../../../core/coptic_calendar/easter_calculator.dart';
import '../app_database.dart';
import '../tables/katameros_tables.dart';

part 'katameros_dao.g.dart';

@DriftAccessor(tables: [KatamerosReadings])
class KatamerosDao extends DatabaseAccessor<AppDatabase> with _$KatamerosDaoMixin {
  KatamerosDao(super.db);

  /// جلب كل قراءات يوم قبطي محدد (عشية، باكر، والقداس)
  Future<List<KatamerosReading>> getReadingsForDay(
    int month,
    int day, {
    String periodType = 'annual',
  }) {
    return (select(katamerosReadings)
          ..where((r) =>
              r.copticMonth.equals(month) &
              r.copticDay.equals(day) &
              r.periodType.equals(periodType))
          ..orderBy([(r) => OrderingTerm.asc(r.id)]))
        .get();
  }

  /// جلب قراءات الصوم الكبير حسب اليوم (1 - 55)
  Future<List<KatamerosReading>> getGreatLentReadings(int dayOfLent) {
    return (select(katamerosReadings)
          ..where((r) =>
              r.periodType.equals('great_lent') & r.copticDay.equals(dayOfLent))
          ..orderBy([(r) => OrderingTerm.asc(r.id)]))
        .get();
  }

  /// جلب قراءات الخماسين المقدسة حسب اليوم (1 - 50)
  Future<List<KatamerosReading>> getPentecostReadings(int dayOfPentecost) {
    return (select(katamerosReadings)
          ..where((r) =>
              r.periodType.equals('pentecost') & r.copticDay.equals(dayOfPentecost))
          ..orderBy([(r) => OrderingTerm.asc(r.id)]))
        .get();
  }

  /// جلب قراءات صوم وفصح يونان (1 - 4)
  Future<List<KatamerosReading>> getJonahReadings(int dayOfJonah) {
    return (select(katamerosReadings)
          ..where((r) =>
              r.periodType.equals('jonah') & r.copticDay.equals(dayOfJonah))
          ..orderBy([(r) => OrderingTerm.asc(r.id)]))
        .get();
  }

  /// جلب قراءات آحاد الشهر القبطي (الأحد 1 - 5)
  Future<List<KatamerosReading>> getSundayReadings(int month, int sundayIndex) {
    return (select(katamerosReadings)
          ..where((r) =>
              r.periodType.equals('sundays') &
              r.copticMonth.equals(month) &
              r.copticDay.equals(sundayIndex))
          ..orderBy([(r) => OrderingTerm.asc(r.id)]))
        .get();
  }

  /// جلب قراءات خدمة معينة (vespers, matins, liturgy)
  Future<List<KatamerosReading>> getReadingsForService(
    int month,
    int day,
    String serviceType, {
    String periodType = 'annual',
  }) {
    return (select(katamerosReadings)
          ..where((r) =>
              r.copticMonth.equals(month) &
              r.copticDay.equals(day) &
              r.periodType.equals(periodType) &
              r.serviceType.equals(serviceType))
          ..orderBy([(r) => OrderingTerm.asc(r.id)]))
        .get();
  }

  /// جلب قراءة معينة (إنجيل القداس، البولس، الكاثوليكون، الإبركسيس، مزمور القداس)
  Future<KatamerosReading?> getSpecificReading(
    int month,
    int day,
    String serviceType,
    String readingType, {
    String periodType = 'annual',
  }) {
    return (select(katamerosReadings)
          ..where((r) =>
              r.copticMonth.equals(month) &
              r.copticDay.equals(day) &
              r.periodType.equals(periodType) &
              r.serviceType.equals(serviceType) &
              r.readingType.equals(readingType)))
        .getSingleOrNull();
  }

  /// جلب قراءات اليوم الحقيقية تلقائياً بحسب التقويم والموسم والطقس الكنسي
  Future<List<KatamerosReading>> getLiturgicalReadingsForDate(
    DateTime gregorianDate,
    CopticDate copticDate,
  ) async {
    final cleanDate =
        DateTime(gregorianDate.year, gregorianDate.month, gregorianDate.day);
    final year = cleanDate.year;

    // 1. فحص صوم وفصح يونان (4 أيام)
    final jonahStart = EasterCalculator.jonahFastStart(year);
    final jonahPassover = EasterCalculator.jonahPassover(year);
    if (!cleanDate.isBefore(jonahStart) && !cleanDate.isAfter(jonahPassover)) {
      final dayNum = cleanDate.difference(jonahStart).inDays + 1;
      final readings = await getJonahReadings(dayNum);
      if (readings.isNotEmpty) return readings;
    }

    // 2. فحص الصوم الكبير (55 يوماً)
    final lentStart = EasterCalculator.greatLentStart(year);
    final palmSunday = EasterCalculator.palmSunday(year);
    if (!cleanDate.isBefore(lentStart) && cleanDate.isBefore(palmSunday)) {
      final dayNum = cleanDate.difference(lentStart).inDays + 1;
      final readings = await getGreatLentReadings(dayNum);
      if (readings.isNotEmpty) return readings;
    }

    // 3. فحص الخماسين المقدسة (50 يوماً من أحد القيامة إلى العنصرة)
    final easter = EasterCalculator.calculateEaster(year);
    final pentecost = EasterCalculator.pentecost(year);
    if (!cleanDate.isBefore(easter) && !cleanDate.isAfter(pentecost)) {
      final dayNum = cleanDate.difference(easter).inDays + 1;
      final readings = await getPentecostReadings(dayNum);
      if (readings.isNotEmpty) return readings;
    }

    // 4. فحص آحاد السنة (Sunday readings)
    if (cleanDate.weekday == DateTime.sunday) {
      final sundayIndex = ((copticDate.day - 1) ~/ 7) + 1;
      final sundayReadings =
          await getSundayReadings(copticDate.month, sundayIndex.clamp(1, 5));
      if (sundayReadings.isNotEmpty) return sundayReadings;
    }

    // 5. الأيام السنوية العادية
    return getReadingsForDay(copticDate.month, copticDate.day);
  }
}
