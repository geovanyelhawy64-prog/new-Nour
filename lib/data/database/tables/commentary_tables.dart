import 'package:drift/drift.dart';

@DataClassName('BibleCommentary')
class BibleCommentaries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId => integer()();
  IntColumn get chapter => integer()();
  IntColumn get verseStart => integer().nullable()();
  IntColumn get verseEnd => integer().nullable()();
  TextColumn get source => text()();
  TextColumn get author => text()();
  TextColumn get content => text().named('text')();
  TextColumn get summary => text().withLength(max: 500)();
}
