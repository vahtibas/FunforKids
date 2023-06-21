import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_database.db');

    // Veritabanı oluşturma ve açma
    var myDatabase = await openDatabase(path, version: 1, onCreate: _onCreate);
    return myDatabase;
  }

  void _onCreate(Database db, int version) async {
    // Veritabanı tablosunu oluşturma
    await db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY, email TEXT, password TEXT)');
  }

  Future<void> insertUserData(String email, String password) async {
    var dbClient = await db;
    await dbClient.rawInsert(
        'INSERT INTO users(email, password) VALUES("$email", "$password")');
  }

  Future<Map<String, dynamic>> getUserData() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery('SELECT * FROM users LIMIT 1');
    if (result.length > 0) {
      return result.first;
    }
    return {};
  }
}
