import 'package:drift/drift.dart';

/// جدول أسفار الكتاب المقدس
class BibleBooks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameAr => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameCoptic => text().nullable()();
  TextColumn get testament => text()(); // old, new, deutero
  TextColumn get testamentAr => text()();
  TextColumn get category => text()();
  TextColumn get categoryAr => text()();
  IntColumn get bookOrder => integer()();
  IntColumn get chapterCount => integer()();
}

/// جدول آيات الكتاب المقدس
class BibleVerses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId => integer().references(BibleBooks, #id)();
  IntColumn get chapter => integer()();
  IntColumn get verseNumber => integer()();
  TextColumn get content => text().named('text')();
  TextColumn get textWithTashkeel => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {bookId, chapter, verseNumber},
  ];
}
