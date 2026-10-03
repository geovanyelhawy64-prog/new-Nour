import 'package:drift/drift.dart';

/// جدول الأسرار الكنسية السبعة
class Sacraments extends Table {
  TextColumn get id => text()(); // baptism, confirmation, eucharist, repentance, unction, priesthood, matrimony
  TextColumn get nameAr => text()();
  IntColumn get sacramentOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// جدول أقسام وشروحات كل سر
class SacramentSections extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sacramentId => text().references(Sacraments, #id)();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get scriptures => text().nullable()(); // شواهد كتابية
  IntColumn get sectionOrder => integer()();
}
