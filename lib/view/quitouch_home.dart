import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quitouch/model/category.dart';
import 'package:quitouch/view_model/home_view_model.dart';

class QuitouchHome extends StatefulWidget {
  const QuitouchHome({Key? key}) : super(key: key);

  @override
  _QuitouchHomeState createState() => _QuitouchHomeState();
}

class _QuitouchHomeState extends State<QuitouchHome> {
  final vm = HomeViewModel();

  Category? selectedCategory;
  int touchCount = 0;

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
                child: Text("records"),
                onPressed: () {},
              ),
              CupertinoButton(
                child: Text("category CRUD"),
                onPressed: () async {
                  await Navigator.pushNamed(context, '/edit');
                  setState(() {});
                },
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 10,
            child: FutureBuilder(
              future: vm.fetchCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Category> categories = snapshot.data as List<Category>;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CupertinoButton(
                          child: Text(categories[index].name),
                          onPressed: () {
                            setState(() {
                              selectedCategory = categories[index];
                            });
                          });
                    },
                  );
                } else {
                  return Text("loading..");
                }
              },
            ),
          ),
          Text(selectedCategory != null ? selectedCategory!.name : ""),
          CupertinoButton(
            onPressed: () {
              setState(() {
                touchCount++;
              });
            },
            child: const Icon(
              Icons.blur_circular,
              size: 100,
              color: Colors.black,
            ),
          ),
          Text(touchCount.toString()),
          const SizedBox(height: 20),
          CupertinoButton.filled(
            child: const Text("done"),
            onPressed: () async {
              bool result = await vm.createPatienceRecord(
                  touchCount, selectedCategory!.id);
              setState(() {
                touchCount = 0;
              });
            },
          ),
        ],
      ),
    );
  }
}
