import 'package:flutter/material.dart';
import 'package:flutter_contact/database/dbhelper.dart';
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
      } catch ($message) {
        fail('$message');
      }
    }
    testWidgets("List kontak ketika belum ada data", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
      await expectNoErrors(() async{
        expect(find.text('Daftar Kontak'), findsOneWidget);
      }, 'Text Daftar Kontak tidak ditemukan');
      await expectNoErrors(() async{
        expect(find.byKey(ValueKey('list_kontak')), findsNothing);
      }, 'list_kontak tidak ditemukan');
      await expectNoErrors(() async {
        expect(find.widgetWithIcon(FloatingActionButton, Icons.add), findsOneWidget);
        await tester.tap(find.byIcon(Icons.add));
        await tester.pump();
      }, 'Icon add tidak ditemukan');
    });
    testWidgets('Entry Form', (WidgetTester tester) async{
      final btnSave = find.byKey(ValueKey("tapButtonSave"));
      final addNama = find.byKey(ValueKey("addNama"));
      final addNo = find.byKey(ValueKey("addPhoneNumber"));
      final addEmail = find.byKey(ValueKey("addEmail"));
      final addCompany = find.byKey(ValueKey("addCompany"));
      await expectNoErrors(() async {
        await tester.pumpWidget(MaterialApp(home: EntryForm()));
        expect(find.text("Form Kontak"), findsOneWidget);
      },'Teks Form Kontak tidak ditemukan');
      await expectNoErrors(() async{
        final listViewFinder = find.byKey(ValueKey('ListViewForm'));
        expect(listViewFinder, findsOneWidget);
      },'ListViewForm tidak ditemukan');
      await expectNoErrors(() async {
        expect(addNama, findsOneWidget);
        await tester.enterText(addNama, "ana");
      }, 'Widget form addNama tidak ditemukan');
      await expectNoErrors(() async {
        expect(addNo, findsOneWidget);
        await tester.enterText(addNo, "087");
      }, 'Widget form addNo tidak ditemukan');
      await expectNoErrors(() async {
        expect(addEmail, findsOneWidget);
        await tester.enterText(addEmail, "ana@gmail.com");
      }, 'Widget form addEmail tidak ditemukan');
      await expectNoErrors(() async {
        expect(addCompany, findsOneWidget);
        await tester.enterText(addCompany, "polinema");
      }, 'Widget form addCompany tidak ditemukan');
      await expectNoErrors(() async {
        expect(btnSave, findsOneWidget);
        await tester.tap(btnSave);
        await tester.pump();
      }, 'Button save tidak ditemukan');
    });

  testWidgets("List kontak ketika ada data", (WidgetTester tester)async{
    // Initialize database
    DBHelper db = DBHelper();

    // Define test data
    final contacts =
      Kontak(nama: "Ana", no: "123", email: "ana@gmail.com", company: "Tinc");

    // Pump widget and check initial state
    await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
    expect(find.byKey(ValueKey('appbar_text')), findsOneWidget);
    expect(find.byKey(ValueKey('list_kontak')), findsOneWidget);

    // Save test data to database
    print('Save Kontak');
    await db.saveKontak(contacts);
    print('save kontak done');
    await db.getAllKontak();
    print('get all kontak done');

    // Re-pump widget and wait for it to settle
    await tester.pumpWidget(MaterialApp(home: ListKontakPage())); //hilangin param
    await tester.pumpAndSettle();

    // Check if test data is displayed correctly
    expectNoErrors(() async{
      expect(find.text("Ana"), findsOneWidget);
    }, "Data not displayed correctly");
  });


}

