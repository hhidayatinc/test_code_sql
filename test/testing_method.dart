import 'package:flutter_contact/database/dbhelper.dart';
import 'package:flutter_contact/model/kontak.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'widget_test.dart';

/// Initialize sqflite for test.
void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

Future main() async {
  DBHelper dbhelper = DBHelper();
  sqfliteTestInit();

  test('insert data', () async {
    await dbhelper.initDatabase();
    Kontak kontak = Kontak(nama: 'Ana', no: '08123456789', email: 'johndoe@example.com', company: 'Example Inc.');
    int? result = await dbhelper.saveKontak(kontak);
    print(result);
    expect(result, isNotNull);
    await dbhelper.closeDatabaseConnection();
  });

  test('Get All Kontak Test', () async {
    List? result = await dbhelper.getAllKontak();
    print(result?.length);
    expect(result?.length, greaterThanOrEqualTo(0));
  });

  test('Update Kontak Test', () async {
    List? result = await dbhelper.getAllKontak();
    int id = result![0]['id'];
    Kontak kontak = Kontak(
      id: id,
      nama: 'Ana',
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
    expect(deleteResult, greaterThanOrEqualTo(0));
    await dbhelper.closeDatabaseConnection();
  });

}