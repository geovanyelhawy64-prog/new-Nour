import 'package:drift/drift.dart';

/// جدول آيات اليوم (366 آية لأيام السنة)
class DailyVerses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get dayOfYear => integer()(); // 1 to 366
  TextColumn get reference => text()();
  TextColumn get content => text().named('text')();
}
