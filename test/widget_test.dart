
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
    //await tester.pumpAndSettle();
    for (int i = 0; i < listKontak.length; i++) {
       var data = listKontak[i].nama;
    expect(find.text(data!), findsOneWidget);
    }
  });
    testWidgets("List Kontak ketika ada data - Teks No", (WidgetTester tester)async{
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      //await tester.pumpAndSettle();
      for (int i = 0; i < listKontak.length; i++) {
        var data = listKontak[i].no;
        expect(find.text(data!), findsOneWidget);
      }
    });
    testWidgets("List Kontak ketika ada data - Teks Company", (WidgetTester tester)async{
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      //await tester.pumpAndSettle();
      for (int i = 0; i < listKontak.length; i++) {
        var data = listKontak[i].company;
        expect(find.text(data!), findsOneWidget);
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
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        expect(find.byType(ListTile), findsNWidgets(i));
      }
    });
    testWidgets("List Kontak ketika ada data - Icon delete ", (WidgetTester tester)async{
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        expect(find.widgetWithIcon(ListTile, Icons.delete), findsNWidgets(i));
      }
    });
    testWidgets("List Kontak ketika ada data - Icon ", (WidgetTester tester)async{
      List<Kontak> listKontak = [];
      await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
      for (int i = 0; i < listKontak.length; i++) {
        expect(find.widgetWithIcon(ListTile, Icons.edit), findsNWidgets(i));
      }
    });
}


