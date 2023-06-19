import 'package:flutter_contact/model/kontak.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_contact/screens/entry_form.dart';
import 'package:flutter/material.dart';

void main(){
  Future<void> expectNoErrors(Future<void> Function() testFunction, String message) async {
    try {
      await testFunction();
    } catch ($message) {
      fail(message);
    }
  }

  Kontak k = Kontak(nama: "Ana", email: "ana1@gmail.com", no: "0876543890", company: "polinema1");

  testWidgets('Komponen UI-AppBar', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm(kontak: k)));
    await expectNoErrors(() async {
      expect(find.byType(AppBar), findsOneWidget);
    },'App Bar tidak ditemukan');
  });

  testWidgets('Komponen UI-Title AppBar', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm(kontak: k,)));
    await expectNoErrors(() async {
      expect(find.widgetWithText(AppBar, 'Form Kontak'), findsOneWidget);
    },'Title tidak ditemukan');
  });

  testWidgets('Komponen UI-Form', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm(kontak: k,)));
    await expectNoErrors(() async {
      expect(find.byType(Form), findsOneWidget);
    },'Form tidak ditemukan');
  });

  testWidgets('Komponen UI-ListView Form', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm(kontak: k,)));
    await expectNoErrors(() async {
      expect(find.byType(ListView), findsOneWidget);
    },'ListView tidak ditemukan');
  });

  testWidgets('Komponen UI-TextFormField', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm(kontak: k,)));
    await expectNoErrors(() async {
      expect(find.byType(TextFormField), findsNWidgets(4));
    },'4 TextFormField tidak ditemukan');
  });

  testWidgets('Text Form FIeld Nama ada data', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm(kontak: k,)));
    await expectNoErrors(() async {
      expect(find.widgetWithText(TextFormField, 'Ana'), findsOneWidget);
    },'TextFormField data nama tidak ditemukan');
  });

  testWidgets('Text Form FIeld Nomor ada data', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm(kontak: k,)));
    await expectNoErrors(() async {
      expect(find.widgetWithText(TextFormField, '0876543890'), findsOneWidget);
    },'TextFormField data nomor tidak ditemukan');
  });

  testWidgets('Text Form FIeld email ada data', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm(kontak: k,)));
    await expectNoErrors(() async {
      expect(find.widgetWithText(TextFormField, 'ana1@gmail.com'), findsOneWidget);
    },'TextFormField data email tidak ditemukan');
  });

  testWidgets('Text Form Field company ada data', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm(kontak: k,)));
    await expectNoErrors(() async {
      expect(find.widgetWithText(TextFormField, 'polinema1'), findsOneWidget);
    },'TextFormField data company tidak ditemukan');
  });

  testWidgets('Komponen UI-ElevatedButton', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm(kontak: k,)));
    await expectNoErrors(() async {
      expect(find.byType(ElevatedButton), findsOneWidget);
    },'Button tidak ditemukan');
  });

  testWidgets('Komponen UI-ElevatedButton-Update', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm(kontak: k,)));
    await expectNoErrors(() async {
      expect(find.widgetWithText(ElevatedButton, 'Update'), findsOneWidget);
    },'Button Update tidak ditemukan');
  });
}