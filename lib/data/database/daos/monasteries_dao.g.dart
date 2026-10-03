// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monasteries_dao.dart';

// ignore_for_file: type=lint
mixin _$MonasteriesDaoMixin on DatabaseAccessor<AppDatabase> {
  $MonasteriesTable get monasteries => attachedDatabase.monasteries;
  MonasteriesDaoManager get managers => MonasteriesDaoManager(this);
}

class MonasteriesDaoManager {
  final _$MonasteriesDaoMixin _db;
  MonasteriesDaoManager(this._db);
  $$MonasteriesTableTableManager get monasteries =>
      $$MonasteriesTableTableManager(_db.attachedDatabase, _db.monasteries);
}
