// import 'dart:async';
// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = new DatabaseHelper.internal();

//   factory DatabaseHelper() => _instance;

//   //static Database _db;

//   Future<Database> get db async {
//     if (_db != null) {
//       return _db;
//     }
//     _db = await initDb();
//     return _db;
//   }

//   //DatabaseHelper.internal();

//   initDb() async {
//     Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, "kontak.db");
//     var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
//     return theDb;
//   }

//   void _onCreate(Database db, int version) async {
//     await db.execute(
//         "CREATE TABLE kontak(id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone TEXT, company TEXT)");
//     print("Table is created");
//   }

//   Future<int> saveContact(Kontak contact) async {
//     var dbClient = await db;
//     int res = await dbClient.insert("kontak", contact.toMap());
//     return res;
//   }

//   Future<List<Kontak>> getContacts() async {
//     var dbClient = await db;
//     List<Map> list = await dbClient.rawQuery('SELECT * FROM kontak');
//     List<Kontak> contacts = new List();
//     for (int i = 0; i < list.length; i++) {
//       var contact = new Kontak(
//         list[i]["name"],
//         list[i]["email"],
//         list[i]["phone"],
//         list[i]["image"],
//       );
//       contact.setContactId(list[i]["id"]);
//       contacts.add(contact);
//     }
//     return contacts;
//   }

//   Future<int> deleteContact(Kontak contact) async {
//     var dbClient = await db;
//     int res =
//     await dbClient.rawDelete('DELETE FROM kontak WHERE id = ?', [contact.id]);
//     return res;
//   }

//   Future<bool> updateContact(Kontak contact) async {
//     var dbClient = await db;
//     int res = await dbClient.update("kontak", contact.toMap(),
//         where: "id = ?", whereArgs: <int>[contact.id]);
//     return res > 0 ? true : false;
//   }
// }