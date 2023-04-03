import 'package:flutter/material.dart';
import 'package:flutter_contact/database/dbhelper.dart';
import 'package:flutter_contact/model/kontak.dart';
import 'package:flutter_contact/screens/list_kontak.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  group('Contact List Integration Test', () {
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

    testWidgets('Display Contacts Test', (WidgetTester tester) async {
      // Populate the database with test data
      await dbHelper.saveKontak(Kontak(
        nama: 'John Doe',
        no: '08123456789',
        email: 'john.doe@mail.com',
        company: 'ABC Company',
      ));
      await dbHelper.saveKontak(Kontak(
        nama: 'Jane Doe',
        no: '08234567890',
        email: 'jane.doe@mail.com',
        company: 'XYZ Company',
      ));

      // Build the widget tree and trigger a frame
      await tester.pumpWidget(MaterialApp(
        home: ListKontakPage(),
      ));

      // Verify that the contacts are displayed correctly
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('08123456789'), findsOneWidget);
      expect(find.text('jane.doe@mail.com'), findsOneWidget);
      expect(find.text('XYZ Company'), findsOneWidget);

      expect(find.text('Jane Doe'), findsOneWidget);
      expect(find.text('08234567890'), findsOneWidget);
      expect(find.text('jane.doe@mail.com'), findsOneWidget);
      expect(find.text('XYZ Company'), findsOneWidget);
    });
  });
}