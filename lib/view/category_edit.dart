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
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("add category"),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: TextField(
            maxLength: 20,
            onChanged: (text) {
              setState(() {
                cateName = text;
              });
            },
          ),
          actions: [
            ElevatedButton(
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
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Category Name"),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  selectedCate.name,
                  style: const TextStyle(fontSize: 20),
                ),
                TextField(
                  maxLength: 20,
                  onChanged: (text) {
                    setState(() {
                      cateEditName = text;
                    });
                  },
                ),
              ]),
          actions: [
            ElevatedButton(
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
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: const Text("Delete Category"),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                    "if you delete this category, records under this will be deleted also"),
                Text(
                  selectedCate.name,
                  style: const TextStyle(fontSize: 20),
                )
              ]),
          actions: [
            ElevatedButton(
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
    TextStyle textStyle01 = TextStyle(color: Colors.white, fontSize: 20);

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/backgroundImage.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text("Quitouch Categories"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _showCateAddAlert();
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: vm.fetchCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Category> categories = snapshot.data as List<Category>;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showCateEditAlert(categories[index]);
                          });
                        },
                        child: Container(
                          width: 240,
                          height: 100,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(
                            categories[index].name,
                            style: textStyle01,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/quitouch_button.png"),
                                fit: BoxFit.contain),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.black,
                          size: 50,
                        ),
                        onPressed: () {
                          _showCateDeleteAlert(categories[index]);
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              return const Text("loading..");
            }
          },
        ),
      ),
    );
  }
}

// Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 IconButton(
//                                   icon: const Icon(
//                                     Icons.edit,
//                                     color: Colors.black,
//                                   ),
//                                   onPressed: () {
//                                     _showCateEditAlert(categories[index]);
//                                   },
//                                 ),
//                                 
//                               ]),