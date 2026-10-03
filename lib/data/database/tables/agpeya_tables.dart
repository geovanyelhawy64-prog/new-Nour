import 'package:drift/drift.dart';

/// جدول ساعات الأجبية (الصلوات السبع)
class AgpeyaHours extends Table {
  TextColumn get id => text()(); // prime, terce, sext, none, vespers, compline, midnight
  TextColumn get nameAr => text()();
  TextColumn get nameEn => text()();
  IntColumn get hourOrder => integer()();
  TextColumn get description => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// جدول أقسام كل ساعة من ساعات الأجبية
class AgpeyaSections extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get hourId => text().references(AgpeyaHours, #id)();
  IntColumn get sectionOrder => integer()();
  TextColumn get type => text()(); // psalm, gospel, litany, absolution, introduction, doxology, creed
  TextColumn get title => text()();
  TextColumn get role => text()(); // priest, deacon, people, reader, all
  TextColumn get textAr => text()();
  TextColumn get textCoptic => text().nullable()();
  TextColumn get textPhonetic => text().nullable()();
  TextColumn get reference => text().nullable()(); // للمزامير والإنجيل
}
