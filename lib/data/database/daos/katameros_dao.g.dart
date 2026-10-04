// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'katameros_dao.dart';

// ignore_for_file: type=lint
mixin _$KatamerosDaoMixin on DatabaseAccessor<AppDatabase> {
  $KatamerosReadingsTable get katamerosReadings =>
      attachedDatabase.katamerosReadings;
  KatamerosDaoManager get managers => KatamerosDaoManager(this);
}

class KatamerosDaoManager {
  final _$KatamerosDaoMixin _db;
  KatamerosDaoManager(this._db);
  $$KatamerosReadingsTableTableManager get katamerosReadings =>
      $$KatamerosReadingsTableTableManager(
          _db.attachedDatabase, _db.katamerosReadings);
}
