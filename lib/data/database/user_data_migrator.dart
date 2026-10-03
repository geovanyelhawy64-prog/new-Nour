import 'dart:io';

import 'package:sqlite3/sqlite3.dart';

import 'content_key.dart';

/// نتيجة ترحيل بيانات المستخدم من قاعدة الإصدارات القديمة.
class UserDataMigrationResult {
  const UserDataMigrationResult({
    required this.alreadyCompleted,
    required this.bookmarksCopied,
    required this.highlightsCopied,
  });

  final bool alreadyCompleted;
  final int bookmarksCopied;
  final int highlightsCopied;
}

/// ينقل البيانات التي أنشأها المستخدم إلى قاعدة مستقلة.
///
/// الترحيل idempotent: علامة الإتمام ونسخ الصفوف يحدثان في المعاملة نفسها.
/// لذلك فإن انقطاع التطبيق قبل COMMIT لا يترك ترحيلاً معلماً كنـاجح.
class UserDataMigrator {
  static const migrationKey = 'legacy_content_db_to_user_db_v1';

  const UserDataMigrator();

  UserDataMigrationResult migrate({
    required File legacyDatabase,
    required File userDatabase,
  }) {
    userDatabase.parent.createSync(recursive: true);
    final user = sqlite3.open(userDatabase.path);
    Database? legacy;

    try {
      _createUserSchema(user);
      if (_isCompleted(user)) {
        return const UserDataMigrationResult(
          alreadyCompleted: true,
          bookmarksCopied: 0,
          highlightsCopied: 0,
        );
      }

      user.execute('BEGIN IMMEDIATE');
      try {
        var bookmarksCopied = 0;
        var highlightsCopied = 0;

        if (legacyDatabase.existsSync()) {
          legacy = sqlite3.open(legacyDatabase.path, mode: OpenMode.readOnly);
          bookmarksCopied = _copyBookmarks(legacy, user);
          highlightsCopied = _copyHighlights(legacy, user);
        }

        user.execute(
          'INSERT INTO migration_metadata (migration_key, completed_at) '
          'VALUES (?, ?)',
          [migrationKey, DateTime.now().toUtc().toIso8601String()],
        );
        user.execute('COMMIT');

        return UserDataMigrationResult(
          alreadyCompleted: false,
          bookmarksCopied: bookmarksCopied,
          highlightsCopied: highlightsCopied,
        );
      } catch (_) {
        user.execute('ROLLBACK');
        rethrow;
      }
    } finally {
      legacy?.dispose();
      user.dispose();
    }
  }

  void _createUserSchema(Database db) {
    db.execute('PRAGMA foreign_keys = ON');
    db.execute('''
      CREATE TABLE IF NOT EXISTS migration_metadata (
        migration_key TEXT PRIMARY KEY NOT NULL,
        completed_at TEXT NOT NULL
      )
    ''');
    db.execute('''
      CREATE TABLE IF NOT EXISTS bookmarks (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        content_type TEXT NOT NULL,
        content_id TEXT NOT NULL,
        display_title TEXT NOT NULL,
        note TEXT,
        created_at INTEGER NOT NULL,
        UNIQUE(content_type, content_id)
      )
    ''');
    db.execute('''
      CREATE TABLE IF NOT EXISTS verse_highlights (
        id TEXT PRIMARY KEY NOT NULL,
        book_id INTEGER NOT NULL,
        chapter INTEGER NOT NULL,
        verse_number INTEGER NOT NULL,
        color TEXT NOT NULL,
        created_at TEXT NOT NULL,
        UNIQUE(book_id, chapter, verse_number)
      )
    ''');
  }

  bool _isCompleted(Database db) => db.select(
        'SELECT 1 FROM migration_metadata WHERE migration_key = ? LIMIT 1',
        [migrationKey],
      ).isNotEmpty;

  int _copyBookmarks(Database legacy, Database user) {
    if (!_tableExists(legacy, 'bookmarks')) return 0;
    final columns = _columns(legacy, 'bookmarks');
    final modern = {
      'content_type',
      'content_id',
      'display_title',
      'note',
      'created_at',
    }.every(columns.contains);
    final old = {
      'item_type',
      'item_id',
      'title',
      'subtitle',
      'created_at',
    }.every(columns.contains);
    if (!modern && !old) {
      throw StateError('مخطط bookmarks القديم غير معروف؛ أُلغي الترحيل حمايةً للبيانات.');
    }

    final rows = legacy.select(modern
        ? 'SELECT content_type, content_id, display_title, note, created_at FROM bookmarks'
        : 'SELECT item_type AS content_type, item_id AS content_id, title AS display_title, '
            'subtitle AS note, created_at FROM bookmarks');
    var copied = 0;
    final statement = user.prepare('''
      INSERT INTO bookmarks
        (content_type, content_id, display_title, note, created_at)
      VALUES (?, ?, ?, ?, ?)
      ON CONFLICT(content_type, content_id) DO UPDATE SET
        display_title = excluded.display_title,
        note = excluded.note
    ''');
    try {
      for (final row in rows) {
        final contentType = row['content_type'] as String;
        final contentId = row['content_id'] as String;
        statement.execute([
          contentType,
          ContentKey.canonicalizeBookmark(contentType, contentId),
          row['display_title'],
          row['note'],
          row['created_at'],
        ]);
        copied++;
      }
    } finally {
      statement.dispose();
    }
    return copied;
  }

  int _copyHighlights(Database legacy, Database user) {
    if (!_tableExists(legacy, 'verse_highlights')) return 0;
    final required = {
      'id',
      'book_id',
      'chapter',
      'verse_number',
      'color',
      'created_at',
    };
    if (!required.every(_columns(legacy, 'verse_highlights').contains)) {
      throw StateError('مخطط verse_highlights القديم غير معروف؛ أُلغي الترحيل حمايةً للبيانات.');
    }

    final rows = legacy.select(
      'SELECT id, book_id, chapter, verse_number, color, created_at '
      'FROM verse_highlights',
    );
    var copied = 0;
    final statement = user.prepare('''
      INSERT INTO verse_highlights
        (id, book_id, chapter, verse_number, color, created_at)
      VALUES (?, ?, ?, ?, ?, ?)
      ON CONFLICT(id) DO UPDATE SET color = excluded.color
    ''');
    try {
      for (final row in rows) {
        statement.execute([
          row['id'],
          row['book_id'],
          row['chapter'],
          row['verse_number'],
          row['color'],
          row['created_at'],
        ]);
        copied++;
      }
    } finally {
      statement.dispose();
    }
    return copied;
  }

  bool _tableExists(Database db, String name) => db.select(
        "SELECT 1 FROM sqlite_master WHERE type = 'table' AND name = ?",
        [name],
      ).isNotEmpty;

  Set<String> _columns(Database db, String table) => db
      .select('PRAGMA table_info($table)')
      .map((row) => row['name'] as String)
      .toSet();
}
