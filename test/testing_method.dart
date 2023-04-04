import 'package:flutter_contact/model/kontak.dart';
import 'package:flutter_contact/database/dbhelper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();

  group('DBHelper tests', () {
    late DBHelper dbHelper;
    late Database db;

    setUp(() async {
      dbHelper = DBHelper();
      db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    });

    tearDown(() async {
      await db.close();
    });

    test('saveKontak should insert a new kontak into the database', () async {
      // Arrange
      final kontak = Kontak(nama: 'John Doe', no: '08123456789', email: 'johndoe@example.com', company: 'Example Inc.');

      // Act
      final result = await dbHelper.saveKontak(kontak);

      // Assert
      expect(result, equals(1));
    });

    test('getAllKontak should return a list of all kontaks in the database', () async {
      // Arrange
      final kontak1 = Kontak(nama: 'John Doe', no: '08123456789', email: 'johndoe@example.com', company: 'Example Inc.');
      final kontak2 = Kontak(nama: 'Jane Doe', no: '08987654321', email: 'janedoe@example.com', company: 'Example Co.');

      await dbHelper.saveKontak(kontak1);
      await dbHelper.saveKontak(kontak2);

      // Act
      final result = await dbHelper.getAllKontak();

      // Assert
      expect(result?.length, equals(2));
    });

    test('updateKontak should update an existing kontak in the database', () async {
      // Arrange
      final kontak1 = Kontak(nama: 'John Doe', no: '08123456789', email: 'johndoe@example.com', company: 'Example Inc.');

      await dbHelper.saveKontak(kontak1);

      final updatedKontak = Kontak(id: 1, nama: 'John Doe', no: '08123456789', email: 'johndoe@example.com', company: 'Example Co.');

      // Act
      final result = await dbHelper.updateKontak(updatedKontak);

      // Assert
      expect(result, equals(1));
    });

    test('deleteKontak should delete an existing kontak from the database', () async {
      // Arrange
      final kontak1 = Kontak(nama: 'John Doe', no: '08123456789', email: 'johndoe@example.com', company: 'Example Inc.');

      await dbHelper.saveKontak(kontak1);

      // Act
      final result = await dbHelper.deleteKontak(1);

      // Assert
      expect(result, equals(1));
    });
  });
}
