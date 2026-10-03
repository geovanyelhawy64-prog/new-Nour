import '../../data/database/app_database.dart';
import '../../data/database/database_bootstrap.dart';
import '../../data/database/user_data_store.dart';

class DatabaseService {
  static late AppDatabase _db;
  static late UserDataStore _userData;

  DatabaseService._();

  static AppDatabase get instance => _db;
  static UserDataStore get userData => _userData;

  /// عند تمرير قاعدة اختبار تُستخدم قاعدة مستخدم في الذاكرة تلقائياً.
  static Future<void> init([
    AppDatabase? database,
    UserDataStore? userData,
  ]) async {
    if (database != null) {
      _db = database;
      _userData = userData ?? UserDataStore.memory();
      return;
    }

    final paths = await const DatabaseBootstrap().prepare();
    _userData = userData ?? UserDataStore.open(paths.user);
    _db = AppDatabase();
  }

  static Future<void> close() async {
    await _db.close();
    await _userData.close();
  }
}
