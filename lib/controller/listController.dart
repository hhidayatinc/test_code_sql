import 'package:flutter_contact/database/dbhelper.dart';
import 'package:flutter_contact/model/kontak.dart';
import 'package:sqflite/sqflite.dart';

class ListController{
  late final DBHelper database;
  List<dynamic> kontakList = [];

  ListController({required this.database});

  void addContact(Kontak kontak){
    kontakList.add(kontak);
  }

  void clear(){
    kontakList.clear();
  }

  Future<void> loadFromDatabase() async{
    kontakList.add(await database.getAllKontak());
  }
}