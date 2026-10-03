// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liturgy_dao.dart';

// ignore_for_file: type=lint
mixin _$LiturgyDaoMixin on DatabaseAccessor<AppDatabase> {
  $LiturgiesTable get liturgies => attachedDatabase.liturgies;
  $LiturgySectionsTable get liturgySections => attachedDatabase.liturgySections;
  $LiturgyPartsTable get liturgyParts => attachedDatabase.liturgyParts;
  LiturgyDaoManager get managers => LiturgyDaoManager(this);
}

class LiturgyDaoManager {
  final _$LiturgyDaoMixin _db;
  LiturgyDaoManager(this._db);
  $$LiturgiesTableTableManager get liturgies =>
      $$LiturgiesTableTableManager(_db.attachedDatabase, _db.liturgies);
  $$LiturgySectionsTableTableManager get liturgySections =>
      $$LiturgySectionsTableTableManager(
          _db.attachedDatabase, _db.liturgySections);
  $$LiturgyPartsTableTableManager get liturgyParts =>
      $$LiturgyPartsTableTableManager(_db.attachedDatabase, _db.liturgyParts);
}
