import 'package:drift/drift.dart';

/// خريطة ترقيم المزامير: سبعينية (LXX/Agpeya) ↔ ماسوريتي (MT/Van Dyck)
@DataClassName('PsalmsMappingEntry')
class PsalmsMapping extends Table {
  /// رقم المزمور في الترجمة السبعينية (LXX) - المستخدم في الأجبية والطقوس
  IntColumn get lxx => integer()();

  /// رقم المزمور في النص الماسوريتي (MT) - المستخدم في ترجمة فاندايك
  IntColumn get masoretic => integer()();

  /// العنوان العربي للمزمور
  TextColumn get titleAr => text()();

  /// ملاحظة حول الفرق في الترقيم
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {lxx};
}