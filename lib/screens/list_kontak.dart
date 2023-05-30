import 'package:flutter/material.dart';
import 'package:flutter_contact/component/list-item.dart';
import 'package:sqflite/sqflite.dart';

import '../database/dbhelper.dart';
import '../model/kontak.dart';
import 'entry_form.dart';

class ListKontakPage extends StatefulWidget {
  @override
  ListKontakPageState createState() => ListKontakPageState();
}

class ListKontakPageState extends State<ListKontakPage> {
  List<Kontak> listKontak = [];
  late Kontak contact;
  late int i;
  DBHelper db = DBHelper();
  @override
  void initState() {
    //menjalankan fungsi getallkontak saat pertama kali dimuat
    _getAllKontak();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Daftar Kontak"),
        ),
      ),
      body: ListItemWidget(
          editform: _openFormEdit(contact),
          deletekontak: _deleteKontak(contact, i),
          listkt: listKontak),
      //membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        key: Key('add icon'),
        child: Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        }
      ),
    );
  }

  //mengambil semua data Kontak
  Future<void> _getAllKontak() async {
    //list menampung data dari database
    var list = await db.getAllKontak();

    //ada perubahanan state
    setState(() {
      //lakukan perulangan pada variabel list
      list!.forEach((kontak) {
        //masukan data ke listKontak
        listKontak.add(Kontak.fromMap(kontak));
      });
    });
  }

  //menghapus data Kontak
  Future<void> _deleteKontak(Kontak kontak, int position) async {
    await db.deleteKontak(kontak.id!);
    setState(() {
      listKontak.removeAt(position);
    });
  }

  // membuka halaman tambah Kontak
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => EntryForm()));
    if (result == 'save') {
      await _getAllKontak();
    }
  }

  //membuka halaman edit Kontak
  Future<void> _openFormEdit(Kontak kontak) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EntryForm(kontak: kontak)));
    if (result == 'update') {
      await _getAllKontak();
    }
  }
}
