import 'package:drift/drift.dart';

@DataClassName('Psali')
class Psalis extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get psaliId => text().unique()();
  TextColumn get type => text()();
  TextColumn get nameAr => text()();
  TextColumn get nameCoptic => text().nullable()();
  TextColumn get namePhonetic => text().nullable()();
  TextColumn get occasion => text()();
  TextColumn get dayOfWeek => text().nullable()();
  TextColumn get season => text().nullable()();
  IntColumn get order => integer().named('order')();
}

@DataClassName('PsaliSection')
class PsaliSections extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get psaliId => text()();
  IntColumn get sectionOrder => integer()();
  TextColumn get textCoptic => text()();
  TextColumn get textPhonetic => text()();
  TextColumn get textArabic => text()();
  TextColumn get rubric => text().nullable()();
  TextColumn get response => text().nullable()();
}
