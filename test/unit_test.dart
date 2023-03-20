import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main(){
  late Database db;


  setUpAll(() async{
    sqfliteFfiInit();
    db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await db.execute("CREATE TABLE tableKontak(id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "nama TEXT,"
        "no TEXT,"
        "email TEXT,"
        "company TEXT)");
  });

  test('Insert and query data', () async {
    // Insert a row into the database
    await db.insert('tableKontak', {'nama': 'Ana', 'no': '085235655323', 'email': 'ana@gmail.com', 'company': 'Polinema'});

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
      {'nama': 'Hidayati'},
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
