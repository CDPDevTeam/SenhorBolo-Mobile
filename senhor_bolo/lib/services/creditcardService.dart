import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:senhor_bolo/model/creditcard.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart';
import 'dart:math';

///TODO: Mudar para uma pasta db?

class CreditcardService {
  static final CreditcardService instance = CreditcardService._init();
  static Database? _database;

  CreditcardService._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('creditcard.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    late String? bdPassword;

    final storage = FlutterSecureStorage();
    bdPassword = await storage.read(key: 'bdPassword');

    // Gera uma senha aleatória, caso o BD não tenha sido criado
    if(bdPassword == null){
      const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#\$%&*+-*.';
      Random _rnd = Random();
      String getRandomString() => String.fromCharCodes(Iterable.generate(
          32, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
      bdPassword = getRandomString();
      storage.write(key: 'bdPassword', value: bdPassword);
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    return await openDatabase(
        path,
        version: 1,
        onCreate: _createDB,
        password: bdPassword
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('CREATE TABLE creditcard (num INTEGER PRIMARY KEY, name TEXT, expDate TEXT, cvv INTEGER, carrier TEXT)');
  }

  Future<void> create(CreditCard creditCard) async {
    final db = await instance.database;
    await db.insert(
        'creditcard',
        creditCard.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CreditCard>> selectAll() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('creditcard');

    return List.generate(maps.length, (i) {
      return CreditCard(
        num: maps[i]['num'],
        name: maps[i]['name'],
        expDate: maps[i]['expDate'],
        cvv: maps[i]['cvv'],
        carrier: maps[i]['carrier']
      );
    });
  }

  Future<void> update(CreditCard card) async {
    final db = await instance.database;
    await db.update(
      'creditcard',
       card.toMap(),
       where: 'num = ?',
       whereArgs: [card.num]
    );
  }

  Future<void> delete(CreditCard card) async {
    final db = await instance.database;
    await db.delete(
        'creditcard',
        where: 'num = ?',
        whereArgs: [card.num]
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}