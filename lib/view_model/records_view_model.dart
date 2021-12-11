import 'package:quitouch/model/category.dart';
import 'package:quitouch/model/patience_record.dart';
import 'package:quitouch/repository/cate_record_repo.dart';

class RecordsViewModel {
  final repository = CateRecordRepository();

  var counts = 0;
  var currentPageCounts = 0;

  Future<List<Category>> fetchCategories() async {
    List<Category> _categories;
    _categories = await repository.selectCategories();
    return _categories;
  }

  Future<List<PatienceRecord>> fetchPatiencRecords(
      Category selectedCategory, int limit, int offset) async {
    List<PatienceRecord> patienceRecords = [];
    if (selectedCategory.id != "null") {
      patienceRecords = await repository.selectPatienceRecordByCateWithLimit(
          selectedCategory, limit, offset);
      counts = await repository.countOfPatienceRecords(selectedCategory);
      currentPageCounts = patienceRecords.length;
    }
    return patienceRecords;
  }

  Future<bool> deletePatienceRecord(PatienceRecord selectedRecord) async {
    if (selectedRecord.id != "null") {
      await repository.deletePatienceRecordById(selectedRecord.id);
      return true;
    } else {
      print("delete patience record faild : id == null");
      return false;
    }
  }
}
