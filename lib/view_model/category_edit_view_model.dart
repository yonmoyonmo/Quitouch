// ignore_for_file: avoid_print

import 'package:quitouch/model/category.dart';
import 'package:quitouch/repository/cate_record_repo.dart';

class CategoryEditViewModel {
  final repository = CateRecordRepository();

  Future<List<Category>> fetchCategories() async {
    List<Category> _categories;
    _categories = await repository.selectCategories();
    return _categories;
  }

  Future<bool> createCategory(String name) async {
    if (name != "" || name.isNotEmpty) {
      Category newCategory = Category();
      newCategory.name = name;
      Category result = await repository.insertOrUpdateCategory(newCategory);
      if (result.id != "null") {
        return true;
      } else {
        return false;
      }
    } else {
      print("invalid name");
      return false;
    }
  }
}
