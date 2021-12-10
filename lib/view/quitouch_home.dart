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
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: const Text("Well Done!!"),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(count.toString()),
                const Image(image: AssetImage("images/donetachi.png")),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
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
    TextStyle textStyle01 = TextStyle(color: Colors.white, fontSize: 20);
    TextStyle textStyle02 = TextStyle(color: Colors.white, fontSize: 20);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Quitouch"),
        actions: [
          CupertinoButton(
            child: const Text("records"),
            onPressed: () async {
              await Navigator.pushNamed(context, '/records')
                  .then((_) => setState(() {
                        this.selectedCategory = null;
                        this.touchCount = 0;
                      }));
              ;
              setState(() {});
            },
          ),
          CupertinoButton(
            child: const Text("categories"),
            onPressed: () async {
              await Navigator.pushNamed(context, '/edit')
                  .then((_) => setState(() {
                        this.selectedCategory = null;
                        this.touchCount = 0;
                      }));
              ;
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
                            touchCount = 0;
                          });
                        },
                        child: Container(
                          width: 132,
                          height: 55,
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

          Container(
            width: 240,
            height: 100,
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              selectedCategory != null ? selectedCategory!.name : "select one!",
              style: textStyle02,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/quitouch_button.png"),
                  fit: BoxFit.contain),
            ),
          ),
          //
          CupertinoButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              setState(() {
                if (selectedCategory != null) {
                  touchCount++;
                }
              });
            },
            child: Image(
                image: AssetImage('images/quitachi${touchCount % 4}.png')),
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
