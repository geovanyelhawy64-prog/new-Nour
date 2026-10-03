// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pascha_dao.dart';

// ignore_for_file: type=lint
mixin _$PaschaDaoMixin on DatabaseAccessor<AppDatabase> {
  $PaschaReadingsTable get paschaReadings => attachedDatabase.paschaReadings;
  PaschaDaoManager get managers => PaschaDaoManager(this);
}

class PaschaDaoManager {
  final _$PaschaDaoMixin _db;
  PaschaDaoManager(this._db);
  $$PaschaReadingsTableTableManager get paschaReadings =>
      $$PaschaReadingsTableTableManager(
          _db.attachedDatabase, _db.paschaReadings);
}
