// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feasts_dao.dart';

// ignore_for_file: type=lint
mixin _$FeastsDaoMixin on DatabaseAccessor<AppDatabase> {
  $FeastsAndFastsTable get feastsAndFasts => attachedDatabase.feastsAndFasts;
  FeastsDaoManager get managers => FeastsDaoManager(this);
}

class FeastsDaoManager {
  final _$FeastsDaoMixin _db;
  FeastsDaoManager(this._db);
  $$FeastsAndFastsTableTableManager get feastsAndFasts =>
      $$FeastsAndFastsTableTableManager(
          _db.attachedDatabase, _db.feastsAndFasts);
}
