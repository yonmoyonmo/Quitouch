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
  var offset = 0;

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
                child: const Text("home"),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoButton(
                child: const Text("chart"),
                onPressed: () {},
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
          Text(howMany != 0 ? howMany.toString() + " times" : ""),
          if (selectedCategory != null)
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
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
                  CupertinoButton(
                    child: Row(children: const [
                      Text("next page"),
                      Icon(Icons.arrow_forward_ios),
                    ]),
                    onPressed: () {
                      setState(() {
                        offset = offset + 20;
                      });
                    },
                  ),
                ],
              ),
              Container(
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
                          });
                        });

                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: records.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text((index + 1).toString()),
                                Text("touch : " +
                                    records[index].touchCount.toString()),
                                Text(records[index].createdAt),
                              ],
                            );
                          },
                        );
                      } else {
                        return const Text("loading..");
                      }
                    }),
              ),
            ]),
        ],
      ),
    );
  }
}
