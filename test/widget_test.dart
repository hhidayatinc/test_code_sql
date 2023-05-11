
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

  testWidgets("List Kontak ketika ada data - Teks Nama", (WidgetTester tester)async{
    List<Kontak> listKontak = [];
    await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
    for (int i = 0; i < listKontak.length; i++) {
      expect(find.widgetWithText(ListTile, (
          '${listKontak[i].nama}'
      )), findsNWidgets(listKontak.length));
    }
  });
    testWidgets("List Kontak ketika ada data - Teks No", (WidgetTester tester)async{
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        expect(find.widgetWithText(ListTile, (
            '${listKontak[i].no}'
        )), findsNWidgets(listKontak.length));
      }
    });
    testWidgets("List Kontak ketika ada data - Teks Company", (WidgetTester tester)async{
      List<Kontak> list = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      //await tester.pumpAndSettle();
      for (int i = 0; i < list.length; i++) {
        var data = list[i].company;
        expect(find.text(data!), findsNothing);
      }
    });
    testWidgets("List Kontak ketika ada data - Teks Email", (WidgetTester tester)async{
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      //await tester.pumpAndSettle();
      for (int i = 0; i < listKontak.length; i++) {
        var data = listKontak[i].email;
        expect(find.text(data!), findsOneWidget);
      }
    });
    testWidgets("List Kontak ketika ada data - List Tile", (WidgetTester tester)async{
      List<Kontak> listKontak = [
        Kontak(nama: "risa", no: "123", email: "ana@gmail.com", company: "Tinc"),
        Kontak(nama: "ina", no: "123", email: "ana@gmail.com", company: "Tinc")
      ];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        expect(find.byType(ListTile), findsNWidgets(listKontak.length));
      }
    });
    testWidgets("List Kontak ketika ada data - Icon delete ", (WidgetTester tester)async{
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        expect(find.widgetWithIcon(ListTile, Icons.delete), findsNWidgets(i));
        await tester.tap(find.byIcon(Icons.delete));
        expect(find.byType(AlertDialog), findsNWidgets(i));
      }
    });

    testWidgets("List Kontak ketika ada data - Icon delete + Alert Dialog ", (WidgetTester tester)async{
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        expect(find.widgetWithIcon(ListTile, Icons.delete), findsNWidgets(i));
        await tester.tap(find.byIcon(Icons.delete));
        expect(find.byType(AlertDialog), findsNWidgets(i));
        expect(find.widgetWithText(TextButton, 'Ya'), findsNWidgets(i));
        await tester.tap(find.widgetWithText(TextButton, 'Ya'));
        expect(find.byType(ListTile), findsOneWidget);
      }
    });

    testWidgets("List Kontak ketika ada data - Icon edit", (WidgetTester tester)async{
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        expect(find.widgetWithIcon(ListTile, Icons.edit), findsNWidgets(i));
        await tester.tap(find.byIcon(Icons.edit));
        await tester.pumpWidget(MaterialApp(home: EntryForm()));
      }
    });
}


