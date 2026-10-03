// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'psali_dao.dart';

// ignore_for_file: type=lint
mixin _$PsaliDaoMixin on DatabaseAccessor<AppDatabase> {
  $PsalisTable get psalis => attachedDatabase.psalis;
  $PsaliSectionsTable get psaliSections => attachedDatabase.psaliSections;
  PsaliDaoManager get managers => PsaliDaoManager(this);
}

class PsaliDaoManager {
  final _$PsaliDaoMixin _db;
  PsaliDaoManager(this._db);
  $$PsalisTableTableManager get psalis =>
      $$PsalisTableTableManager(_db.attachedDatabase, _db.psalis);
  $$PsaliSectionsTableTableManager get psaliSections =>
      $$PsaliSectionsTableTableManager(_db.attachedDatabase, _db.psaliSections);
}
