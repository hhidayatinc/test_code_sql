import 'package:flutter/material.dart';
import 'package:flutter_contact/model/kontak.dart';

import '../screens/entry_form.dart';

class DaftarKontak extends StatelessWidget {
  final List<Kontak> ListKontak;
  final Function() refreshKontakList;

  const DaftarKontak({Key? key, required this.ListKontak, required this.refreshKontakList}) : super(key: key);
@override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ListView.builder(
              itemCount: ListKontak.length,
              itemBuilder: (context, i) {
                Kontak kontak = ListKontak[i];
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
                                   refreshKontakList();
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
                                          ListKontak.removeAt(i);
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
        ],
      );
  }
}