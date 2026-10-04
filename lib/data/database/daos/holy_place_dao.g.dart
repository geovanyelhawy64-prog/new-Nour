// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holy_place_dao.dart';

// ignore_for_file: type=lint
mixin _$HolyPlaceDaoMixin on DatabaseAccessor<AppDatabase> {
  $HolyPlacesTable get holyPlaces => attachedDatabase.holyPlaces;
  HolyPlaceDaoManager get managers => HolyPlaceDaoManager(this);
}

class HolyPlaceDaoManager {
  final _$HolyPlaceDaoMixin _db;
  HolyPlaceDaoManager(this._db);
  $$HolyPlacesTableTableManager get holyPlaces =>
      $$HolyPlacesTableTableManager(_db.attachedDatabase, _db.holyPlaces);
}
