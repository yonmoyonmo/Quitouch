// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:quitouch/model/category.dart';
import 'package:quitouch/repository/cate_record_repo.dart';

class CategoryEditViewModel {
  final repository = CateRecordRepository(); //singleton repo

  List<Category> _categories = [];

  Future<List<Category>> fetch_Categories() async {
    _categories = await repository.selectCategories();
    return _categories;
  }

  Future<bool> createCategory(String name) async {
    if (name != "" || name.isNotEmpty) {
      print(name + " is being created");
      Category newCategory = Category();
      newCategory.name = name;
      Category result = await repository.insertOrUpdateCategory(newCategory);

      if (result.id == "null") {
        print("creation mal func");
        return false;
      } else {
        print(name + " is created");
        return true;
      }
    } else {
      print("invalid name");
      return false;
    }
  }
}
