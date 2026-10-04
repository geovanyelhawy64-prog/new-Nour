import '../../data/database/app_database.dart';

class DatabaseService {
  static late AppDatabase _db;

  DatabaseService._();

  static AppDatabase get instance => _db;

  static Future<void> init([AppDatabase? database]) async {
    _db = database ?? AppDatabase();
  }

  static Future<void> close() async {
    await _db.close();
  }
}
