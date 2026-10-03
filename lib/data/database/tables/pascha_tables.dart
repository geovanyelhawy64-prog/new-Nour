import 'package:drift/drift.dart';

/// جدول قراءات أسبوع الآلام (البصخة المقدسة)
class PaschaReadings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get dayId => text()(); // palm_sunday, monday, tuesday, wednesday, covenant_thursday, good_friday, bright_saturday, resurrection
  TextColumn get dayNameAr => text()();
  IntColumn get hourNumber => integer()();
  TextColumn get hourNameAr => text()();
  TextColumn get readingType => text()(); // prophecy, psalm, gospel, commentary, hymn
  TextColumn get reference => text().nullable()();
  TextColumn get content => text().named('text')();
  IntColumn get readingOrder => integer()();
}
