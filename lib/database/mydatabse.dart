import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/kontak.dart';

class MyDatabase {
  final DatabaseFactory databaseFactory;
  final String dbName = 'my_database.db';

  MyDatabase({required this.databaseFactory});

  Future<Database> get database async {
    return await databaseFactory.openDatabase(join(await getDatabasesPath(), dbName));
  }

  Future<void> saveKontak(Kontak kontak) async {
    final db = await database;
    await db.insert(
      'kontak',
      kontak.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateKontak(Kontak kontak) async {
    final db = await database;
    await db.update(
      'kontak',
      kontak.toMap(),
      where: 'id = ?',
      whereArgs: [kontak.id],
    );
  }

  Future<void> deleteKontak(Kontak kontak) async {
    final db = await database;
    await db.delete(
      'kontak',
      where: 'id = ?',
      whereArgs: [kontak.id],
    );
  }

  Future<List<Kontak>> getKontakList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('kontak');
    return List.generate(maps.length, (i) {
      return Kontak(
        id: maps[i]['id'],
        nama: maps[i]['nama'],
        no: maps[i]['no'],
        email: maps[i]['email'],
        company: maps[i]['company'],
      );
    });
  }

  Future<Kontak?> getKontakById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'kontak',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      return null;
    } else {
      return Kontak(
        id: maps[0]['id'],
        nama: maps[0]['nama'],
        no: maps[0]['no'],
        email: maps[0]['email'],
        company: maps[0]['company'],
      );
    }
  }
}
