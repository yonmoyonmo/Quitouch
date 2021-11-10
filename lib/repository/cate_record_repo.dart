import 'package:quitouch/model/category.dart';
import 'package:quitouch/model/patience_record.dart';
import 'package:quitouch/repository/dbclient.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class CateRecordRepository {
  CateRecordRepository._();
  static final CateRecordRepository _instance = CateRecordRepository._();
  factory CateRecordRepository() {
    return _instance;
  }

  final dbClient = DBClient();
  final uuid = const Uuid();

  //category, patience record CRUD
  //~~~~~~~~~~~ category ~~~~~~~~~~~~~~~~~~~~~
  Future<bool> isCateDuplicated(Category category) async {
    final db = await dbClient.database;
    var count = Sqflite.firstIntValue(await db!.rawQuery(
        "SELECT COUNT(*) FROM category WHERE name = ?", [category.name]));
    if (count != 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<Category> insertOrUpdateCategory(Category category) async {
    final db = await dbClient.database;

    var isDuplicatedCate = await isCateDuplicated(category);
    if (!isDuplicatedCate) {
      print(category.name + " is being created");

      category.id = uuid.v4();
      await db!.insert("category", category.toMap());

      print(category.name + " is created");
      return category;
    } else {
      //저장된 것이 있음 -> 업데이트 함
      await db!.update("category", category.toMap(),
          where: "id = ?", whereArgs: [category.id]);
      return category;
    }
  }

  Future<List<Category>> selectCategories() async {
    final db = await dbClient.database;
    List<Category> categories = [];
    List<Map> results = await db!.query("category", columns: Category.columns);
    for (Map result in results) {
      categories.add(Category.fromMap(result));
    }
    return categories;
  }

  Future<void> deleteCategoryById(String id) async {
    final db = await dbClient.database;
    await db!.delete("category", where: "id = ?", whereArgs: [id]);
  }

  //~~~~~~~~~ patience record ~~~~~~~~~~~~~~~~
  Future<PatienceRecord> insertPatienceRecord(
      PatienceRecord patienceRecord) async {
    final db = await dbClient.database;

    patienceRecord.id = uuid.v4();
    await db!.insert("patience_record", patienceRecord.toMap());
    return patienceRecord;
  }

  Future<PatienceRecord> updatePatienceRecord(
      PatienceRecord patienceRecord) async {
    final db = await dbClient.database;

    await db!.update("patience_record", patienceRecord.toMap(),
        where: "id = ?", whereArgs: [patienceRecord.id]);
    return patienceRecord;
  }

  Future<List<PatienceRecord>> selectPatienceRecordByCateWithLimit(
      Category category, int limit, int offset) async {
    final db = await dbClient.database;

    List<PatienceRecord> records = [];
    List<Map> results = await db!.query(
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
    final db = await dbClient.database;

    await db!.delete("patience_record", where: "id = ?", whereArgs: [id]);
  }
}
