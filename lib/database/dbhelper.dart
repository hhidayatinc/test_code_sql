
import 'package:flutter/cupertino.dart';
import 'package:flutter_contact/model/kontak.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static final DBHelper instance = DBHelper._internal();

  factory DBHelper() => instance;

  DBHelper._internal();

  static Database? _database;

  final String tableName = 'kontak';
  final String columnId = 'id';
  final String columnName = 'nama';
  final String columnMobileNo = 'no';
  final String columnEmail = 'email';
  final String columnCompany = 'company';

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database?> initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final databasesPath = await getApplicationDocumentsDirectory();
    final path = join(databasesPath.path, 'listkontak.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create your tables here
        await db.execute('''
          CREATE TABLE $tableName(
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT,
            $columnMobileNo TEXT,
            $columnEmail TEXT,
            $columnCompany TEXT
          )
        ''');
      },
    );
    // WidgetsFlutterBinding.ensureInitialized();
    // final documentsDirectory = await getApplicationDocumentsDirectory();
    // final path = join(documentsDirectory.path, 'kontak.db');
    // return await openDatabase(path,
    //     version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  // Future<void> _onCreate(Database db, int version) async {
  //   var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, "
  //       "$columnName TEXT,"
  //       "$columnMobileNo TEXT,"
  //       "$columnEmail TEXT,"
  //       "$columnCompany TEXT)";
  //   await db.execute(sql);
  // }

  //insert ke database
  Future<int?> saveKontak(Kontak kontak) async {
    var dbClient = await database;
    return await dbClient!.insert(tableName, kontak.toMap());
    //return await dbClient.rawInsert('INSERT INTO kontak (nama, no, email, company) VALUES (?, ?, ?, ?)', [kontak.nama, kontak.no, kontak.email, kontak.id]);
  }
  //read database
  Future<List?> getAllKontak() async {
    var db = await database;
    var result = await db!.query(tableName, columns: [
      columnId,
      columnName,
      columnCompany,
      columnMobileNo,
      columnEmail
    ]);

    return result.toList();
    // final contacts = await db.query('kontak');
    // return contacts.map((c) => Kontak.fromMap(c)).toList();
  }

  //update database
  Future<int?> updateKontak(Kontak kontak) async {
    var dbClient = await database;
    return await dbClient!.update(tableName, kontak.toMap(), where: '$columnId = ?', whereArgs: [kontak.id]);
  }

  //hapus database
  Future<int?> deleteKontak(int id) async {
    final dbClient = await database;
    return await dbClient!.delete(tableName,  where: '$columnId = ?', whereArgs: [id]);
  }


}

