class DbConstants {
  DbConstants._();

  /// اسم قاعدة الإصدارات القديمة التي تُقرأ مرة واحدة للترحيل فقط.
  static const String databaseFileName = 'noor.db';

  /// إصدار مخطط قاعدة المحتوى (يختلف عن إصدار Drift الداخلي في AppDatabase).
  static const int contentDatabaseVersion = 18;

  /// إصدار ترحيل بيانات المستخدم المستقل.
  static const int userDataMigrationVersion = 1;

  /// للتوافق مع المستهلكين القدامى؛ لا تستخدمه لتقرير تحديث المحتوى.
  @Deprecated('استخدم contentDatabaseVersion أو userDataMigrationVersion')
  static const int databaseVersion = userDataMigrationVersion;

  // أسماء الجداول
  static const String tableBibleBooks = 'bible_books';
  static const String tableBibleVerses = 'bible_verses';
  static const String tableAgpeyaHours = 'agpeya_hours';
  static const String tableAgpeyaSections = 'agpeya_sections';
  static const String tableLiturgies = 'liturgies';
  static const String tableLiturgySections = 'liturgy_sections';
  static const String tableLiturgyParts = 'liturgy_parts';
  static const String tableHymnBooks = 'hymn_books';
  static const String tableHymns = 'hymns';
  static const String tableHymnSegments = 'hymn_segments';
  static const String tableSynaxarium = 'synaxarium_entries';
  static const String tableKatameros = 'katameros_readings';
  static const String tableSaints = 'saints';
  static const String tableDifnar = 'difnar_entries';
  static const String tablePascha = 'pascha_readings';
  static const String tableFeasts = 'feasts_and_fasts';
  static const String tablePrayers = 'occasional_prayers';
  static const String tableTheology = 'theology_articles';
  static const String tableDailyVerses = 'daily_verses';
  static const String tableBookmarks = 'bookmarks';
}
