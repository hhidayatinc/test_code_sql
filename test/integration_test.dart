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
      testWidgets('Display Contacts Test', (WidgetTester tester) async {
        // Populate the database with test data
        final johnDoe = Kontak(
          nama: 'John Doe',
          no: '08123456789',
          email: 'john.doe@mail.com',
          company: 'ABC Company',
        );
        final janeDoe = Kontak(
          nama: 'Jane Doe',
          no: '08234567890',
          email: 'jane.doe@mail.com',
          company: 'XYZ Company',
        );
        await dbHelper.saveKontak(johnDoe);
        await dbHelper.saveKontak(janeDoe);

        // Build the widget tree and trigger a frame
        await tester.pumpWidget(MaterialApp(
          home: ListKontakPage(),
        ));

      // Build the widget tree and trigger a frame
      await tester.pumpWidget(MaterialApp(
        home: ListKontakPage(),
      ));

      // // Verify that the contacts are displayed correctly
      // expect(find.text('John Doe'), findsOneWidget);
      // expect(find.text('08123456789'), findsOneWidget);
      // expect(find.text('jane.doe@mail.com'), findsOneWidget);
      // expect(find.text('XYZ Company'), findsOneWidget);
      //
      // expect(find.text('Jane Doe'), findsOneWidget);
      // expect(find.text('08234567890'), findsOneWidget);
      // expect(find.text('jane.doe@mail.com'), findsOneWidget);
      // expect(find.text('XYZ Company'), findsOneWidget);

      // Get the list of contacts displayed in the widget
      final contacts = tester.widgetList<ListTile>(find.byType(ListTile));

      // Verify that the contacts match the test data in the database
      expect(contacts.length, greaterThanOrEqualTo(2));
      expect(contacts[0].title!.child, greaterThanOrEqualTo(Text('John Doe')));
      expect(contacts[0].subtitle!.child, equals(Text(johnDoe.no)));
      expect(contacts[1].title!.child, equals(Text(janeDoe.nama)));
      expect(contacts[1].subtitle!.child, equals(Text(janeDoe.no)));
    });
  });
}