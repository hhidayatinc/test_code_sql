import 'package:flutter/material.dart';
import 'package:flutter_contact/screens/list_kontak.dart';
import 'package:flutter_test/flutter_test.dart';


//testcode when listkontak tidak punya data
void main(){
  Future<void> expectNoErrors(Future<void> Function() testFunction, String message) async {
    try {
      await testFunction();
    } catch (error) {
      fail('$message');
    }
  }
    testWidgets('Komponen UI-AppBar ditemukan', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
      await expectNoErrors(() async{
        expect(find.byType(AppBar), findsOneWidget);
      }, 'AppBar tidak ditemukan');
    });

  testWidgets('Komponen UI-AppBar dengan title ditemukan', (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
    await expectNoErrors(() async{
      expect(find.widgetWithText(Center, 'Daftar Kontak'), findsOneWidget);
    }, 'AppBar dengan title "Daftar Kontak" tidak ditemukan');
  });

    testWidgets('Komponen UI-ListView ditemukan', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
      await expectNoErrors(() async{
        expect(find.byType(ListView), findsOneWidget);
      }, 'ListView tidak ditemukan');
    });

    testWidgets('Komponen UI-ListTile tidak ditemukan', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
      await expectNoErrors(() async{
        expect(find.byType(ListTile), findsNothing);
      }, 'ListTile ditemukan');
    });

    testWidgets('Komponen UI- Floating button ditemukan', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
      await expectNoErrors(() async {
        expect(find.widgetWithIcon(FloatingActionButton, Icons.add), findsOneWidget);
        await tester.tap(find.byIcon(Icons.add));
        await tester.pump();
      }, 'Icon add tidak ditemukan');
    });
}