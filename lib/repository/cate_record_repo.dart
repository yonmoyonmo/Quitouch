import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:quitouch/model/category.dart';
import 'package:quitouch/model/patience_record.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';

class CateRecordRepository {
  static final CateRecordRepository _instance = CateRecordRepository._();
  static Database? _database;
  final uuid = const Uuid();

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
          ON DELETE CASACADE ON UPDATE NO ACTION
        )
      ''');
  }

  //category, patience record CRUD
  //~~~~~~~~~~~ category ~~~~~~~~~~~~~~~~~~~~~
  Future<bool> isCateDuplicated(Category category) async {
    _database ??= await init();

    var count = Sqflite.firstIntValue(await _database!.rawQuery(
        "SELECT COUNT(*) FROM category WHERE name = ?", [category.name]));
    if (count != 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<Category> insertOrUpdateCategory(Category category) async {
    _database ??= await init();

    var isDuplicatedCate = await isCateDuplicated(category);
    if (!isDuplicatedCate) {
      //중복안됨
      category.id = uuid.v4();
      var debug = await _database!.insert("category", category.toMap());
      // ignore: avoid_print
      print(debug.toString() + "이것이 무엇인고?");
      //id를 생성하여 저장한 객체를 돌려줌
      return category;
    } else {
      //저장된 것이 있음 -> 업데이트 함
      await _database!.update("category", category.toMap(),
          where: "id = ?", whereArgs: [category.id]);
      return category;
    }
  }

  Future<List<Category>> selectCategories() async {
    _database ??= await init();

    List<Category> categories = [];
    List<Map> results =
        await _database!.query("category", columns: Category.columns);
    for (Map result in results) {
      categories.add(Category.fromMap(result));
    }
    return categories;
  }

  Future<void> deleteCategoryById(String id) async {
    _database ??= await init();
    await _database!.delete("category", where: "id = ?", whereArgs: [id]);
  }

  //~~~~~~~~~ patience record ~~~~~~~~~~~~~~~~
  Future<PatienceRecord> insertPatienceRecord(
      PatienceRecord patienceRecord) async {
    _database ??= await init();

    patienceRecord.id = uuid.v4();
    await _database!.insert("patience_record", patienceRecord.toMap());
    return patienceRecord;
  }

  Future<PatienceRecord> updatePatienceRecord(
      PatienceRecord patienceRecord) async {
    _database ??= await init();

    await _database!.update("patience_record", patienceRecord.toMap(),
        where: "id = ?", whereArgs: [patienceRecord.id]);
    return patienceRecord;
  }

  Future<List<PatienceRecord>> selectPatienceRecordByCateWithLimit(
      Category category, int limit, int offset) async {
    _database ??= await init();

    List<PatienceRecord> records = [];
    List<Map> results = await _database!.query(
      "patience_record",
      columns: PatienceRecord.columns,
      where: "cateId = ?",
      whereArgs: [category.id],
      limit: limit,
      offset: offset,
    );
    for (Map result in results) {
      records.add(PatienceRecord.fromMap(result));
    }
    return records;
  }

  Future<void> deletePatienceRecordById(String id) async {
    _database ??= await init();

    await _database!
        .delete("patience_record", where: "id = ?", whereArgs: [id]);
  }
}
