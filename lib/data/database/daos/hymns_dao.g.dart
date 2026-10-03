// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymns_dao.dart';

// ignore_for_file: type=lint
mixin _$HymnsDaoMixin on DatabaseAccessor<AppDatabase> {
  $HymnBooksTable get hymnBooks => attachedDatabase.hymnBooks;
  $HymnsTable get hymns => attachedDatabase.hymns;
  $HymnSegmentsTable get hymnSegments => attachedDatabase.hymnSegments;
  HymnsDaoManager get managers => HymnsDaoManager(this);
}

class HymnsDaoManager {
  final _$HymnsDaoMixin _db;
  HymnsDaoManager(this._db);
  $$HymnBooksTableTableManager get hymnBooks =>
      $$HymnBooksTableTableManager(_db.attachedDatabase, _db.hymnBooks);
  $$HymnsTableTableManager get hymns =>
      $$HymnsTableTableManager(_db.attachedDatabase, _db.hymns);
  $$HymnSegmentsTableTableManager get hymnSegments =>
      $$HymnSegmentsTableTableManager(_db.attachedDatabase, _db.hymnSegments);
}
