// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emotion_prayer_dao.dart';

// ignore_for_file: type=lint
mixin _$EmotionPrayerDaoMixin on DatabaseAccessor<AppDatabase> {
  $EmotionPrayersTable get emotionPrayers => attachedDatabase.emotionPrayers;
  EmotionPrayerDaoManager get managers => EmotionPrayerDaoManager(this);
}

class EmotionPrayerDaoManager {
  final _$EmotionPrayerDaoMixin _db;
  EmotionPrayerDaoManager(this._db);
  $$EmotionPrayersTableTableManager get emotionPrayers =>
      $$EmotionPrayersTableTableManager(
          _db.attachedDatabase, _db.emotionPrayers);
}
