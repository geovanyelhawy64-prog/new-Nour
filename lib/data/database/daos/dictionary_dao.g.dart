// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_dao.dart';

// ignore_for_file: type=lint
mixin _$DictionaryDaoMixin on DatabaseAccessor<AppDatabase> {
  $CopticDictionaryTable get copticDictionary =>
      attachedDatabase.copticDictionary;
  DictionaryDaoManager get managers => DictionaryDaoManager(this);
}

class DictionaryDaoManager {
  final _$DictionaryDaoMixin _db;
  DictionaryDaoManager(this._db);
  $$CopticDictionaryTableTableManager get copticDictionary =>
      $$CopticDictionaryTableTableManager(
          _db.attachedDatabase, _db.copticDictionary);
}
