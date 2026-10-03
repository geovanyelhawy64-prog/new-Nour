import 'package:drift/drift.dart';

/// جدول المحفوظات (المفضلة)
class Bookmarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get contentType => text()(); // bible, agpeya, liturgy, hymn, synaxarium, saint, prayer
  TextColumn get contentId => text()();
  TextColumn get displayTitle => text()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
