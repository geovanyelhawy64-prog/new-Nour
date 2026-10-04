// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sacraments_dao.dart';

// ignore_for_file: type=lint
mixin _$SacramentsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SacramentsTable get sacraments => attachedDatabase.sacraments;
  $SacramentSectionsTable get sacramentSections =>
      attachedDatabase.sacramentSections;
  SacramentsDaoManager get managers => SacramentsDaoManager(this);
}

class SacramentsDaoManager {
  final _$SacramentsDaoMixin _db;
  SacramentsDaoManager(this._db);
  $$SacramentsTableTableManager get sacraments =>
      $$SacramentsTableTableManager(_db.attachedDatabase, _db.sacraments);
  $$SacramentSectionsTableTableManager get sacramentSections =>
      $$SacramentSectionsTableTableManager(
          _db.attachedDatabase, _db.sacramentSections);
}
