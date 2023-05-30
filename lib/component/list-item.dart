import 'package:flutter/material.dart';

import '../model/kontak.dart';

class ListItemWidget extends StatelessWidget {
  final Future<void> editform, deletekontak;
  final List<Kontak> listkt;

  ListItemWidget(
      {Key? key, required this.editform,
      required this.deletekontak,
      required this.listkt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListView.builder(
          itemCount: listkt.length,
          itemBuilder: (context, i) {
            Kontak kontak = listkt[i];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: const Icon(
                  Icons.person,
                  size: 50,
                ),
                title: Text('${kontak.nama}'),
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
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button edit
                      IconButton(
                          onPressed: () {
                            editform;
                          },
                          icon: const Icon(Icons.edit)),
                      // button hapus
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          //membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: const Text("Information"),
                            content: SizedBox(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      "Yakin ingin Menghapus Data ${kontak.nama}")
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    deletekontak;
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ya")),
                              TextButton(
                                child: const Text('Tidak'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    ]);
  }
}
