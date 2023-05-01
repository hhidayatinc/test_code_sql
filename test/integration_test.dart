// import 'package:flutter/material.dart';
// import 'package:flutter_contact/database/dbhelper.dart';
// import 'package:flutter_contact/model/kontak.dart';
// import 'package:flutter_contact/screens/list_kontak.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
//
// /// Initialize sqflite for test.
// void sqfliteTestInit() {
//   // Initialize ffi implementation
//   sqfliteFfiInit();
//   // Set global factory
//   databaseFactory = databaseFactoryFfi;
// }
//
// Future main() async{
//   group('Integration test', () {
//     late DBHelper dbHelper;
//     late Database db;
//
//     setUpAll(() async {
//       // Initialize the database and the helper
//       sqfliteTestInit();
//       db = await openDatabase(inMemoryDatabasePath);
//       dbHelper = DBHelper();
//
//       // Add some sample data to the database
//       await dbHelper.saveKontak(Kontak(nama: 'Alice', no: '123', company: 'd', email: 'd'));
//       await dbHelper.saveKontak(Kontak(nama: 'Bob', no: '456', email: '2', company: 's'));
//       await dbHelper.saveKontak(Kontak(nama: 'Charlie', no: '789', email: 'd', company: 's'));
//     });
//
//     testWidgets('Test matching data between database and ListView.builder', (WidgetTester tester) async {
//       // Build the widget
//       await tester.pumpWidget(MaterialApp(home: ListKontakPage(db: dbHelper)));
//
//       // Wait for the data to load
//       await tester.pumpAndSettle();
//
//       // Get the displayed items in the ListView.builder
//       final listTiles = find.byType(ListTile);
//       expect(listTiles, findsNWidgets(3));
//       final items = listTiles.evaluate().map((element) => element.widget as ListTile).toList();
//
//       // Check if the displayed items match the data in the database
//       final kontaks = await dbHelper.getAllKontak();
//       expect(items.length, kontaks?.length);
//       for (var i = 0; i < items.length; i++) {
//         expect(items[i].title, Text(kontaks![i]?.nama));
//         expect(items[i].subtitle, Text(kontaks![i]?.no));
//       }
//     });
//   });
// }
