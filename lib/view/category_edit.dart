import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quitouch/model/category.dart';
import 'package:quitouch/view_model/category_edit_view_model.dart';

class CategoryEdit extends StatefulWidget {
  const CategoryEdit({Key? key}) : super(key: key);

  @override
  _CategoryEditState createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {
  final vm = CategoryEditViewModel();
  var cateName = "";
  var cateEditName = "";

  void _showCateAddAlert() {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("add category"),
          content: CupertinoTextField(
            onChanged: (text) {
              setState(() {
                cateName = text;
              });
            },
          ),
          actions: [
            CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text("create category"),
                onPressed: () async {
                  if (cateName != "") {
                    await vm.createCategory(cateName);
                    setState(() {
                      cateName = "";
                    });
                    Navigator.pop(context);
                  } else {
                    return;
                  }
                })
          ],
        );
      },
    );
  }

  void _showCateEditAlert(Category selectedCate) {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Edit Category Name"),
          content: Column(children: [
            Text(
              selectedCate.name,
              style: const TextStyle(fontSize: 20),
            ),
            CupertinoTextField(
              onChanged: (text) {
                setState(() {
                  cateEditName = text;
                });
              },
            ),
          ]),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("confirm edit"),
              onPressed: () async {
                if (cateEditName != "") {
                  await vm.updateCategory(selectedCate, cateEditName);
                  setState(() {
                    cateEditName = "";
                  });
                  Navigator.pop(context);
                } else {
                  return;
                }
              },
            )
          ],
        );
      },
    );
  }

  void _showCateDeleteAlert(Category selectedCate) {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Delete Category"),
          content: Column(children: [
            const Text(
                "if you delete this category, records under this will be deleted also"),
            Text(
              selectedCate.name,
              style: const TextStyle(fontSize: 20),
            )
          ]),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("confirm delete"),
              onPressed: () async {
                await vm.deleteCategory(selectedCate);
                setState(() {});
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: Text("home"),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoButton(
                child: Icon(Icons.add),
                onPressed: () {
                  _showCateAddAlert();
                },
              ),
            ],
          ),
          Text("categories"),
          FutureBuilder(
            future: vm.fetchCategories(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Category> categories = snapshot.data as List<Category>;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(categories[index].name),
                          padding: const EdgeInsets.all(10),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CupertinoButton(
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  _showCateEditAlert(categories[index]);
                                },
                              ),
                              CupertinoButton(
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  _showCateDeleteAlert(categories[index]);
                                },
                              ),
                            ]),
                      ],
                    );
                  },
                );
              } else {
                return Text("loading..");
              }
            },
          ),
        ],
      ),
    );
  }
}
