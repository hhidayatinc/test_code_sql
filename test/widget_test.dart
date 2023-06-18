
import 'package:flutter/material.dart';
import 'package:flutter_contact/database/dbhelper.dart';
import 'package:flutter_contact/main.dart';
import 'package:flutter_contact/model/kontak.dart';
import 'package:flutter_contact/screens/entry_form.dart';
import 'package:flutter_contact/screens/list_kontak.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


DBHelper db = DBHelper();
List<Kontak> listKontak = [];
void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}
void main() {
    Future<void> expectNoErrors(Future<void> Function() testFunction, String message) async {
      try {
        await testFunction();
      } catch (error) {
        fail('$message: $error');
      }
    }

    setUpAll(() async {
      sqfliteTestInit();
      var kontakList = await db.getAllKontak();
      listKontak.clear(); // Move this line outside the loop
      kontakList?.forEach((kontak) {
        listKontak.add(Kontak.fromMap(kontak));
      });
    });

    testWidgets("List Kontak Data Nama", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
      print(listKontak.length);
      print(listKontak[0].nama);
      for (int i = 0; i < listKontak.length; i++) { // Change the condition to i < kontakList.length
        await expectNoErrors(() async {
          expect(find.text('${listKontak[i].nama}'), findsOneWidget);
        }, 'Data nama tidak sesuai dengan data yang tersimpan');
      }
    });


    //correctcode
    testWidgets("List Kontak - Data Nomor ", (WidgetTester tester)async{

      await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
      for (int i = 0; i < listKontak.length; i++) {
        await expectNoErrors(() async {
          expect(find.text("Phone: ${listKontak[i].no}"),
              findsOneWidget);
        }, 'Data no tidak sesuai dengan data yang tersimpan');
      }
    });

    //correctcode
    testWidgets("List Kontak - Data Company ", (WidgetTester tester)async{

      await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
      for (int i = 0; i < listKontak.length; i++) {
        await expectNoErrors(() async {
          expect(find.text("Company: ${listKontak[i].company}"),
              findsOneWidget);
        }, 'Data company tidak sesuai dengan data yang tersimpan');
      }
    });

    //correctcode
    testWidgets("List Kontak - Data Email ", (WidgetTester tester)async{

      await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
      for (int i = 0; i < listKontak.length; i++) {
        await expectNoErrors(() async {
          expect(find.text("Email: ${listKontak[i].email}"),
              findsOneWidget);
        }, 'Data email tidak sesuai dengan data yang tersimpan');
      }
    });

    //correct code
    testWidgets("List Kontak ketika ada data - Muncul List Tile dengan jumlah yang sama", (WidgetTester tester)async{
      await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
      for (int i = 0; i < listKontak.length; i++) {
        //await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
        expect(find.byType(ListTile), findsNWidgets(listKontak.length));
      }
    });

    //correct code
    testWidgets("List Kontak ketika ada data - Icon delete ", (WidgetTester tester)async{
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        await expectNoErrors(() async {
          //await tester.pump(new Duration(milliseconds: 5000));
          await tester.pumpAndSettle();
          expect(find.widgetWithIcon(ListTile, Icons.delete), findsNWidgets(listKontak.length));
        }, 'Tidak ditemukan icon delete');
      }
    });


    //correctcode
    testWidgets("List Kontak ketika ada data - Icon edit", (WidgetTester tester)async{
      await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
      for (int i = 0; i < listKontak.length; i++) {
        expect(find.widgetWithIcon(ListTile, Icons.edit), findsNWidgets(listKontak.length));
        await tester.tap(find.byIcon(Icons.edit));
        await tester.pumpWidget(MaterialApp(home: EntryForm()));
      }
    });
}

Future<void> _getAllKontak() async {
  var kontakList = await db.getAllKontak();
  kontakList?.forEach((kontak) {
    listKontak.clear();
    listKontak.add(Kontak.fromMap(kontak));
  });
}


