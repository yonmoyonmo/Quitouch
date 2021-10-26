import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:quitouch/model/category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class CateRecordRepository {
  static final CateRecordRepository _instance = CateRecordRepository._();
  static Database? _database;

  CateRecordRepository._();
  factory CateRecordRepository() {
    return _instance;
  }

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await init();
    return _database;
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = directory.path + "database.db";
    var database = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return database;
  }

  Future _onCreate(Database db, int version) async {
    //create table SQL
    await db.execute('''
        CREATE TABLE category(
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
        )
      ''');
    await db.execute('''
        CREATE TABLE patience_record(
          id TEXT PRIMARY KEY,
          cateId TEXT NOT NULL,
          touchCount INTEGER NOT NULL,
          createdAt TEXT NOT NULL,
          FOREIGN KEY (cataId) REFERENCES category (id)
          ON DELETE NO ACTION ON UPDATE NO ACTION
        )
      ''');
  }

  //category, patience record CRUD
  //Future<Category> insertOrUpdateCategory(Category category) async {}
}
