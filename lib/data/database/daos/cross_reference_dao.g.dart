// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cross_reference_dao.dart';

// ignore_for_file: type=lint
mixin _$CrossReferenceDaoMixin on DatabaseAccessor<AppDatabase> {
  $BibleCrossReferencesTable get bibleCrossReferences =>
      attachedDatabase.bibleCrossReferences;
  $BibleBooksTable get bibleBooks => attachedDatabase.bibleBooks;
  $BibleVersesTable get bibleVerses => attachedDatabase.bibleVerses;
  CrossReferenceDaoManager get managers => CrossReferenceDaoManager(this);
}

class CrossReferenceDaoManager {
  final _$CrossReferenceDaoMixin _db;
  CrossReferenceDaoManager(this._db);
  $$BibleCrossReferencesTableTableManager get bibleCrossReferences =>
      $$BibleCrossReferencesTableTableManager(
          _db.attachedDatabase, _db.bibleCrossReferences);
  $$BibleBooksTableTableManager get bibleBooks =>
      $$BibleBooksTableTableManager(_db.attachedDatabase, _db.bibleBooks);
  $$BibleVersesTableTableManager get bibleVerses =>
      $$BibleVersesTableTableManager(_db.attachedDatabase, _db.bibleVerses);
}
