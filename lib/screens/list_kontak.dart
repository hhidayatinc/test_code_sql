import 'package:flutter/material.dart';

import '../database/dbhelper.dart';
import '../model/kontak.dart';
import 'entry_form.dart';

class ListKontakPage extends StatefulWidget {
  // DBHelper db = DBHelper();
  ListKontakPage({ Key? key}) : super(key: key);

  @override
  ListKontakPageState createState() => ListKontakPageState();
}

class ListKontakPageState extends State<ListKontakPage> {
  List<Kontak> listKontak = [];
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
        key: Key('app_bar'),
        title: const Center(
          child: Text("Daftar Kontak"),
          key: Key('appbar_text'),
        ),
      ),
      body: ListView.builder(
        key: const Key('list_kontak'),
          itemCount: listKontak.length,
          itemBuilder: (context, index) {
            Kontak kontak = listKontak[index];
            return Padding(
              key: Key('padding_list'),
              padding: const EdgeInsets.only(
                  top: 20
              ),
              child: ListTile(
                key: Key('list_tile'),
                leading: const Icon(
                  Icons.person,
                  size: 50,
                ),
                title: Text(
                    '${kontak.nama}'
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Email: ${kontak.email}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Phone: ${kontak.no}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Company: ${kontak.company}"),
                    )
                  ],
                ),
                trailing:
                FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(kontak);
                          },
                          icon: const Icon(Icons.edit)
                      ),
                      // button hapus
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: (){
                          //membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: const Text("Information"),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      "Yakin ingin Menghapus Data ${kontak.nama}"
                                  )
                                ],
                              ),
                            ),
                            //terdapat 2 button.
                            //jika ya maka jalankan _deleteKontak() dan tutup dialog
                            //jika tidak maka tutup dialog
                            actions: [
                              TextButton(
                                  onPressed: (){
                                    _deleteKontak(kontak, index);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ya")
                              ),
                              TextButton(
                                child: const Text('Tidak'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      //membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        key: const Key('add icon'),
        child: const Icon(Icons.add),
        onPressed: (){
          _openFormCreate();
        },
      ),

    );
  }

  //mengambil semua data Kontak
  Future<void> _getAllKontak() async {
    //list menampung data dari database
    var list = await db.getAllKontak();

    //ada perubahanan state
    setState(() {
      //hapus data pada listKontak
      //listKontak.clear();

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