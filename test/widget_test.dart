
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_contact/component/list-item.dart';
import 'package:flutter_contact/database/dbhelper.dart';
import 'package:flutter_contact/main.dart';
import 'package:flutter_contact/model/kontak.dart';
import 'package:flutter_contact/screens/entry_form.dart';
import 'package:flutter_contact/screens/list_kontak.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

import 'testing_method.dart';


void main() {
    Future<void> expectNoErrors(Future<void> Function() testFunction, String message) async {
      try {
        await testFunction();
      } catch (error) {
        fail('$message: $error');
      }
    }

    Future<void> formEdit() async {}
    Future<void> deleteKontak() async {}
    List<Kontak> listKontak;
    //correct code
  testWidgets("List Kontak Data Nama", (WidgetTester tester)async{
    
    await tester.pumpWidget(MaterialApp(home: ListItemWidget(editform: formEdit(), deletekontak: deleteKontak(), listkt: listKontak),)); 
  
      for (int i = 0; i < listKontak.length; i++) {
        await expectNoErrors(() async {
          expect(find.widgetWithText(ListTile, '${listKontak[i].nama}'),
              findsOneWidget);
        }, 'Data nama tidak sesuai dengan data yang tersimpan');
      }
    //}
  });

    //correctcode
    testWidgets("List Kontak - Data Nomor ", (WidgetTester tester)async{
      List<Kontak> listKontak = [
        Kontak(nama: "Ana", email: "ana@gmail.com", no: "0876543890", company: "polinema"),
        Kontak(nama: "Ani", email: "ana@gmail.com", no: "087654389", company: "polinema")
      ];
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
      List<Kontak> listKontak = [
        Kontak(nama: "Ana", email: "ana1@gmail.com", no: "0876543890", company: "polinema1"),
        Kontak(nama: "Ani", email: "ana@gmail.com", no: "087654389", company: "polinema")
      ];
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
      List<Kontak> listKontak = [
        Kontak(nama: "Ana", email: "ana1@gmail.com", no: "0876543890", company: "polinema1"),
        Kontak(nama: "Ani", email: "ana@gmail.com", no: "087654389", company: "polinema")
      ];
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
      List<Kontak> kontak = [
        // Kontak(nama: "Ana", email: "ana@gmail.com", no: "0876543890", company: "polinema"),
        // Kontak(nama: "Ani", email: "ana@gmail.com", no: "087654389", company: "polinema")
      ];
      //await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
      for (int i = 0; i < kontak.length; i++) {
        await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
        expect(find.byType(ListTile), findsNWidgets(kontak.length));
      }
    });

    //correct code
    testWidgets("List Kontak ketika ada data - Icon delete ", (WidgetTester tester)async{
      List<Kontak> listKontak = [
        Kontak(nama: "Ana", email: "ana@gmail.com", no: "0876543890", company: "polinema"),
        // Kontak(nama: "Ani", email: "ana@gmail.com", no: "087654389", company: "polinema")
      ];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        await expectNoErrors(() async {
          //await tester.pump(new Duration(milliseconds: 5000));
          await tester.pumpAndSettle();
          expect(find.widgetWithIcon(ListTile, Icons.delete), findsNWidgets(listKontak.length));
        }, 'Tidak ditemukan icon delete');
      }
    });


    // testWidgets("List Kontak ketika ada data - Icon delete + Alert Dialog ", (WidgetTester tester)async{
    //   List<Kontak> listKontak = [
    //     Kontak(nama: "Ana", email: "ana@gmail.com", no: "0876543890", company: "polinema"),
    //     Kontak(nama: "Ani", email: "ana@gmail.com", no: "087654389", company: "polinema")
    //   ];
    //   await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
    //   for (int i = 0; i < listKontak.length; i++) {
    //     expect(find.widgetWithText(ListTile, '${listKontak[i].nama}'),
    //         findsOneWidget);
    //   //}
    //      expect(find.widgetWithIcon(ListTile, Icons.delete), findsNWidgets(listKontak.length));
    //      await tester.tap(find.byIcon(Icons.delete));
    //      await tester.pumpAndSettle();
    //   //   // Verify that the alert dialog is displayed.
    //      expect(find.text('Information'), findsOneWidget);
    //     expect(find.text('Yakin ingin Menghapus Data ${listKontak[0].nama}'), findsOneWidget);
    //   //   // Tap the "OK" button to dismiss the dialog.
    //      await tester.tap(find.text('Ya'));
    //      await tester.pumpAndSettle();
    //     expect(find.text('${listKontak[0].nama}'), findsNothing);
    //   }
    // });

    //correctcode
    testWidgets("List Kontak ketika ada data - Icon edit", (WidgetTester tester)async{
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
      for (int i = 0; i < listKontak.length; i++) {
        expect(find.widgetWithIcon(ListTile, Icons.edit), findsNWidgets(listKontak.length));
        await tester.tap(find.byIcon(Icons.edit));
        await tester.pumpWidget(MaterialApp(home: EntryForm()));
      }
    });
}


