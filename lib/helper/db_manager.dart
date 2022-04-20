import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBManager {
  static Future<Database> database() async {
    final dbPath =
        await getDatabasesPath(); //path of the database in the hard drive
    return openDatabase(path.join(dbPath, 'places.db'), //open the database
        onCreate: (db, version) {
      //called if the database doesn't exist, creates new database
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)'); //REAL is basically a double datatype for SQL
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    print("          $data              ");
    final db = await DBManager.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    ); //helps insert a map of [values] into the specified [table]
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBManager.database();
    return db.query(table);
  }
}
