import 'package:drift/drift.dart';

class EmotionPrayers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category => text()(); // comfort, anxiety, peace, repentance, gratitude, guidance, sickness, temptation
  TextColumn get title => text()();
  TextColumn get verseText => text()();
  TextColumn get verseReference => text()();
  TextColumn get psalmText => text().nullable()();
  TextColumn get psalmReference => text().nullable()();
  TextColumn get agpeyaPrayer => text().nullable()();
  TextColumn get agpeyaReference => text().nullable()();
  TextColumn get meditation => text()();
  IntColumn get sortOrder => integer()();
}
