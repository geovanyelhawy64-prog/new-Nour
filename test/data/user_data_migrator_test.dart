import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/data/database/user_data_migrator.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  late Directory temp;
  late File legacy;
  late File userFile;

  setUp(() {
    temp = Directory.systemTemp.createTempSync('noor_migration_test_');
    legacy = File('${temp.path}/noor.db');
    userFile = File('${temp.path}/user.db');
  });

  tearDown(() => temp.deleteSync(recursive: true));

  test('ينقل المحفوظات والتظليل ويكتب علامة الإتمام', () {
    final old = sqlite3.open(legacy.path);
    old.execute('''CREATE TABLE bookmarks (
      id INTEGER PRIMARY KEY, content_type TEXT NOT NULL,
      content_id TEXT NOT NULL, display_title TEXT NOT NULL,
      note TEXT, created_at INTEGER NOT NULL)''');
    old.execute(
      'INSERT INTO bookmarks VALUES (1, ?, ?, ?, ?, ?)',
      ['bible', '43:3:16', 'يوحنا ٣: ١٦', 'ملاحظة', 1234],
    );
    old.execute('''CREATE TABLE verse_highlights (
      id TEXT PRIMARY KEY, book_id INTEGER NOT NULL, chapter INTEGER NOT NULL,
      verse_number INTEGER NOT NULL, color TEXT NOT NULL, created_at TEXT NOT NULL)''');
    old.execute(
      'INSERT INTO verse_highlights VALUES (?, ?, ?, ?, ?, ?)',
      ['43:3:16', 43, 3, 16, 'gold', '2026-10-03T00:00:00Z'],
    );
    old.dispose();

    final result = const UserDataMigrator().migrate(
      legacyDatabase: legacy,
      userDatabase: userFile,
    );

    expect(result.alreadyCompleted, isFalse);
    expect(result.bookmarksCopied, 1);
    expect(result.highlightsCopied, 1);
    final user = sqlite3.open(userFile.path);
    expect(user.select('SELECT * FROM bookmarks'), hasLength(1));
    expect(user.select('SELECT * FROM verse_highlights'), hasLength(1));
    expect(
      user.select(
        'SELECT * FROM migration_metadata WHERE migration_key = ?',
        [UserDataMigrator.migrationKey],
      ),
      hasLength(1),
    );
    user.dispose();
  });

  test('إعادة التشغيل بعد النجاح لا تكرر البيانات', () {
    final old = sqlite3.open(legacy.path);
    old.execute('''CREATE TABLE bookmarks (
      id INTEGER PRIMARY KEY, content_type TEXT, content_id TEXT,
      display_title TEXT, note TEXT, created_at INTEGER)''');
    old.execute("INSERT INTO bookmarks VALUES (1, 'bible', '1:1:1', 'تك ١:١', NULL, 1)");
    old.dispose();

    const migrator = UserDataMigrator();
    migrator.migrate(legacyDatabase: legacy, userDatabase: userFile);
    final second = migrator.migrate(legacyDatabase: legacy, userDatabase: userFile);

    expect(second.alreadyCompleted, isTrue);
    final user = sqlite3.open(userFile.path);
    expect(user.select('SELECT * FROM bookmarks'), hasLength(1));
    user.dispose();
  });

  test('أي مخطط غير معروف يتراجع بالكامل ولا يكتب علامة نجاح', () {
    final old = sqlite3.open(legacy.path);
    old.execute('CREATE TABLE bookmarks (id INTEGER PRIMARY KEY, mystery TEXT)');
    old.execute("INSERT INTO bookmarks VALUES (1, 'do not lose me')");
    old.dispose();

    expect(
      () => const UserDataMigrator().migrate(
        legacyDatabase: legacy,
        userDatabase: userFile,
      ),
      throwsStateError,
    );

    final user = sqlite3.open(userFile.path);
    expect(user.select('SELECT * FROM bookmarks'), isEmpty);
    expect(user.select('SELECT * FROM migration_metadata'), isEmpty);
    user.dispose();
  });

  test('يدعم مخطط المحفوظات الأقدم', () {
    final old = sqlite3.open(legacy.path);
    old.execute('''CREATE TABLE bookmarks (
      id INTEGER PRIMARY KEY, item_type TEXT, item_id TEXT,
      title TEXT, subtitle TEXT, created_at INTEGER)''');
    old.execute("INSERT INTO bookmarks VALUES (1, 'agpeya', 'prime', 'باكر', 'مزمور', 5)");
    old.dispose();

    const UserDataMigrator().migrate(
      legacyDatabase: legacy,
      userDatabase: userFile,
    );
    final user = sqlite3.open(userFile.path);
    final row = user.select('SELECT * FROM bookmarks').single;
    expect(row['content_type'], 'agpeya');
    expect(row['content_id'], 'prime');
    expect(row['display_title'], 'باكر');
    user.dispose();
  });
}
