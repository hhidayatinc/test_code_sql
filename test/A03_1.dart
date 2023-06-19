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

  testWidgets('Komponen UI-AppBar', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm()));
    await expectNoErrors(() async {
      expect(find.byType(AppBar), findsOneWidget);
    },'App Bar tidak ditemukan');
  });

  testWidgets('Komponen UI-Title AppBar', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm()));
    await expectNoErrors(() async {
      expect(find.widgetWithText(AppBar, 'Form Kontak'), findsOneWidget);
    },'Title tidak ditemukan');
  });

  testWidgets('Komponen UI-Form', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm()));
    await expectNoErrors(() async {
      expect(find.byType(Form), findsOneWidget);
    },'Form tidak ditemukan');
  });

  testWidgets('Komponen UI-ListView Form', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm()));
    await expectNoErrors(() async {
      expect(find.byType(ListView), findsOneWidget);
    },'ListView tidak ditemukan');
  });

  testWidgets('Komponen UI-TextFormField', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm()));
    await expectNoErrors(() async {
      expect(find.byType(TextFormField), findsNWidgets(4));
    },'4 TextFormField tidak ditemukan');
  });

  testWidgets('Komponen UI-ElevatedButton', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm()));
    await expectNoErrors(() async {
      expect(find.byType(ElevatedButton), findsOneWidget);
    },'Button tidak ditemukan');
  });

  testWidgets('Komponen UI-ElevatedButton-Add', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: EntryForm()));
    await expectNoErrors(() async {
      expect(find.widgetWithText(ElevatedButton, 'Add'), findsOneWidget);
    },'Button Add tidak ditemukan');
  });

}