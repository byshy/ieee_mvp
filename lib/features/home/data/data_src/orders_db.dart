import 'dart:io';

import 'package:ieee_mvp/features/home/domain/entities/order.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String ordersTable = 'orders_table';
final String columnID = 'id';
final String columnDate = 'date';
final String columnPrice = 'price';

class DbProvider {
  static final String _databaseName = "mvp.db";
  static final int _databaseVersion = 1;

  DbProvider._privateConstructor();

  static final DbProvider instance = DbProvider._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
create table $ordersTable ( 
  $columnID integer primary key autoincrement, 
  $columnDate text not null,
  $columnPrice text not null)
''');
  }

  Future<int> insertOrder(String date, double price) async {
    Order order = Order(date: date, price: price);
    Database db = await database;
    order.id = await db.insert(ordersTable, order.toMap());
    return order.id;
  }

  Future close() async {
    Database db = await database;
    db.close();
  }
}
