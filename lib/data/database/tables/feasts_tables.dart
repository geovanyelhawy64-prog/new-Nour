import 'package:drift/drift.dart';

/// جدول الأعياد والأصوام الكنسية
class FeastsAndFasts extends Table {
  TextColumn get id => text()();
  TextColumn get nameAr => text()();
  TextColumn get type => text()(); // major_feast, minor_feast, fast
  IntColumn get copticMonth => integer().nullable()();
  IntColumn get copticDay => integer().nullable()();
  BoolColumn get isMovable => boolean().withDefault(const Constant(false))();
  TextColumn get calculationRule => text().nullable()();
  TextColumn get rite => text()(); // festive, lenten, annual, kiahki
  TextColumn get description => text()();
  IntColumn get durationDays => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
