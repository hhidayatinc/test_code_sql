import 'package:flutter/material.dart';
import 'package:flutter_contact/model/kontak.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tableKontak';
  final String columnId = 'id';
  final String columnName = 'nama';
  final String columnMobileNo = 'no';
  final String columnEmail = 'email';
  final String columnCompany = 'company';

  DBHelper._internal();
  factory DBHelper() => _instance;

  Future<Database?> get _db  async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'kontak.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$columnName TEXT,"
        "$columnMobileNo TEXT,"
        "$columnEmail TEXT,"
        "$columnCompany TEXT)";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> saveKontak(Kontak kontak) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, kontak.toMap());
  }

  //read database
  Future<List?> getAllKontak() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnName,
      columnCompany,
      columnMobileNo,
      columnEmail
    ]);

    return result.toList();
  }

  //update database
  Future<int?> updateKontak(Kontak kontak) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, kontak.toMap(), where: '$columnId = ?', whereArgs: [kontak.id]);
  }

  //hapus database
  Future<int?> deleteKontak(int id) async {
    var dbClient = await _db;
    return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}

  // void main() async{
  //   WidgetsFlutterBinding.ensureInitialized();
  //   final database = openDatabase(
  //     join(await getDatabasesPath(), 'kontak.db'),
  //         onCreate: (db, version){
  //           return db.execute('CREATE TABLE kontak (id INTEGER PRIMARY KEY AUTOINCREMENT,nama TEXT,no TEXT,email TEXT,company TEXT)');
  //         },
  //         version: 1
  //   );
  //   Future<int> insertKontak(Kontak kontak) async{
  //     final db = await database;
  //     int count = await db.insert('kontak', kontak.toMap());
  //     return count;
  //   }
  //
  //   Future<int> updateKontak(Kontak kontak) async{
  //     final db = await database;
  //     int count = await db.update('kontak', kontak.toMap(), where: 'id = ?', whereArgs: [kontak.id]);
  //     return count;
  //   }
  //
  //   Future<int> deleteKontak(int id) async {
  //     final db = await database;
  //     int count = await db.delete('kontak', where: 'id = ?', whereArgs: [id]);
  //     return count;
  //   }
  //
  //   Future<List<Kontak>> getKontakList()async{
  //     final db = await database;
  //     final List<Map<String, dynamic>> maps = await db.query('kontak');
  //     return List.generate(maps.length, (i) {
  //       return Kontak(nama: maps[i]['nama'], no: maps[i]['no'], email: maps[i]['email'], company: maps[i]['company']);
  //     });
  //   }
  // }
//}