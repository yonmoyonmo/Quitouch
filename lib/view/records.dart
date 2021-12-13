import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quitouch/model/category.dart';
import 'package:quitouch/model/patience_record.dart';
import 'package:quitouch/view/component/quitouch_button.dart';
import 'package:quitouch/view/component/selected_cate_container.dart';
import 'package:quitouch/view/component/textstyles.dart';
import 'package:quitouch/view_model/records_view_model.dart';

class Records extends StatefulWidget {
  const Records({Key? key}) : super(key: key);

  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  final vm = RecordsViewModel();
  late Future<dynamic> _futureCategories;
  Category? selectedCategory;

  var howMany = 0;
  var currentPageCount = 0;
  var offset = 0;

  @override
  void initState() {
    _futureCategories = vm.fetchCategories();
    super.initState();
  }

  //
  void _showRecordDeleteAlert(PatienceRecord selectedRecord) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: const Text("Delete this Record"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Are you sure??"),
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
                    await vm.deletePatienceRecord(selectedRecord);
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
  //

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/backgroundImage.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(33, 2, 117, 1),
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Quitouch Records",
            style: TextStyles.textStyle02white,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //cates in records (smaller list)
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 12,
              decoration: BoxDecoration(color: Colors.transparent),
              child: FutureBuilder(
                future: _futureCategories,
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
                            //dddd
                            width: 96,
                            height: 40,
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(5),
                            //dddd
                            alignment: Alignment.center,
                            child: Text(
                              categories[index].name,
                              style: TextStyles.textStyle05white,
                            ),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("images/quitouch_button.png"),
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
            (selectedCategory != null)
                ? SelectedCateContainer(selectedCategory!.name)
                : SelectedCateContainer("select a category!"),
            //times
            Text(
              howMany != 0
                  ? "You've endured " + (howMany.toString()) + " times"
                  : "",
              style: TextStyles.textStyle02white,
            ),

            if (selectedCategory != null)
              Column(
                children: [
                  //page buttons
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: Row(children: const [
                            Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.black,
                            ),
                            Text(
                              "previous page",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
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
                            Text(
                              "next page",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.black,
                            ),
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
                  ),
                  //records
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(181, 181, 181, 0.6),
                    ),
                    height: MediaQuery.of(context).size.height * 0.43,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
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
                              return ListTile(
                                isThreeLine: true,
                                leading: Text(
                                  (index + 1).toString(),
                                ),
                                title: Text(
                                  "Quitouched " +
                                      (records[index].touchCount).toString() +
                                      " times",
                                  style: TextStyles.textStyle03black,
                                ),
                                subtitle: Text(
                                  records[index].createdAt,
                                  style: TextStyles.textStyle04black,
                                ),
                                trailing: TextButton(
                                  child: Image(
                                    image: AssetImage("images/trashcan.png"),
                                  ),
                                  onPressed: () {
                                    _showRecordDeleteAlert(records[index]);
                                  },
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
      ),
    );
  }
}
