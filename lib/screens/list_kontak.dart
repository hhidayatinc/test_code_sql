import 'package:flutter/material.dart';
import '../database/dbhelper.dart';
import '../model/kontak.dart';
import 'entry_form.dart';

class ListKontakPage extends StatefulWidget {

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
        title: const Center(
          child: Text("Daftar Kontak"),
        ),
      ),
      body: ListView.builder(
          itemCount: listKontak.length,
          itemBuilder: (context, i) {
            Kontak kontak = listKontak[i];
            return Padding(
              padding: const EdgeInsets.only(
                  top: 20
              ),
              child: ListTile(
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
                          onPressed: () async{
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
                            content: SizedBox(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      "Yakin ingin Menghapus Data ${kontak.nama}"
                                  )
                                ],
                              ),
                            ),

                            actions: [
                              TextButton(
                                  onPressed: (){
                                    _deleteKontak(kontak, i);
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
        onPressed: () {
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
      listKontak.clear();
      //lakukan perulangan pada variabel list
      for (var kontak in list!) {

        //masukan data ke listKontak
        listKontak.add(Kontak.fromMap(kontak));
      }
    });
    print(list?.length);
    print(list?.toString());
  }

  //menghapus data Kontak
  Future<void> _deleteKontak(Kontak kontak, int position) async {
    await db.deleteKontak(kontak.id!);
    setState(() {
      listKontak.removeAt(position);
    });
    print(listKontak.length);
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
