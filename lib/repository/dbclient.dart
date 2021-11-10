import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBClient {
  DBClient._();
  static final DBClient _instance = DBClient._();
  factory DBClient() {
    return _instance;
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await init();
    return _database;
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = directory.path + "quitouch.db";
    var database = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return database;
  }

  Future _onCreate(Database db, int version) async {
    print("create tables......");
    //create table SQL
    await db.execute('''
        CREATE TABLE category(
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL
        )
      ''');
    await db.execute('''
        CREATE TABLE patience_record(
          id TEXT PRIMARY KEY,
          cateId TEXT NOT NULL,
          touchCount INTEGER NOT NULL,
          createdAt TEXT NOT NULL,
          FOREIGN KEY (cateId) REFERENCES category (id)
          ON DELETE CASCADE ON UPDATE NO ACTION
        )
      ''');
  }
}
