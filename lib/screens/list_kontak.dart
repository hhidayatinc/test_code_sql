import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../database/dbhelper.dart';
import '../model/kontak.dart';
import 'entry_form.dart';

class ListKontakPage extends StatefulWidget {

  @override
  ListKontakPageState createState() => ListKontakPageState();
}

class ListKontakPageState extends State<ListKontakPage> {
  List<Kontak> listKontak = [
    Kontak(nama: "Ana", email: "ana1@gmail.com", no: "0876543890", company: "polinema1"),
    Kontak(nama: "Ani", email: "ana@gmail.com", no: "087654389", company: "polinema")
  ];
  DBHelper db = DBHelper();
  @override
  void initState() {
    //menjalankan fungsi getallkontak saat pertama kali dimuat
    _refreshKontakList();
    super.initState();
  }

  void _refreshKontakList() async {
    var list = await db.getAllKontak();
    //ada perubahanan state
    setState(() {
      //listKontak.clear();
      //lakukan perulangan pada variabel list
      list!.forEach((kontak) {
        //masukan data ke listKontak
        listKontak.add(Kontak.fromMap(kontak));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Daftar Kontak"),
        ),
      ),
      body: ListView.builder(
          itemCount: listKontak.length,
          itemBuilder: (context, i) {
            Kontak kontak = listKontak[i];
            // for (int i = 0; i < listKontak.length; i++) {
            //   var data = listKontak[i].nama;
            //   //print or add data to any other list and insert to another list and save to database
            //   return Text('${listKontak[i].nama}');
            // }

            //return ListTile(title: Text('${listKontak[i].nama}'),);
            //return getTextWidgets();
            return Padding(
              padding: const EdgeInsets.only(
                  top: 20
              ),
              child: ListTile(
                leading: Icon(
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
                            var result = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) => EntryForm(kontak: kontak)));
                            if (result == 'update') {
                               _refreshKontakList();
                            }
                          },
                          icon: Icon(Icons.edit)
                      ),
                      // button hapus
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){
                          //membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: Text("Information"),
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

                            actions: [
                              TextButton(
                                  onPressed: ()async{
                                    await db.deleteKontak(kontak.id!);
                                    setState(() {
                                      listKontak.removeAt(i);
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ya")
                              ),
                              TextButton(
                                child: Text('Tidak'),
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
        key: Key('add icon'),
        child: Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.push(
            context, MaterialPageRoute(builder: (context) => EntryForm()));
        if (result == 'save') {
         _refreshKontakList();
        }},
      ),

    );
  }

  void iterateKontak(){
    for (int i = 0; i < listKontak.length; i++) {
      var data = listKontak[i].nama;
      //print or add data to any other list and insert to another list and save to database
      Text(data.toString());
    }
  }

  Widget getTextWidgets()
  {
    List<Widget> list =[];
    for (int i = 0; i < listKontak.length; i++) {
      var data = listKontak[i].nama;
      //print or add data to any other list and insert to another list and save to database
      list.add(new Text('${data}'));
    }
    return new Row(children: list);
  }
}