import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quitouch/model/category.dart';
import 'package:quitouch/view/component/quitouch_button.dart';
import 'package:quitouch/view/component/textstyles.dart';
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
          title: const Text("Make New Category!"),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              isDense: true,
              contentPadding: EdgeInsets.all(10),
            ),
            maxLength: 23,
            onChanged: (text) {
              setState(() {
                cateName = text;
              });
            },
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: QuitouchButton("NO"),
                  onPressed: () async {
                    setState(() {
                      cateName = "";
                    });
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: QuitouchButton("YES"),
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
                  },
                ),
              ],
            ),
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
          title: const Text("Edit Category Name!"),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  "current : \n" + selectedCate.name,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.all(10),
                ),
                maxLength: 23,
                onChanged: (text) {
                  setState(() {
                    cateEditName = text;
                  });
                },
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: QuitouchButton("NO"),
                  onPressed: () async {
                    setState(() {
                      cateEditName = "";
                    });
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: QuitouchButton("YES"),
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
                ),
              ],
            ),
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
                  "If you delete this category, records under this will be deleted also"),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: QuitouchButton("NO"),
                  onPressed: () {
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: QuitouchButton("YES"),
                  onPressed: () async {
                    await vm.deleteCategory(selectedCate);
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/backgroundImage.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(33, 2, 117, 1),
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Quitouch Categories",
            style: TextStyles.textStyle02white,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _showCateAddAlert();
              },
            ),
          ],
        ),
        body: Container(
          width: screenWidth,
          height: screenHeight,
          child: FutureBuilder(
            future: vm.fetchCategories(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Category> categories = snapshot.data as List<Category>;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _showCateEditAlert(categories[index]);
                        });
                      },
                      child: Container(
                        height: 120,
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(15),
                        alignment: Alignment.center,
                        child: Row(
                            mainAxisAlignment: screenWidth > 700
                                ? MainAxisAlignment.spaceAround
                                : MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                categories[index].name,
                                style: TextStyles.textStyle01white,
                              ),
                              TextButton(
                                child: Image(
                                  image: AssetImage("images/trashcan.png"),
                                ),
                                onPressed: () {
                                  _showCateDeleteAlert(categories[index]);
                                },
                              ),
                            ]),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          image: DecorationImage(
                            image: AssetImage("images/quitouch_button.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Text("loading..");
              }
            },
          ),
        ),
      ),
    );
  }
}
