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
      Category result = await repository.insertCategory(newCategory);
      if (result.id != "null" && result.name != "name duplicated") {
        return true;
      } else {
        return false;
      }
    } else {
      print("invalid name");
      return false;
    }
  }

  Future<bool> updateCategory(Category selectedCategory, String newName) async {
    if (selectedCategory.id != "null") {
      selectedCategory.name = newName;
      Category result = await repository.updateCategory(selectedCategory);
      if (result.name != "name duplicated") {
        return true;
      } else {
        return false;
      }
    } else {
      print("update cate failed : id == null");
      return false;
    }
  }

  Future<bool> deleteCategory(Category selectedCategory) async {
    if (selectedCategory.id != "null") {
      await repository.deleteCategoryById(selectedCategory.id);
      return true;
    } else {
      print("delete cate failed : id == null");
      return false;
    }
  }
}
