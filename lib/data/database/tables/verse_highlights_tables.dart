import 'package:drift/drift.dart';

/// جدول تظليلات الآيات
class VerseHighlights extends Table {
  TextColumn get id => text()(); // 'bookId:chapter:verse'
  IntColumn get bookId => integer()();
  IntColumn get chapter => integer()();
  IntColumn get verseNumber => integer()();
  TextColumn get color => text()();
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
