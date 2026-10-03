// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saints_dao.dart';

// ignore_for_file: type=lint
mixin _$SaintsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SaintsTable get saints => attachedDatabase.saints;
  SaintsDaoManager get managers => SaintsDaoManager(this);
}

class SaintsDaoManager {
  final _$SaintsDaoMixin _db;
  SaintsDaoManager(this._db);
  $$SaintsTableTableManager get saints =>
      $$SaintsTableTableManager(_db.attachedDatabase, _db.saints);
}
