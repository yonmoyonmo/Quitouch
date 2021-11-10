import 'package:flutter/cupertino.dart';
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("category edit"),
          CupertinoButton(
            child: Text("home"),
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            padding: EdgeInsets.all(13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoTextField(
                  onChanged: (text) {
                    setState(() {
                      cateName = text;
                    });
                  },
                ),
                CupertinoButton(
                  child: Text("create cate"),
                  onPressed: () async {
                    if (cateName != "") {
                      await vm.createCategory(cateName);
                      setState(() {
                        cateName = "";
                      });
                    } else {
                      return;
                    }
                  },
                )
              ],
            ),
          ),
          FutureBuilder(
            future: vm.fetchCategories(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Category> categories = snapshot.data as List<Category>;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Text(categories[index].name);
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
