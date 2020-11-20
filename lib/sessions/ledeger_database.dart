import 'dart:io';

import 'package:budgetplanner/dataModel/ledger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class LedgerHelper {
  static LedgerHelper _ledgerHelper;

  LedgerHelper.createInstance();

  static Database _database;

  factory LedgerHelper() {
    if (_ledgerHelper == null) {
      _ledgerHelper = LedgerHelper.createInstance();
    }
    return _ledgerHelper;
  }

  String tableName = 'ledger';
  String colId = 'id';
  String colName = 'name';
  String colCreatedDate = 'created_at';
  String colNextPaymentDate = 'next_payment';
  String colTotalAmount = 'total_amount';
  String colAmountPaid = 'amount_paid';
  String colTotalBalance = 'balance';

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colName TEXT,$colCreatedDate TEXT,$colNextPaymentDate TEXT, $colTotalAmount TEXT, $colAmountPaid TEXT,'
        '$colTotalBalance TEXT)');
  }

  Future<Database> initializeDatabase() async {
    String path = await getDatabasesPath();
    var database = openDatabase(join(path, 'accounts.db'),
        version: 1, onCreate: _createDb);

    return database;
  }

  Future<Database> get database async{

    if(_database == null){
      _database = await initializeDatabase();
    }

    return _database;
  }



   Future<List<Map<String,dynamic>>> mapOfLedgers() async {

    Database db = await this.database;

    var result = await db.query(tableName);

    return result;
  }

  Future<List<Ledger>> listOfLedger() async{
    var mapList = await mapOfLedgers();

    int count = mapList.length;

    List<Ledger> ledgerList = List<Ledger>();
    for(int i = 0 ; i < count ; i++){
      ledgerList.add(Ledger.fromMapObject(mapList[i]));
    }

    return ledgerList;
  }

  Future<int> insertLedger(Ledger dog) async {

    Database db = await this.database;
    var result = await db.insert(tableName,
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result;
  }

  Future<int> updateLedger(Ledger dog) async {
    // Get a reference to the database.

    Database db = await this.database;
    var result = await db.update(tableName, dog.toMap(),where: '$colId=?',whereArgs: [dog.id]);

    return result;
  }


  Future<int> deleteLedger(int  id) async {
    // Get a reference to the database.

    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $tableName WHERE $colId=$id');

    return result;
  }


  Future<int> getCount() async {
    // Get a reference to the database.

    Database db = await database;
    List<Map<String,dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $tableName');
    int result = Sqflite.firstIntValue(x);

    return result;
  }
}
