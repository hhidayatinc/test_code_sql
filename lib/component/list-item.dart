// import 'package:flutter/material.dart';
//
// class ListItemWidget extends StatelessWidget {
//   final String nama, email, company, no;
//   final Function onPressed;
//
//   ListItemWidget({required this.nama,required this.email, required this.no, required this.company, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//           top: 20
//       ),
//       child: ListTile(
//         leading: Icon(
//           Icons.person,
//           size: 50,
//         ),
//         title: Text(
//             '$nama'
//         ),
//         subtitle: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(
//                 top: 8,
//               ),
//               child: Text("Email: $email"),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 top: 8,
//               ),
//               child: Text("Phone: $no"),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 top: 8,
//               ),
//               child: Text("Company: $company"),
//             )
//           ],
//         ),
//         trailing:
//         FittedBox(
//           fit: BoxFit.fill,
//           child: Row(
//             children: [
//               // button edit
//               IconButton(
//                   onPressed: () async{
//                     var result = await Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => EntryForm(kontak: kontak)));
//                     if (result == 'update') {
//                       _refreshKontakList();
//                     }
//                   },
//                   icon: Icon(Icons.edit)
//               ),
//               // button hapus
//               IconButton(
//                 icon: Icon(Icons.delete),
//                 onPressed: (){
//                   //membuat dialog konfirmasi hapus
//                   AlertDialog hapus = AlertDialog(
//                     title: Text("Information"),
//                     content: Container(
//                       height: 100,
//                       child: Column(
//                         children: [
//                           Text(
//                               "Yakin ingin Menghapus Data ${kontak.nama}"
//                           )
//                         ],
//                       ),
//                     ),
//
//                     actions: [
//                       TextButton(
//                           onPressed: ()async{
//                             await db.deleteKontak(kontak.id!);
//                             setState(() {
//                               listKontak.removeAt(i);
//                             });
//                             Navigator.pop(context);
//                           },
//                           child: Text("Ya")
//                       ),
//                       TextButton(
//                         child: Text('Tidak'),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ],
//                   );
//                   showDialog(context: context, builder: (context) => hapus);
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
