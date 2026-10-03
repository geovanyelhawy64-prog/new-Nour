// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rite_dao.dart';

// ignore_for_file: type=lint
mixin _$RiteDaoMixin on DatabaseAccessor<AppDatabase> {
  $RitesTable get rites => attachedDatabase.rites;
  $RiteSectionsTable get riteSections => attachedDatabase.riteSections;
  RiteDaoManager get managers => RiteDaoManager(this);
}

class RiteDaoManager {
  final _$RiteDaoMixin _db;
  RiteDaoManager(this._db);
  $$RitesTableTableManager get rites =>
      $$RitesTableTableManager(_db.attachedDatabase, _db.rites);
  $$RiteSectionsTableTableManager get riteSections =>
      $$RiteSectionsTableTableManager(_db.attachedDatabase, _db.riteSections);
}
