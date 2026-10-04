import 'package:drift/drift.dart';

/// جدول الأديرة والكنائس والمزارات الأثرية
@DataClassName('MonasteryEntry')
class Monasteries extends Table {
  TextColumn get id => text()();
  TextColumn get nameAr => text()();
  TextColumn get nameEn => text().nullable()();
  TextColumn get nameCoptic => text().nullable()();
  TextColumn get type => text().withDefault(const Constant('monastery'))();
  TextColumn get location => text()();
  TextColumn get founded => text()();
  TextColumn get founder => text()();
  TextColumn get description => text()();
  IntColumn get copticMonth => integer().nullable()();
  IntColumn get copticDay => integer().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get patronSaints => text().nullable()();
  TextColumn get visitingHours => text().nullable()();
  TextColumn get architecturalDescription => text().nullable()();
  TextColumn get feastDate => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
