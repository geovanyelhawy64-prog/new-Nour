import 'package:drift/drift.dart';

/// جدول القداسات (الباسيلي، الغريغوري، الكيرلسي)
class Liturgies extends Table {
  TextColumn get id => text()(); // basil, gregory, cyril
  TextColumn get nameAr => text()();
  TextColumn get nameEn => text()();
  IntColumn get liturgyOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// جدول أقسام القداس (رفع بخور، قداس الكلمة، الأنافورا، التوزيع)
class LiturgySections extends Table {
  TextColumn get id => text()();
  TextColumn get liturgyId => text().references(Liturgies, #id)();
  TextColumn get nameAr => text()();
  IntColumn get sectionOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// جدول أجزاء كل قسم (صلوات، مردات، ألحان، إرشادات)
class LiturgyParts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sectionId => text().references(LiturgySections, #id)();
  IntColumn get partOrder => integer()();
  TextColumn get role => text()(); // priest, deacon, people, priest_silent
  TextColumn get type => text()(); // prayer, response, hymn, reading, rubric
  TextColumn get textAr => text()();
  TextColumn get textCoptic => text().nullable()();
  TextColumn get textPhonetic => text().nullable()();
  TextColumn get rubric => text().nullable()(); // التعليمات الطقسية
  BoolColumn get isSecret => boolean().withDefault(const Constant(false))();
}
