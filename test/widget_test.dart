
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
    // testWidgets("List kontak ketika belum ada data", (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
    //   await expectNoErrors(() async{
    //     expect(find.byKey(Key('app_bar')), findsOneWidget);
    //   }, 'AppBar tidak ditemukan');
    //   await expectNoErrors(() async{
    //     expect(find.text('Daftar Kontak'), findsOneWidget);
    //   }, 'Text Daftar Kontak tidak ditemukan');
    //   await expectNoErrors(() async{
    //     expect(find.byKey(ValueKey('list_kontak')), findsOneWidget);
    //   }, 'list_kontak tidak ditemukan');
    //   await expectNoErrors(() async{
    //     expect(find.byWidget(ListTile()), findsNothing);
    //   }, 'ListTile ditemukan');
    //   await expectNoErrors(() async {
    //     expect(find.widgetWithIcon(FloatingActionButton, Icons.add), findsOneWidget);
    //     await tester.tap(find.byIcon(Icons.add));
    //     await tester.pump();
    //   }, 'Icon add tidak ditemukan');
    // });
    // testWidgets('Komponen Halaman Form', (WidgetTester tester) async{
    //   final btnSave = find.byKey(ValueKey("tapButtonSave"));
    //   final addNama = find.byKey(ValueKey("addNama"));
    //   final addNo = find.byKey(ValueKey("addPhoneNumber"));
    //   final addEmail = find.byKey(ValueKey("addEmail"));
    //   final addCompany = find.byKey(ValueKey("addCompany"));
    //   await expectNoErrors(() async {
    //     await tester.pumpWidget(MaterialApp(home: EntryForm()));
    //     expect(find.text("Form Kontak"), findsOneWidget);
    //   },'Teks Form Kontak tidak ditemukan');
    //   await expectNoErrors(() async{
    //     final listViewFinder = find.byKey(ValueKey('listviewform'));
    //     expect(listViewFinder, findsOneWidget);
    //   },'ListViewForm tidak ditemukan');
    //   await expectNoErrors(() async {
    //     expect(addNama, findsOneWidget);
    //     await tester.enterText(addNama, "ana");
    //   }, 'Widget form addNama tidak ditemukan');
    //   await expectNoErrors(() async {
    //     expect(addNo, findsOneWidget);
    //     await tester.enterText(addNo, "087");
    //   }, 'Widget form addNo tidak ditemukan');
    //   await expectNoErrors(() async {
    //     expect(addEmail, findsOneWidget);
    //     await tester.enterText(addEmail, "ana@gmail.com");
    //   }, 'Widget form addEmail tidak ditemukan');
    //   await expectNoErrors(() async {
    //     expect(addCompany, findsOneWidget);
    //     await tester.enterText(addCompany, "polinema");
    //   }, 'Widget form addCompany tidak ditemukan');
    //   await expectNoErrors(() async {
    //     expect(btnSave, findsOneWidget);
    //     await tester.tap(btnSave);
    //     await tester.pump();
    //   }, 'Button save tidak ditemukan');
    // });

  testWidgets("List kontak ketika ada data", (WidgetTester tester)async{

    // DBHelper db = DBHelper();
    await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
    // Initialize database
    List<Kontak> listKontak = [
      Kontak(nama: "risa", no: "123", email: "ana@gmail.com", company: "Tinc"),
      Kontak(nama: "ina", no: "123", email: "ana@gmail.com", company: "Tinc"),
      //Kontak(nama: "hada", no: "123", email: "ana@gmail.com", company: "Tinc")
    ];

    // db.saveKontak(listKontak[0]);
    // List? result = await db.getAllKontak();

    // var list = await db.getAllKontak();
    //
    // list!.forEach((kontak) {
    //
    //   //masukan data ke listKontak
    //   listKontak.add(Kontak.fromMap(kontak));
    // });
    // Define test data
    // var contacts =
    //   Kontak(nama: "Anabel", no: "123", email: "ana@gmail.com", company: "Tinc");
    //
    // // Pump widget and check initial state
    // await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
    // expect(find.byKey(ValueKey('appbar_text')), findsOneWidget);
    // expect(find.byKey(ValueKey('list_kontak')), findsOneWidget);
    //
    // Save test data to database
    // print('Save Kontak');//print('save kontak done');
    //  var contacts2 =
    //  Kontak(nama: "Ani", no: "123", email: "ana@gmail.com", company: "Tinc");
    //  await db.saveKontak(contacts2);
    // print('save kontak done');
    // List? result = await db.getAllKontak();
    // for(int i=0; i<result!.length; i++){
    //   print(result[i].toString());
    // }
    // // print(result);
    //
    // // Re-pump widget and wait for it to settle
    await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
    //await tester.pumpAndSettle();
    //for (int i = 0; i < result!.length; i++) {
    //   var data = listKontak[i].nama;
    //   //print or add data to any other list and insert to another list and save to database
    //   expect(find.text(data!), findsOneWidget);
    expect(find.text(listKontak[0].nama.toString()), findsOneWidget);
    //expect(find.text('ana'), findsOneWidget);
    //   // expect(find.text('hada'), findsOneWidget);
    //}
    //
    // // Check if test data is displayed correctly
    //
    //   expect(find.text("Ana"), findsOneWidget);

  });


}

