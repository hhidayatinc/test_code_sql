import 'package:flutter/material.dart';
import 'package:flutter_contact/model/kontak.dart';
import 'package:flutter_contact/screens/entry_form.dart';
import 'package:flutter_contact/screens/list_kontak.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'widget_test.mocks.dart';


void main() {
  Future<void> expectNoErrors(Future<void> Function() testFunction, String message) async {
    try {
      await testFunction();
    } catch (error) {
      fail('$message: $error');
    }
  }
    testWidgets("List kontak ketika belum ada data", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ListKontakPage()));

        await expectNoErrors(() async{
          expect(find.text('Daftar Kontak'), findsOneWidget);
        }, 'Text Daftar Kontak tidak ditemukan');

        await expectNoErrors(() async{
          expect(find.byKey(ValueKey('list_kontak')), findsOneWidget);
        }, 'list_kontak tidak ditemukan');

        await expectNoErrors(() async {
          expect(find.widgetWithIcon(FloatingActionButton, Icons.add), findsOneWidget);
          await tester.tap(find.byIcon(Icons.add));
          await tester.pump();
        }, 'Icon add tidak ditemukan');


    });

    // testWidgets('Entry Form', (WidgetTester tester) async{
    //   final btnSave = find.byKey(ValueKey("tapButtonSave"));
    //   final addNama = find.byKey(ValueKey("addNama"));
    //   final addNo = find.byKey(ValueKey("addPhoneNumber"));
    //   final addEmail = find.byKey(ValueKey("addEmail"));
    //   final addCompany = find.byKey(ValueKey("addCompany"));
    //
    //   expectNoErrors(() async {
    //     await tester.pumpWidget(MaterialApp(home: EntryForm()));
    //     expect(find.text("Form Kontak"), findsOneWidget);
    //     final listViewFinder = find.byKey(ValueKey('ListViewForm'));
    //     expect(listViewFinder, findsOneWidget);
    //
    //     expect(addNama, findsOneWidget);
    //     await tester.enterText(addNama, "ana");
    //
    //     expect(addNo, findsOneWidget);
    //     await tester.enterText(addNo, "087");
    //
    //     expect(addEmail, findsOneWidget);
    //     await tester.enterText(addEmail, "ana@gmail.com");
    //
    //     expect(addCompany, findsOneWidget);
    //     await tester.enterText(addCompany, "polinema");
    //
    //     expect(btnSave, findsOneWidget);
    //     await tester.tap(btnSave);
    //     await tester.pump();
    //   });
    // });

    testWidgets("List kontak ketika ada data", (WidgetTester tester)async{
      await tester.pumpWidget(MaterialApp(home: ListKontakPage()));
      expect(find.byKey(ValueKey('appbar_text')), findsOneWidget);
      expect(find.byKey(ValueKey('list_kontak')), findsOneWidget);

      final List<List<String>> daftarKontak = [
        ['ana','087','ana@gmail.com','polinema'],['ifa','089','ifa@gmail.com','ub']
      ];

      // await tester.pumpWidget(
      //   MaterialApp(
      //     home: Scaffold(
      //       body: ListView.builder(
      //         itemCount: daftarKontak.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           return ListTile(
      //             key: Key('list_tile'),
      //             title: Text(daftarKontak[index][0]),
      //             subtitle: Column(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.only(
      //                     top: 8,
      //                   ),
      //                   child: Text("Email: ${daftarKontak[index][2]}"),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.only(
      //                     top: 8,
      //                   ),
      //                   child: Text("Phone: ${daftarKontak[index][1]}"),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.only(
      //                     top: 8,
      //                   ),
      //                   child: Text("Company: ${daftarKontak[index][3]}"),
      //                 )
      //               ],
      //             ),
      //           );
      //         },
      //       ),
      //     ),
      //   ),
      // );
      expect(find.byKey(ValueKey('list_tile_1')), findsOneWidget);
      //expect(find.text('ana'), findsOneWidget);

    });

}

