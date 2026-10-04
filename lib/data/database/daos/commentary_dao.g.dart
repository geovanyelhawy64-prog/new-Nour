// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentary_dao.dart';

// ignore_for_file: type=lint
mixin _$CommentaryDaoMixin on DatabaseAccessor<AppDatabase> {
  $BibleCommentariesTable get bibleCommentaries =>
      attachedDatabase.bibleCommentaries;
  CommentaryDaoManager get managers => CommentaryDaoManager(this);
}

class CommentaryDaoManager {
  final _$CommentaryDaoMixin _db;
  CommentaryDaoManager(this._db);
  $$BibleCommentariesTableTableManager get bibleCommentaries =>
      $$BibleCommentariesTableTableManager(
          _db.attachedDatabase, _db.bibleCommentaries);
}
