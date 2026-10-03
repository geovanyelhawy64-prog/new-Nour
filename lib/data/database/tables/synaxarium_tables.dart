import 'package:drift/drift.dart';

/// جدول السنكسار (سير القديسين والتذكارات اليومية)
class SynaxariumEntries extends Table {
  TextColumn get id => text()(); // tout_01_01
  IntColumn get copticMonth => integer()();
  IntColumn get copticDay => integer()();
  IntColumn get entryOrder => integer()();
  TextColumn get title => text()();
  TextColumn get type => text()(); // martyr, confessor, monk, patriarch, bishop, event, feast
  TextColumn get shortText => text()();
  TextColumn get fullText => text()();

  @override
  Set<Column> get primaryKey => {id};
}
