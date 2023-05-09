// Import the necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_contact/database/database_helper.dart';
import 'package:flutter_contact/screens/contact_list_screen.dart';
import 'package:flutter_contact/model/contact.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

void main() {
  // Declare a variable to hold the database helper
  DatabaseHelper dbhelper = DatabaseHelper();
  setUpAll(() async{
    sqfliteTestInit();
    var db = await openDatabase(inMemoryDatabasePath);
    await db.execute("CREATE TABLE tableKontak(id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "nama TEXT,"
        "no TEXT,"
        "email TEXT,"
        "company TEXT)");
  });

  group('Contact list screen tests', () {
    testWidgets('Contacts are displayed in ListView', (tester) async {
      // Create some test contacts
      final testContacts = [
        Contact(name: "Gian", value: "123"),
        Contact(name: "Rini", value: "123"),
        Contact(name: "Riris", value: "123"),
        Contact(name: "Sari", value: "123"),
      ];

      // Insert the test contacts into the database
      for (int i=0; i<=testContacts.length; i++) {
        await dbhelper.saveKontak(testContacts[i]);
      }
      print('selesai');
      // Build the ContactListScreen widget
      await tester.pumpWidget(MaterialApp(home: ContactListScreen()));

      // Find the ListView widget
      final listView = find.byType(ListView);

      // Verify that the ListView displays the correct number of contacts
      expect(find.byKey(Key('list_tile')), findsNWidgets(testContacts.length));

      // Verify that the ListView displays the correct contact names
      //for (final kontak in testContacts) {
      expect(find.text('Ana'), findsOneWidget);
      expect(find.text('Anabel'), findsOneWidget);
      //}
    });
  });
}
