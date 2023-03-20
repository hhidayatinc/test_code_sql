import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {

  late Database db;

  setUpAll(() async {
    sqfliteFfiInit();
    // Open the database and create the table
    db = await openDatabase(
      join(await getDatabasesPath(), 'kontak.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tableKontak(id INTEGER PRIMARY KEY AUTOINCREMENT, nama TEXT, no TEXT, email TEXT, company TEXT)',
        );
      },
      version: 1,
    );
  });

  tearDownAll(() async {
    // Close the database
    await db.close();
  });

    test('Insert and query data', () async {
      // Insert a row into the database
      await db.insert('tableKontak', {'nama': 'Ana', 'no': '08523565323', 'email': 'ana@gmail.com', 'company': 'Polinema'});

      // Query the database for the row
      final result = await db.query('tableKontak');

      // Verify that the row was returned
      expect(result, hasLength(1));
      expect(result.first['id'], 1);
      expect(result.first['nama'], 'Ana');
      expect(result.first['no'], '085235655323');
      expect(result.first['email'], 'ana@gmail.com');
      expect(result.first['company'], 'Polinema');
    });

    test('Update data', () async {
      // Update the row in the database
      final rowsAffected = await db.update(
        'tableKontak',
        {'name': 'Hidayati'},
        where: 'id = ?',
        whereArgs: [1],
      );

      // Verify that the row was updated
      expect(rowsAffected, 1);

      // Query the database for the updated row
      final result = await db.query('tableKontak');

      // Verify that the row was updated
      expect(result, hasLength(1));
      expect(result.first['id'], 1);
      expect(result.first['nama'], 'Hidayati');
      expect(result.first['no'], '085235655323');
      expect(result.first['email'], 'ana@gmail.com');
      expect(result.first['company'], 'Polinema');
    });

    test('Delete data', () async {
      // Delete the row from the database
      final rowsAffected = await db.delete(
        'tableKontak',
        where: 'id = ?',
        whereArgs: [1],
      );

      // Verify that the row was deleted
      expect(rowsAffected, 1);

      // Query the database for the deleted row
      final result = await db.query('tableKontak');

      // Verify that no rows were returned
      expect(result, hasLength(0));
    });
}