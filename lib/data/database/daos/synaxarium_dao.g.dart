// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synaxarium_dao.dart';

// ignore_for_file: type=lint
mixin _$SynaxariumDaoMixin on DatabaseAccessor<AppDatabase> {
  $SynaxariumEntriesTable get synaxariumEntries =>
      attachedDatabase.synaxariumEntries;
  SynaxariumDaoManager get managers => SynaxariumDaoManager(this);
}

class SynaxariumDaoManager {
  final _$SynaxariumDaoMixin _db;
  SynaxariumDaoManager(this._db);
  $$SynaxariumEntriesTableTableManager get synaxariumEntries =>
      $$SynaxariumEntriesTableTableManager(
          _db.attachedDatabase, _db.synaxariumEntries);
}
