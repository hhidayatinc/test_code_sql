import 'package:flutter_contact/database/dbhelper.dart';
import 'package:flutter_contact/model/kontak.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Initialize sqflite for test.
void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

Future main() async {
  DBHelper dbhelper = DBHelper();
  setUpAll(() async{
    sqfliteTestInit();
     var db = await openDatabase(inMemoryDatabasePath);
     await db.execute("CREATE TABLE tableKontak(id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "nama TEXT,"
        "no TEXT,"
        "email TEXT,"
        "company TEXT)");
  });
  test('insert data', () async {
    Kontak kontak = Kontak(nama: 'John Doe', no: '08123456789', email: 'johndoe@example.com', company: 'Example Inc.');
    int? result = await dbhelper.saveKontak(kontak);
    expect(result, isNotNull);
  });
  test('Get All Kontak Test', () async {
    List? result = await dbhelper.getAllKontak();
    expect(result!.length, greaterThanOrEqualTo(1));
  });
  test('Update Kontak Test', () async {
    List? result = await dbhelper.getAllKontak();
    int id = result![0]['id'];
    Kontak kontak = Kontak(
      id: id,
      nama: 'John Doe',
      no: '08123456789',
      email: 'john.doe@mail.com',
      company: 'XYZ Company',
    );
    int? updateResult = await dbhelper.updateKontak(kontak);
    expect(updateResult, greaterThanOrEqualTo(1));
  });
  test('Delete Kontak Test', () async {
    List? result = await dbhelper.getAllKontak();
    int id = result![0]['id'];
    int? deleteResult = await dbhelper.deleteKontak(id);
    expect(deleteResult, greaterThanOrEqualTo(1));
  });
}