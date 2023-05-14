
import 'package:flutter/material.dart';
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

    //correct code
  testWidgets("List Kontak ketika ada data - Nama sesuai", (WidgetTester tester)async{
    List<Kontak> listKontak = [];
    await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
    for (int i = 0; i < listKontak.length; i++) {
      await expectNoErrors(() async {
        expect(find.widgetWithText(ListTile, '${listKontak[i].nama}'), findsOneWidget);
      }, 'Data nama tidak sesuai dengan data yang tersimpan');
    }
  });

    testWidgets("List Kontak ketika ada data - No tidak sesuai", (WidgetTester tester)async{
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        await expectNoErrors(() async {
          expect(find.text('${listKontak[i].no}'), findsOneWidget);
        }, 'Data no tidak sesuai dengan data yang tersimpan');
      }
    });
    testWidgets("List Kontak ketika ada data - Company tidak sesuai", (WidgetTester tester)async{
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        await expectNoErrors(() async {
          expect(find.text(
              listKontak[i].company!
          ), findsOneWidget);
        }, 'Data company tidak sesuai dengan data yang tersimpan');
      }
    });

    testWidgets("List Kontak ketika ada data - Teks email", (WidgetTester tester)async{
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      //await tester.pumpAndSettle();
      for (int i = 0; i < listKontak.length; i++) {
        var data = listKontak[i].email;
        expect(find.text(data!), findsOneWidget);
      }
    });
    testWidgets("List Kontak ketika ada data - Email tidak sesuai", (WidgetTester tester)async{
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        await expectNoErrors(() async {
          expect(find.widgetWithText(ListTile, (
              '${listKontak[i].email}'
          )), findsNWidgets(listKontak.length));
        }, 'Data email tidak sesuai dengan data yang tersimpan');
      }
    });

    //correct code
    testWidgets("List Kontak ketika ada data - Muncul List Tile dengan jumlah yang sama", (WidgetTester tester)async{
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        expect(find.byType(ListTile), findsNWidgets(listKontak.length));
      }
    });

    //correct code
    testWidgets("List Kontak ketika ada data - Icon delete ", (WidgetTester tester)async{
      List<Kontak> listKontak = [
        Kontak(nama: "Hidayati", no: "085235655323", email: "chasanah55@gmail.com", company: "Arta"),
        Kontak(nama: "Nur", no: "085235655322", email: "chasanah55@gmail.com", company: "Grow"),
      ];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        expect(find.widgetWithIcon(ListTile, Icons.delete), findsNWidgets(listKontak.length));
      }
    });

    testWidgets("List Kontak ketika ada data - Icon delete + Alert Dialog ", (WidgetTester tester)async{
      List<Kontak> listKontak = [
        Kontak(nama: "Hidayati", no: "085235655323", email: "chasanah55@gmail.com", company: "Arta"),
        Kontak(nama: "Nur", no: "085235655323", email: "chasanah55@gmail.com", company: "Arta")
      ];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        expect(find.widgetWithIcon(ListTile, Icons.delete), findsNWidgets(i));
        await tester.tap(find.byIcon(Icons.delete));
        expect(find.byType(AlertDialog), findsNWidgets(i));
        expect(find.widgetWithText(TextButton, 'Ya'), findsNWidgets(i));
        await tester.tap(find.widgetWithText(TextButton, 'Ya'));
      }
    });

    //correctcode
    testWidgets("List Kontak ketika ada data - Icon edit", (WidgetTester tester)async{
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        expect(find.widgetWithIcon(ListTile, Icons.edit), findsNWidgets(listKontak.length));
        await tester.tap(find.byIcon(Icons.edit));
        await tester.pumpWidget(MaterialApp(home: EntryForm()));
      }
    });
}


