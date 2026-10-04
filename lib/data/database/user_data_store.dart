import 'dart:io';

import 'package:sqlite3/sqlite3.dart';

import 'bookmark_model.dart';
import 'content_key.dart';

/// طبقة الوصول الوحيدة إلى البيانات التي ينشئها المستخدم.
class UserDataStore {
  UserDataStore._(this._db);

  final Database _db;

  factory UserDataStore.open(File file) {
    file.parent.createSync(recursive: true);
    final db = sqlite3.open(file.path);
    _createSchema(db);
    return UserDataStore._(db);
  }

  factory UserDataStore.memory() {
    final db = sqlite3.openInMemory();
    _createSchema(db);
    return UserDataStore._(db);
  }

  static void _createSchema(Database db) {
    db.execute('PRAGMA foreign_keys = ON');
    db.execute('PRAGMA journal_mode = WAL');
    db.execute('''CREATE TABLE IF NOT EXISTS bookmarks (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      content_type TEXT NOT NULL,
      content_id TEXT NOT NULL,
      display_title TEXT NOT NULL,
      note TEXT,
      created_at INTEGER NOT NULL,
      UNIQUE(content_type, content_id)
    )''');
    db.execute('''CREATE TABLE IF NOT EXISTS verse_highlights (
      id TEXT PRIMARY KEY NOT NULL,
      book_id INTEGER NOT NULL,
      chapter INTEGER NOT NULL,
      verse_number INTEGER NOT NULL,
      color TEXT NOT NULL,
      created_at TEXT NOT NULL,
      UNIQUE(book_id, chapter, verse_number)
    )''');
  }

  Future<List<Bookmark>> getAllBookmarks() async {
    return _db
        .select('SELECT * FROM bookmarks ORDER BY created_at DESC')
        .map(_bookmarkFromRow)
        .toList(growable: false);
  }

  Future<List<Bookmark>> getBookmarksByType(String contentType) async {
    return _db
        .select(
          'SELECT * FROM bookmarks WHERE content_type = ? ORDER BY created_at DESC',
          [contentType],
        )
        .map(_bookmarkFromRow)
        .toList(growable: false);
  }

  Future<int> addBookmark({
    required String contentType,
    required String contentId,
    required String displayTitle,
    String? note,
  }) async {
    final createdAt = DateTime.now().millisecondsSinceEpoch;
    final stableId = ContentKey.canonicalizeBookmark(contentType, contentId);
    _db.execute('''
      INSERT INTO bookmarks
        (content_type, content_id, display_title, note, created_at)
      VALUES (?, ?, ?, ?, ?)
      ON CONFLICT(content_type, content_id) DO UPDATE SET
        display_title = excluded.display_title,
        note = excluded.note
    ''', [contentType, stableId, displayTitle, note, createdAt]);
    return _db.lastInsertRowId;
  }

  Future<int> removeBookmark(int id) async {
    _db.execute('DELETE FROM bookmarks WHERE id = ?', [id]);
    return _db.updatedRows;
  }

  Future<bool> isBookmarked(String contentType, String contentId) async {
    final stableId = ContentKey.canonicalizeBookmark(contentType, contentId);
    return _db.select(
      'SELECT 1 FROM bookmarks WHERE content_type = ? AND content_id = ? LIMIT 1',
      [contentType, stableId],
    ).isNotEmpty;
  }

  Future<Map<int, String>> getChapterHighlights(
    int bookId,
    int chapter,
  ) async {
    final rows = _db.select(
      'SELECT verse_number, color FROM verse_highlights '
      'WHERE book_id = ? AND chapter = ?',
      [bookId, chapter],
    );
    return {
      for (final row in rows)
        row['verse_number'] as int: row['color'] as String,
    };
  }

  Future<void> setVerseHighlight(
    int bookId,
    int chapter,
    int verseNumber,
    String color,
  ) async {
    final id = '$bookId:$chapter:$verseNumber';
    _db.execute('''
      INSERT INTO verse_highlights
        (id, book_id, chapter, verse_number, color, created_at)
      VALUES (?, ?, ?, ?, ?, ?)
      ON CONFLICT(id) DO UPDATE SET
        color = excluded.color,
        created_at = excluded.created_at
    ''', [
      id,
      bookId,
      chapter,
      verseNumber,
      color,
      DateTime.now().toUtc().toIso8601String(),
    ]);
  }

  Future<void> removeVerseHighlight(
    int bookId,
    int chapter,
    int verseNumber,
  ) async {
    _db.execute(
      'DELETE FROM verse_highlights WHERE id = ?',
      ['$bookId:$chapter:$verseNumber'],
    );
  }

  Future<void> close() async => _db.close();

  Bookmark _bookmarkFromRow(Row row) {
    final rawDate = row['created_at'];
    final createdAt = rawDate is int
        ? DateTime.fromMillisecondsSinceEpoch(
            rawDate.abs() < 100000000000 ? rawDate * 1000 : rawDate,
          )
        : DateTime.parse(rawDate.toString());
    return Bookmark(
      id: row['id'] as int,
      contentType: row['content_type'] as String,
      contentId: row['content_id'] as String,
      displayTitle: row['display_title'] as String,
      note: row['note'] as String?,
      createdAt: createdAt,
    );
  }
}
