import 'package:drift/drift.dart';

@DataClassName('CopticDictionaryEntry')
class CopticDictionary extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get coptic => text()();
  TextColumn get phonetic => text()();
  TextColumn get arabic => text()();
  TextColumn get english => text().nullable()();
  TextColumn get partOfSpeech => text().withDefault(const Constant('noun'))();
  TextColumn get usage => text().nullable()();
  TextColumn get hymnReference => text().nullable()();
}
