// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_dao.dart';

// ignore_for_file: type=lint
mixin _$SearchDaoMixin on DatabaseAccessor<AppDatabase> {
  $BibleBooksTable get bibleBooks => attachedDatabase.bibleBooks;
  $BibleVersesTable get bibleVerses => attachedDatabase.bibleVerses;
  $AgpeyaHoursTable get agpeyaHours => attachedDatabase.agpeyaHours;
  $AgpeyaSectionsTable get agpeyaSections => attachedDatabase.agpeyaSections;
  $LiturgiesTable get liturgies => attachedDatabase.liturgies;
  $LiturgySectionsTable get liturgySections => attachedDatabase.liturgySections;
  $LiturgyPartsTable get liturgyParts => attachedDatabase.liturgyParts;
  $HymnBooksTable get hymnBooks => attachedDatabase.hymnBooks;
  $HymnsTable get hymns => attachedDatabase.hymns;
  $SynaxariumEntriesTable get synaxariumEntries =>
      attachedDatabase.synaxariumEntries;
  $SaintsTable get saints => attachedDatabase.saints;
  $OccasionalPrayersTable get occasionalPrayers =>
      attachedDatabase.occasionalPrayers;
  $TheologyArticlesTable get theologyArticles =>
      attachedDatabase.theologyArticles;
  SearchDaoManager get managers => SearchDaoManager(this);
}

class SearchDaoManager {
  final _$SearchDaoMixin _db;
  SearchDaoManager(this._db);
  $$BibleBooksTableTableManager get bibleBooks =>
      $$BibleBooksTableTableManager(_db.attachedDatabase, _db.bibleBooks);
  $$BibleVersesTableTableManager get bibleVerses =>
      $$BibleVersesTableTableManager(_db.attachedDatabase, _db.bibleVerses);
  $$AgpeyaHoursTableTableManager get agpeyaHours =>
      $$AgpeyaHoursTableTableManager(_db.attachedDatabase, _db.agpeyaHours);
  $$AgpeyaSectionsTableTableManager get agpeyaSections =>
      $$AgpeyaSectionsTableTableManager(
          _db.attachedDatabase, _db.agpeyaSections);
  $$LiturgiesTableTableManager get liturgies =>
      $$LiturgiesTableTableManager(_db.attachedDatabase, _db.liturgies);
  $$LiturgySectionsTableTableManager get liturgySections =>
      $$LiturgySectionsTableTableManager(
          _db.attachedDatabase, _db.liturgySections);
  $$LiturgyPartsTableTableManager get liturgyParts =>
      $$LiturgyPartsTableTableManager(_db.attachedDatabase, _db.liturgyParts);
  $$HymnBooksTableTableManager get hymnBooks =>
      $$HymnBooksTableTableManager(_db.attachedDatabase, _db.hymnBooks);
  $$HymnsTableTableManager get hymns =>
      $$HymnsTableTableManager(_db.attachedDatabase, _db.hymns);
  $$SynaxariumEntriesTableTableManager get synaxariumEntries =>
      $$SynaxariumEntriesTableTableManager(
          _db.attachedDatabase, _db.synaxariumEntries);
  $$SaintsTableTableManager get saints =>
      $$SaintsTableTableManager(_db.attachedDatabase, _db.saints);
  $$OccasionalPrayersTableTableManager get occasionalPrayers =>
      $$OccasionalPrayersTableTableManager(
          _db.attachedDatabase, _db.occasionalPrayers);
  $$TheologyArticlesTableTableManager get theologyArticles =>
      $$TheologyArticlesTableTableManager(
          _db.attachedDatabase, _db.theologyArticles);
}
