// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agpeya_dao.dart';

// ignore_for_file: type=lint
mixin _$AgpeyaDaoMixin on DatabaseAccessor<AppDatabase> {
  $AgpeyaHoursTable get agpeyaHours => attachedDatabase.agpeyaHours;
  $AgpeyaSectionsTable get agpeyaSections => attachedDatabase.agpeyaSections;
  AgpeyaDaoManager get managers => AgpeyaDaoManager(this);
}

class AgpeyaDaoManager {
  final _$AgpeyaDaoMixin _db;
  AgpeyaDaoManager(this._db);
  $$AgpeyaHoursTableTableManager get agpeyaHours =>
      $$AgpeyaHoursTableTableManager(_db.attachedDatabase, _db.agpeyaHours);
  $$AgpeyaSectionsTableTableManager get agpeyaSections =>
      $$AgpeyaSectionsTableTableManager(
          _db.attachedDatabase, _db.agpeyaSections);
}
