
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

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database?> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(await databasesPath, 'kontak.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create your tables here
        await db.execute('''
          CREATE TABLE kontak(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            no TEXT,
            email TEXT,
            company TEXT
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
    final dbClient = await database;
    return await dbClient.insert('kontak', kontak.toMap());
  }

  //read database
  Future<List?> getAllKontak() async {
    final db = await database;
    var result = await db.query('kontak', columns: [
      'id',
      'nama',
      'no',
      'email',
      'company'
    ]);

    return result.toList();
    // final contacts = await db.query('kontak');
    // return contacts.map((c) => Kontak.fromMap(c)).toList();
  }

  //update database
  Future<int?> updateKontak(Kontak kontak) async {
    final dbClient = await database;
    return await dbClient.update('kontak', kontak.toMap(), where: 'id = ?', whereArgs: [kontak.id]);
  }

  //hapus database
  Future<int?> deleteKontak(int id) async {
    final dbClient = await database;
    return await dbClient.delete('kontak',  where: 'id = ?', whereArgs: [id]);
  }

  Future<void> closeDatabaseConnection() async {
    // Close the database connection
    final dbClient = await database;
    await dbClient.close();
  }
}

