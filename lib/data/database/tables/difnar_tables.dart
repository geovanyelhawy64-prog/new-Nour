import 'package:drift/drift.dart';

/// جدول الدفنار (سير القديسين المقفى)
class DifnarEntries extends Table {
  TextColumn get id => text()();
  IntColumn get copticMonth => integer()();
  IntColumn get copticDay => integer()();
  TextColumn get textCoptic => text()();
  TextColumn get textPhonetic => text()();
  TextColumn get textAr => text()();

  @override
  Set<Column> get primaryKey => {id};
}
