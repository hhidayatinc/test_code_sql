import 'package:flutter/material.dart';
import 'package:flutter_contact/database/dbhelper.dart';
import 'package:flutter_contact/model/kontak.dart';

class EntryForm extends StatefulWidget{
  final Kontak? kontak;
  EntryForm({this.kontak});
  @override
  EntryFormState createState() => EntryFormState();
}

class EntryFormState extends State<EntryForm>{
  DBHelper db = DBHelper();

  TextEditingController? namaController;
  TextEditingController? nomorController;
  TextEditingController? emailController;
  TextEditingController? companyController;
  final _form = GlobalKey<FormState>();
  bool _isValid = false;

  @override
  void initState() {
    namaController = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.nama);

    nomorController = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.no);

    emailController = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.email);

    companyController = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.company);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Kontak')
      ),
      body: Form(
        key: _form,
    child: ListView(
      key: Key('ListViewForm'),
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextFormField(
              key: Key('addNama'),
              controller: namaController,
              decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              validator: (value){
                if(value!.isEmpty){
                  return 'Please enter your name';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextFormField(
              key: Key('addPhoneNumber'),
              controller: nomorController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Mobile No',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              validator: (value){
                if(value!.isEmpty){
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextFormField(
              key: Key('addEmail'),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                // Check if this field is empty
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                // using regular expression
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return "Please enter a valid email address";
                }
                // the email is valid
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              key: Key('addCompany'),
              controller: companyController,
              decoration: InputDecoration(
                  labelText: 'Company',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 20
            ),
            child: ElevatedButton(
              key: Key('tapButtonSave'),
              child: (widget.kontak == null)
                  ? Text(
                'Add',
                style: TextStyle(color: Colors.white),
              )
                  : Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if(_form.currentState!.validate()){
                  _form.currentState!.save();
                  upsertKontak();
                }
              },
            ),
          )
        ],
      ),
    ));
  }
  Future<void> upsertKontak() async {
    if (widget.kontak != null) {
      //update
      await db.updateKontak(Kontak(
          id: widget.kontak!.id,
          nama: namaController!.text,
          no: nomorController!.text,
          email: emailController!.text,
          company: companyController!.text
      ));
      Navigator.pop(context, 'update');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Success updating data'),
      ));
    } else {
      //insert
      await db.saveKontak(Kontak(
        nama: namaController!.text,
        no: nomorController!.text,
        email: emailController!.text,
        company: companyController!.text,
      ));
      Navigator.pop(context, 'save');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Success add data'),
      ));
    }
  }
}