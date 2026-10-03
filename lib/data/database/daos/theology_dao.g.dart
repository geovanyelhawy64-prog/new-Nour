// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theology_dao.dart';

// ignore_for_file: type=lint
mixin _$TheologyDaoMixin on DatabaseAccessor<AppDatabase> {
  $TheologyArticlesTable get theologyArticles =>
      attachedDatabase.theologyArticles;
  TheologyDaoManager get managers => TheologyDaoManager(this);
}

class TheologyDaoManager {
  final _$TheologyDaoMixin _db;
  TheologyDaoManager(this._db);
  $$TheologyArticlesTableTableManager get theologyArticles =>
      $$TheologyArticlesTableTableManager(
          _db.attachedDatabase, _db.theologyArticles);
}
