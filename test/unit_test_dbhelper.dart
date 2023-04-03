import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_contact/model/kontak.dart';
import 'package:flutter_contact/database/dbhelper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  group('DBHelper Tests', () {
    late DBHelper dbHelper;
    late Database database;

    setUp(() async {
      database = await openDatabase(join(await getDatabasesPath(), 'kontak.db'),
      onCreate: (db, version){
        return db.execute("CREATE TABLE tableKontak(id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "nama TEXT,"
            "no TEXT,"
            "email TEXT,"
            "company TEXT)");
      },
      version: 1);
      dbHelper = DBHelper();
    });

    test('Save Kontak Test', () async {
      Kontak kontak = Kontak(
        nama: 'John Doe',
        no: '08123456789',
        email: 'john.doe@mail.com',
        company: 'ABC Company',
      );
      int? result = await dbHelper.saveKontak(kontak);
      expect(result, isNotNull);
    });

    test('Get All Kontak Test', () async {
      List? result = await dbHelper.getAllKontak();
      expect(result!.length, greaterThanOrEqualTo(1));
    });

    test('Update Kontak Test', () async {
      List? result = await dbHelper.getAllKontak();
      int id = result![0]['id'];
      Kontak kontak = Kontak(
        id: id,
        nama: 'John Doe',
        no: '08123456789',
        email: 'john.doe@mail.com',
        company: 'XYZ Company',
      );
      int? updateResult = await dbHelper.updateKontak(kontak);
      expect(updateResult, greaterThanOrEqualTo(1));
    });

    test('Delete Kontak Test', () async {
      List? result = await dbHelper.getAllKontak();
      int id = result![0]['id'];
      int? deleteResult = await dbHelper.deleteKontak(id);
      expect(deleteResult, greaterThanOrEqualTo(1));
    });
  });
}