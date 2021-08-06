import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    return sql.openDatabase(
      path.join(await sql.getDatabasesPath(), 'places.db'),
      onCreate: (db, version) async => await db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)',
      ),
      version: 1,
    );
  }

  static Future<void> insert(Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(
      'user_places',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await DBHelper.database();
    return await db.query('user_places');
  }
}
