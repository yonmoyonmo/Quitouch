import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quitouch/model/category.dart';
import 'package:quitouch/view_model/home_view_model.dart';
import 'package:flutter/services.dart';

class QuitouchHome extends StatefulWidget {
  const QuitouchHome({Key? key}) : super(key: key);

  @override
  _QuitouchHomeState createState() => _QuitouchHomeState();
}

class _QuitouchHomeState extends State<QuitouchHome> {
  final vm = HomeViewModel();

  Category? selectedCategory;
  int touchCount = 0;

  void _wellDoneAlert(int count) {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Well Done!!"),
          content: Column(children: [
            Text(count.toString()),
            SizedBox(height: 10),
            const Image(image: AssetImage("images/quitachi_done.png")),
          ]),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("confirm"),
              onPressed: () async {
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
                child: const Text("records"),
                onPressed: () async {
                  await Navigator.pushNamed(context, '/records');
                  setState(() {});
                },
              ),
              CupertinoButton(
                child: const Text("categories"),
                onPressed: () async {
                  await Navigator.pushNamed(context, '/edit');
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(
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
                  return const Text("loading..");
                }
              },
            ),
          ),
          Text(selectedCategory != null ? selectedCategory!.name : ""),
          CupertinoButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              setState(() {
                touchCount++;
              });
            },
            child: const Image(image: AssetImage("images/quitachi.png")),
          ),
          if (touchCount != 0) Text(touchCount.toString()),
          SizedBox(height: 20),
          if (selectedCategory != null && touchCount != 0)
            CupertinoButton.filled(
              child: const Text("done"),
              onPressed: () async {
                if (touchCount != 0) {
                  await vm.createPatienceRecord(
                      touchCount, selectedCategory!.id);
                  _wellDoneAlert(touchCount);
                  setState(() {
                    touchCount = 0;
                  });
                }
              },
            ),
        ],
      ),
    );
  }
}
