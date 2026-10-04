import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

import '../../core/constants/app_constants.dart';
import 'user_data_migrator.dart';

class DatabasePaths {
  const DatabasePaths({
    required this.content,
    required this.user,
  });

  final File content;
  final File user;
}

/// ينفذ الترحيل قبل تثبيت المحتوى، ويتحقق من الملف قبل استبداله.
class DatabaseBootstrap {
  const DatabaseBootstrap();

  Future<DatabasePaths> prepare() async {
    final folder = await getApplicationDocumentsDirectory();
    final legacy = File(p.join(folder.path, 'noor.db'));
    final content = File(p.join(folder.path, 'content.db'));
    final user = File(p.join(folder.path, 'user.db'));
    final prefs = await SharedPreferences.getInstance();
    final installedVersion =
        prefs.getInt(AppConstants.prefInstalledDbVersion) ?? 0;
    final contentIsValid =
        await content.exists() && await content.length() > 1024 * 1024;

    // الترحيل مستقل عن إصدار المحتوى: قد يكون content.db حديثاً بالفعل،
    // بينما لا يزال noor.db القديم موجوداً ولم تُنقل بيانات المستخدم بعد.
    // لذلك يجب فحص علامة الترحيل في كل تشغيل قبل أي استبدال للمحتوى.
    // أي استثناء هنا يمنع لمس قاعدة المحتوى تماماً.
    const UserDataMigrator().migrate(
      legacyDatabase: legacy,
      userDatabase: user,
    );

    if (!contentIsValid ||
        installedVersion < AppConstants.currentDbVersion) {
      await _installVerifiedContent(content);
      await prefs.setInt(
        AppConstants.prefInstalledDbVersion,
        AppConstants.currentDbVersion,
      );
    }

    return DatabasePaths(content: content, user: user);
  }

  void _verifyFts5(File databaseFile) {
    final database = sqlite.sqlite3.open(
      databaseFile.path,
      mode: sqlite.OpenMode.readOnly,
    );
    try {
      final integrity = database.select('PRAGMA integrity_check');
      if (integrity.isEmpty || integrity.first.values.first != 'ok') {
        throw const FileSystemException(
          'فشل فحص سلامة قاعدة المحتوى.',
          'content.db',
        );
      }

      final requiredTables = database.select(
        "SELECT name FROM sqlite_master "
        "WHERE type = 'table' AND name IN ('bible_books', 'bible_verses', 'bible_verses_fts')",
      );
      if (requiredTables.length != 3) {
        throw const FileSystemException(
          'قاعدة المحتوى ناقصة الجداول الأساسية.',
          'content.db',
        );
      }

      final table = database.select(
        "SELECT 1 FROM sqlite_master "
        "WHERE type = 'table' AND name = 'bible_verses_fts' LIMIT 1",
      );
      if (table.isEmpty) {
        throw const FileSystemException(
          'قاعدة المحتوى لا تحتوي على فهرس البحث FTS5.',
        );
      }
      database.select(
        "SELECT verse_id FROM bible_verses_fts "
        "WHERE bible_verses_fts MATCH ? LIMIT 1",
        ['اختبار'],
      );
    } on sqlite.SqliteException {
      throw FileSystemException(
        'مكتبة SQLite على هذا الجهاز لا تدعم فهرس FTS5 المطلوب.',
        databaseFile.path,
      );
    } finally {
      database.close();
    }
  }

  Future<void> _installVerifiedContent(File destination) async {
    final asset = await rootBundle.load('assets/databases/noor.db');
    final bytes = asset.buffer.asUint8List(
      asset.offsetInBytes,
      asset.lengthInBytes,
    );
    final expectedChecksum = sha256.convert(bytes).toString();
    final temporary = File('${destination.path}.installing');
    final backup = File('${destination.path}.backup');

    if (await temporary.exists()) await temporary.delete();
    await destination.parent.create(recursive: true);
    await temporary.writeAsBytes(bytes, flush: true);

    final actualChecksum =
        sha256.convert(await temporary.readAsBytes()).toString();
    if (actualChecksum != expectedChecksum) {
      await temporary.delete();
      throw const FileSystemException(
        'فشل التحقق من سلامة قاعدة المحتوى الجديدة.',
      );
    }
    _verifyFts5(temporary);

    if (await backup.exists()) await backup.delete();
    try {
      if (await destination.exists()) {
        await destination.rename(backup.path);
      }
      await temporary.rename(destination.path);
      if (await backup.exists()) await backup.delete();
    } catch (_) {
      if (!await destination.exists() && await backup.exists()) {
        await backup.rename(destination.path);
      }
      rethrow;
    } finally {
      if (await temporary.exists()) await temporary.delete();
    }
  }
}
