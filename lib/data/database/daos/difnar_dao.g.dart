// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'difnar_dao.dart';

// ignore_for_file: type=lint
mixin _$DifnarDaoMixin on DatabaseAccessor<AppDatabase> {
  $DifnarEntriesTable get difnarEntries => attachedDatabase.difnarEntries;
  DifnarDaoManager get managers => DifnarDaoManager(this);
}

class DifnarDaoManager {
  final _$DifnarDaoMixin _db;
  DifnarDaoManager(this._db);
  $$DifnarEntriesTableTableManager get difnarEntries =>
      $$DifnarEntriesTableTableManager(_db.attachedDatabase, _db.difnarEntries);
}
