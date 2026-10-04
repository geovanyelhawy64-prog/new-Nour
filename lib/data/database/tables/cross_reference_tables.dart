import 'package:drift/drift.dart';

class BibleCrossReferences extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sourceBookId => integer()();
  IntColumn get sourceChapter => integer()();
  IntColumn get sourceVerse => integer()();
  IntColumn get targetBookId => integer()();
  IntColumn get targetChapter => integer()();
  IntColumn get targetVerse => integer()();
  TextColumn get relationType => text().withDefault(const Constant('related'))();
}
