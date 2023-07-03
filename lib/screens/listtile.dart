import 'package:flutter/material.dart';
import 'package:flutter_contact/database/dbhelper.dart';
import 'package:flutter_contact/model/kontak.dart';

class ItemList extends StatefulWidget{
  late final Kontak kontak;
  Function() onDeletePress;
  Function() onEditPress;

  ItemList({required this.kontak, required this.onDeletePress, required this.onEditPress});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList>{
  final DBHelper dbh = new DBHelper();
  @override
  Widget build(BuildContext context) {
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
            '${widget.kontak.nama}'
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: Text("Email: ${widget.kontak.email}"),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: Text("Phone: ${widget.kontak.no}"),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: Text("Company: ${widget.kontak.company}"),
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
                  onPressed: widget.onEditPress,
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
                              "Yakin ingin Menghapus Data ${widget.kontak.nama}"
                          )
                        ],
                      ),
                    ),

                    actions: [
                      TextButton(
                          onPressed: widget.onDeletePress,
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

  }

}