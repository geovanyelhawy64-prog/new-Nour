// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_verse_dao.dart';

// ignore_for_file: type=lint
mixin _$DailyVerseDaoMixin on DatabaseAccessor<AppDatabase> {
  $DailyVersesTable get dailyVerses => attachedDatabase.dailyVerses;
  DailyVerseDaoManager get managers => DailyVerseDaoManager(this);
}

class DailyVerseDaoManager {
  final _$DailyVerseDaoMixin _db;
  DailyVerseDaoManager(this._db);
  $$DailyVersesTableTableManager get dailyVerses =>
      $$DailyVersesTableTableManager(_db.attachedDatabase, _db.dailyVerses);
}
