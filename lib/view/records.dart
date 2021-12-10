import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quitouch/model/category.dart';
import 'package:quitouch/model/patience_record.dart';
import 'package:quitouch/view_model/records_view_model.dart';

class Records extends StatefulWidget {
  const Records({Key? key}) : super(key: key);

  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  final vm = RecordsViewModel();
  Category? selectedCategory;
  var howMany = 0;
  var currentPageCount = 0;
  var offset = 0;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle01 = TextStyle(color: Colors.white, fontSize: 20);
    TextStyle textStyle02 = TextStyle(color: Colors.white, fontSize: 24);
    TextStyle textStyle03 = TextStyle(color: Colors.black, fontSize: 20);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Quitouch Records"),
        actions: [
          CupertinoButton(
            child: const Text("dummy"),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //cates
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
          //selected cate
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
          //times
          Text(
            howMany != 0 ? howMany.toString() + " times" : "0 times",
            style: textStyle03,
          ),

          if (selectedCategory != null)
            Column(
              children: [
                //page buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Row(children: const [
                        Icon(Icons.arrow_back_ios),
                        Text("previous page"),
                      ]),
                      onPressed: () {
                        if (offset != 0) {
                          setState(() {
                            offset = offset - 20;
                          });
                        }
                      },
                    ),
                    TextButton(
                      child: Row(children: const [
                        Text("next page"),
                        Icon(Icons.arrow_forward_ios),
                      ]),
                      onPressed: () {
                        setState(() {
                          if (currentPageCount > 19) {
                            offset += 20;
                          }
                        });
                      },
                    ),
                  ],
                ),
                //records
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: EdgeInsets.all(10),
                  child: FutureBuilder(
                    future:
                        vm.fetchPatiencRecords(selectedCategory!, 20, offset),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<PatienceRecord> records =
                            snapshot.data as List<PatienceRecord>;

                        SchedulerBinding.instance!.addPostFrameCallback((_) {
                          setState(() {
                            howMany = vm.counts;
                            currentPageCount = vm.currentPageCounts;
                          });
                        });

                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: records.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 1),
                              )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    (index + 1).toString(),
                                    style: textStyle03,
                                  ),
                                  Text(
                                    "touch : " +
                                        records[index].touchCount.toString(),
                                    style: textStyle03,
                                  ),
                                  Text(
                                    records[index].createdAt,
                                    style: textStyle03,
                                  ),
                                ],
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
              ],
            ),
        ],
      ),
    );
  }
}
