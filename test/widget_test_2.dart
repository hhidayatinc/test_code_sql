import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_contact/database/dbhelper.dart';
import 'package:flutter_contact/model/kontak.dart';
import 'package:flutter_contact/screens/list_kontak.dart';
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

Future<void> expectNoErrors(Future<void> Function() testFunction, String message) async {
  try {
    await testFunction();
  } catch (error) {
    fail('$message: $error');
  }
}

Future main() async {
  DBHelper dbhelper = DBHelper();

  // List<Kontak> kontak = [
  //   Kontak(nama: "Ana", no: "123", email: "ana@gmail.com", company: "Tinc"),
  //   Kontak(nama: "Riri", no: "123", email: "ana@gmail.com", company: "Tinc"),
  //   Kontak(nama: "Rika", no: "123", email: "ana@gmail.com", company: "Tinc")
  // ];

  setUpAll(() async{
    sqfliteTestInit();
    var db = await openDatabase(inMemoryDatabasePath);
    await db.execute("CREATE TABLE tableKontak(id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "nama TEXT,"
        "no TEXT,"
        "email TEXT,"
        "company TEXT)");
  });

  testWidgets("Retrieve data to listview", (WidgetTester tester) async {
    // print("save kontak");
    //Kontak kontak = Kontak(nama: 'John Doe', no: '08123456789', email: 'johndoe@example.com', company: 'Example Inc.');
   await dbhelper.saveKontak(Kontak(nama: 'John Doe', no: '08123456789', email: 'johndoe@example.com', company: 'Example Inc.'));
    // int i =0;
    // List<int?> listKontak =[];
    // for(i=0;i<kontak.length;i++){
    //   var isi = await dbhelper.saveKontak(kontak[i]);
    //   listKontak.add(isi);
    //   print(isi);
    // }
    // print(listKontak);
    // print(isi);
    // print("save kontak done");

    await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
    // await tester.pump(Duration(seconds: 2));
    // print("page loaded");

    // Get the displayed items in the ListView.builder
    // await expectNoErrors(() async {
    //   final listTiles = find.byType(ListTile);
    //   // expect(listTiles, findsNWidgets(3));
    //   expect(listTiles, findsNWidgets(1));
    //
    //   expect(find.text('Ana'), findsOneWidget);
    //   // expect(find.text('Riri'), findsOneWidget);
    //   // expect(find.text('Rika'), findsOneWidget);
    // }, 'tidak ditemukan');
    // final listTiles = find.byKey(Key('list_tile'));
    // final listKontak = listTiles.evaluate().first.widget as ListTile;
    // // expect(listTiles, findsNWidgets(3));
    // expect(listTiles, findsNWidgets(1));

    expect(find.text('John Doe'), findsOneWidget);
  //
  });
}