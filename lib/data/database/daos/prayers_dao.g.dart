// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayers_dao.dart';

// ignore_for_file: type=lint
mixin _$PrayersDaoMixin on DatabaseAccessor<AppDatabase> {
  $OccasionalPrayersTable get occasionalPrayers =>
      attachedDatabase.occasionalPrayers;
  PrayersDaoManager get managers => PrayersDaoManager(this);
}

class PrayersDaoManager {
  final _$PrayersDaoMixin _db;
  PrayersDaoManager(this._db);
  $$OccasionalPrayersTableTableManager get occasionalPrayers =>
      $$OccasionalPrayersTableTableManager(
          _db.attachedDatabase, _db.occasionalPrayers);
}
