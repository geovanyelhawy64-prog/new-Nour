import 'package:drift/drift.dart';

/// جدول القديسين والشهداء
class Saints extends Table {
  TextColumn get id => text()();
  TextColumn get nameAr => text()();
  TextColumn get nameCoptic => text().nullable()();
  TextColumn get nameEn => text().nullable()();
  TextColumn get type => text()(); // martyr, monk, patriarch, apostle, confessor
  IntColumn get feastMonth => integer().nullable()();
  IntColumn get feastDay => integer().nullable()();
  TextColumn get biography => text()();
  TextColumn get shortBio => text()();

  @override
  Set<Column> get primaryKey => {id};
}
