import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static late Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  final String tableName = 'tableKontak';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnValue = 'value';

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "mydb.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // Here you can create the tables for your database
    await db.execute(
        "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, "
            "$columnName TEXT,"
            "$columnValue TEXT)");
  }

  Future<int> saveData(String table, Map<String, dynamic> data) async {
    var dbClient = await db;
    int res = await dbClient.insert(table, data);
    return res;
  }

  Future<List<Map<String, dynamic>>> getData() async {
    var dbClient = await db;
    List<Map<String, dynamic>> list = await dbClient.query(tableName,columns: [
        columnId,
        columnName,
        columnValue,
        ]);
    return list;
  }

  Future<int> updateData(String table, Map<String, dynamic> data) async {
    var dbClient = await db;
    int res = await dbClient.update(table, data,
        where: "id = ?", whereArgs: [data['id']]);
    return res;
  }

  Future<int> deleteData(String table, int id) async {
    var dbClient = await db;
    int res =
    await dbClient.delete(table, where: "id = ?", whereArgs: [id]);
    return res;
  }

}
