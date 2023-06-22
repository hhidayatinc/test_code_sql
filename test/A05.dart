
import 'package:flutter/material.dart';
import 'package:flutter_contact/database/dbhelper.dart';
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
        fail('$error');
      }
    }

    testWidgets("List Kontak Data Nama", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
      for (int i = 0; i < listKontak.length; i++) {
        print(listKontak.length);
        print(listKontak[i].nama);
        expect(find.widgetWithText(ListTile, '${listKontak[i].nama}'), findsOneWidget);
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
        await expectNoErrors(() async{
          expect(find.byType(ListTile), findsNWidgets(listKontak.length));
        }, 'Jumlah list tile tidak sama');
        //await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
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




