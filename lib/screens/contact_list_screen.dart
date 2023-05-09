import 'package:flutter/material.dart';
import 'package:flutter_contact/model/contact.dart';
import 'package:flutter_contact/database/database_helper.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  late DatabaseHelper _databaseHelper;
  late List<Contact> _contactList;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.internal();
    _refreshContactList();
  }

  void _refreshContactList() async {
    final List<Contact> contacts = (await _databaseHelper.getData()).cast<Contact>();
    setState(() {
      _contactList = contacts;
      _count = contacts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: _count == 0
          ? Center(
        child: Text('No contacts found.'),
      )
          : ListView.builder(
        itemCount: _count,
        itemBuilder: (BuildContext context, int index) {
          final Contact contact = _contactList[index];
          return ListTile(
            title: Text('${contact.name}'),
            subtitle: Text('${contact.email}'),
            leading: CircleAvatar(
              child: const Icon(
                Icons.person,
                size: 50,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool? result = await Navigator.pushNamed(
            context,
            '/addContact',
          );
          if (result != null && result) {
            _refreshContactList();
          }
        },
        tooltip: 'Add Contact',
        child: Icon(Icons.add),
      ),
    );
  }
}
