import 'package:drift/drift.dart';

/// جدول القطمارس (القراءات الكنسية اليومية)
class KatamerosReadings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get copticMonth => integer()();
  IntColumn get copticDay => integer()();
  TextColumn get periodType => text()(); // annual, great_lent, pascha, pentecost
  TextColumn get rite => text()(); // festive, lenten, annual, kiahki
  TextColumn get serviceType => text()(); // vespers, matins, liturgy
  TextColumn get readingType => text()(); // pauline, catholic, acts, psalm, gospel, prophecy
  TextColumn get reference => text()();
  TextColumn get content => text().named('text')();
  TextColumn get synaxariumId => text().nullable()();
}
