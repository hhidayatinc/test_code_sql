// import 'package:flutter/material.dart';
// import 'package:flutter_contact/database/database_helper.dart';
// import 'package:flutter_contact/screens/list_kontak.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_contact/database/dbhelper.dart';
// import 'package:flutter_contact/model/kontak.dart';
//
// import 'widget_test.dart';
//
// void main() {
//   group('Database Test', () {
//     late DatabaseHelper db;
//
//     setUp(() async {
//      db = DatabaseHelper();
//       // Initialize the database connection or open the database here
//       await db.initializeDatabase();
//       // You can also create and populate the table with test data
//     });
//
//     tearDown(() async {
//       // Close the database connection or delete the test data here
//       await db.close();
//     });
//
//     testWidgets('Data from database matches ListView', (WidgetTester tester) async {
//       final listKontak = [
//         Kontak(nama: "risa", no: "123", email: "ana@gmail.com", company: "Tinc"),
//         Kontak(nama: "ina", no: "123", email: "ana@gmail.com", company: "Tinc")
//       ];
//
//       // Insert test data into the database
//       for (final user in listKontak) {
//         await db.insertKontak(listKontak[0]);
//       }
//
//       // Build the ListView widget with data from the database
//
//
//       // Retrieve data from the database
//       final retrievedUsers = await db.getAllKontak();
//
//       // Verify that the data from the database matches the ListView
//       for (var i = 0; i < listKontak.length; i++) {
//         final user = listKontak[i];
//         expect(find.text('${user.nama}'), findsOneWidget);
//         expect(find.text('${user.no}'), findsOneWidget);
//
//         final retrievedUser = retrievedUsers[i];
//         expect(retrievedUser, equals(user));
//       }
//     });
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_contact/database/database_helper.dart';
import 'package:flutter_contact/database/dbhelper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'testing_method.dart';

void main() {
  DBHelper db = DBHelper();
  setUp(() async {
    await db.initDb();
  });

  tearDown(() async {
    await DatabaseHelper.closeDatabaseConnection();
  });

  test('Database Connection Test', () async {
    final database = await DatabaseHelper.getDatabase();
    expect(database.isOpen, isTrue);
  });
}