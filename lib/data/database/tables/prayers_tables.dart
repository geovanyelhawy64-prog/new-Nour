import 'package:drift/drift.dart';

/// جدول صلوات المناسبات
class OccasionalPrayers extends Table {
  TextColumn get id => text()();
  TextColumn get category => text()(); // exams, illness, travel, communion, distress, repentance, family, thanks
  TextColumn get categoryAr => text()();
  TextColumn get title => text()();
  TextColumn get content => text().named('text')();
  IntColumn get prayerOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
