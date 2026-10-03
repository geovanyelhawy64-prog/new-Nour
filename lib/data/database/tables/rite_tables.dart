import 'package:drift/drift.dart';

class Rites extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameAr => text()();
  TextColumn get nameEn => text().nullable()();
  TextColumn get nameCoptic => text().nullable()();
  TextColumn get category => text()();
  TextColumn get description => text().nullable()();
  IntColumn get sortOrder => integer()();
  TextColumn get icon => text().nullable()();
}

class RiteSections extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get riteId => integer().references(Rites, #id)();
  TextColumn get titleAr => text()();
  TextColumn get textAr => text()();
  TextColumn get copticText => text().nullable()();
  TextColumn get copticArabicText => text().nullable()();
  TextColumn get rubric => text().nullable()();
  TextColumn get response => text().nullable()();
  IntColumn get sortOrder => integer()();
}
