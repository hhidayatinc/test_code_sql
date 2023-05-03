import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_contact/screens/entry_form.dart';
import 'package:flutter/material.dart';

void main(){
  Future<void> expectNoErrors(Future<void> Function() testFunction, String message) async {
    try {
      await testFunction();
    } catch ($message) {
      fail('$message');
    }
  }

  testWidgets('Komponen UI-AppBar', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm()));
    await expectNoErrors(() async {
      expect(find.byKey(Key('appbar')), findsOneWidget);
    },'App Bar tidak ditemukan');
  });
  testWidgets('Komponen UI-ListView Form', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm()));
    await expectNoErrors(() async {
      expect(find.byKey(Key('listviewform')), findsOneWidget);
    },'ListView tidak ditemukan');
  });

  testWidgets('Komponen UI-TextFormField-Nama', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm()));
    await expectNoErrors(() async {
      expect(find.byKey(Key('addNama')), findsOneWidget);
    },'TextFormField Nama tidak ditemukan');
  });

  testWidgets('Komponen UI-TextFormField-No', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm()));
    await expectNoErrors(() async {
      expect(find.byKey(Key('addPhoneNumber')), findsOneWidget);
    },'TextFormField Number tidak ditemukan');
  });

  testWidgets('Komponen UI-TextFormField-Email', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm()));
    await expectNoErrors(() async {
      expect(find.byKey(Key('addEmail')), findsOneWidget);
    },'TextFormField Email tidak ditemukan');
  });

  testWidgets('Komponen UI-TextFormField-Company', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm()));
    await expectNoErrors(() async {
      expect(find.byKey(Key('addCompany')), findsOneWidget);
    },'TextFormField Company tidak ditemukan');
  });

  testWidgets('Komponen UI-ElevatedButton-Save', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm()));
    await expectNoErrors(() async {
      expect(find.byKey(Key('tapButtonSave')), findsOneWidget);
    },'Button tidak ditemukan');
  });
}