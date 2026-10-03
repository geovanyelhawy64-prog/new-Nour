import 'package:drift/drift.dart';

/// جدول مقالات اللاهوت والعقيدة
class TheologyArticles extends Table {
  TextColumn get id => text()();
  TextColumn get category => text()(); // creed, councils, incarnation, trinity, redemption, sacraments_theology, intercession
  TextColumn get categoryAr => text()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  IntColumn get articleOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
