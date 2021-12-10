import 'package:quitouch/model/category.dart';
import 'package:quitouch/model/patience_record.dart';
import 'package:quitouch/repository/cate_record_repo.dart';

class HomeViewModel {
  final repository = CateRecordRepository();

  Future<List<Category>> fetchCategories() async {
    List<Category> _categories;
    var defaultCategory = new Category();

    _categories = await repository.selectCategories();
    if (_categories.isEmpty) {
      defaultCategory.name = "make a category!!";
      Category result = await repository.insertCategory(defaultCategory);
      _categories.add(result);
    }
    return _categories;
  }

  Future<bool> createPatienceRecord(int touchCount, String cateId) async {
    PatienceRecord newRecord = PatienceRecord();
    newRecord.cateId = cateId;
    newRecord.touchCount = touchCount;
    newRecord = await repository.insertPatienceRecord(newRecord);
    if (newRecord.id != "null") {
      return true;
    } else {
      return false;
    }
  }
}
