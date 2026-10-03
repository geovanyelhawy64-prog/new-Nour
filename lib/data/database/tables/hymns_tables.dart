import 'package:drift/drift.dart';

/// جدول كتب الألحان (كتب أسامة لطفي)
class HymnBooks extends Table {
  TextColumn get id => text()();
  TextColumn get nameAr => text()();
  IntColumn get bookOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// جدول الألحان
class Hymns extends Table {
  TextColumn get id => text()();
  TextColumn get bookId => text().references(HymnBooks, #id)();
  TextColumn get nameAr => text()();
  TextColumn get nameCoptic => text().nullable()();
  TextColumn get occasion => text()(); // liturgy, vespers, matins, feast, burial
  TextColumn get tone => text()(); // festive, lenten, annual, kiahki
  IntColumn get hymnOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// جدول مقاطع اللحن (الهزات والمدود والنوتة الصوتية)
class HymnSegments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get hymnId => text().references(Hymns, #id)();
  IntColumn get segmentOrder => integer()();
  IntColumn get lineNumber => integer()();
  TextColumn get coptic => text()();
  TextColumn get phonetic => text()();
  TextColumn get arabic => text()();
  TextColumn get syllablesJson => text().nullable()();
}
