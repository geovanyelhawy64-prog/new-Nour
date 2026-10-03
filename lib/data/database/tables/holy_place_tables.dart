import 'package:drift/drift.dart';

class HolyPlaces extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameAr => text()();
  TextColumn get nameCoptic => text().nullable()();
  TextColumn get type => text()(); // monasteryMen, monasteryWomen, holyFamily, historicChurch, shrine
  TextColumn get governorate => text()();
  TextColumn get locationDescription => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get century => text().nullable()();
  TextColumn get patronSaint => text().nullable()();
  TextColumn get history => text()();
  TextColumn get feastDay => text().nullable()();
  TextColumn get visitingRules => text().nullable()();
  IntColumn get sortOrder => integer()();
}
