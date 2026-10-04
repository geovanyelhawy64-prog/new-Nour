import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../data/database/app_database.dart';
import '../../data/database/user_data_migrator.dart';
import '../../data/database/user_data_store.dart';

class DatabaseService {
  static late AppDatabase _db;

  DatabaseService._();

  static AppDatabase get instance => _db;

  static UserDataStore? _userStore;

  /// وصول إلى ملف user.db المستقل عن قاعدة المحتوى.
  static UserDataStore get userStore {
    final store = _userStore;
    if (store == null) {
      throw StateError('UserDataStore не инициализирован. Вызовите DatabaseService.init');
    }
    return store;
  }

  /// بِروكسي توافقية: الموضع السابق للـ DAO على مستوى AppDatabase
  /// يستبدل الآن مهمة التخزين الثنائية مع UserDataStore.
  static UserDataStore get bookmarksDao => userStore;

  static Future<void> init([AppDatabase? database]) async {
    if (database != null) {
      _db = database;
      _userStore = UserDataStore.memory();
      return;
    }
    _db = AppDatabase();
    final dir = await getApplicationDocumentsDirectory();
    final userFile = File(p.join(dir.path, 'user.db'));
    final legacyFile = File(p.join(dir.path, 'noor.db'));
    const migrator = UserDataMigrator();
    migrator.migrate(
      legacyDatabase: legacyFile,
      userDatabase: userFile,
    );
    _userStore = UserDataStore.open(userFile);
  }

  static Future<void> close() async {
    await _db.close();
    await _userStore?.close();
  }
}
