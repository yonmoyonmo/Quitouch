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
            const Image(image: AssetImage("images/donetachi.png")),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("scaffold"),
        actions: [
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 10,
            decoration: BoxDecoration(color: Colors.amber),
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
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = categories[index];
                          });
                        },
                        child: Container(
                          width: 120,
                          height: 50,
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(
                            categories[index].name,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/quitouch_button.png"),
                                fit: BoxFit.contain),
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
          //
          Text(selectedCategory != null ? selectedCategory!.name : ""),
          //
          CupertinoButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              setState(() {
                touchCount++;
              });
            },
            child: const Image(image: AssetImage("images/quitachi1.png")),
          ),
          //
          if (touchCount != 0) Text(touchCount.toString()),
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
