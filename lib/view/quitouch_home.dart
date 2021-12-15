import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quitouch/model/category.dart';
import 'package:quitouch/view/component/quitouch_button.dart';
import 'package:quitouch/view/component/quitouch_drawer.dart';
import 'package:quitouch/view/component/selected_cate_container.dart';
import 'package:quitouch/view_model/home_view_model.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
//import 'package:share_plus/share_plus.dart';

import 'component/textstyles.dart';

class QuitouchHome extends StatefulWidget {
  const QuitouchHome({Key? key}) : super(key: key);

  @override
  _QuitouchHomeState createState() => _QuitouchHomeState();
}

class _QuitouchHomeState extends State<QuitouchHome> {
  final vm = HomeViewModel();

  Category? selectedCategory;
  int touchCount = 0;

  var animeBool = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //now it's real id
  final androidBanner = "ca-app-pub-4829575790302011/2876045431";
  final iosBanner = "ca-app-pub-4829575790302011/5362607973";

  void _wellDoneAlert(int count) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(181, 181, 181, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: const Text(
            "Well Done!!",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "You just have Quitouched " + count.toString() + " times!!!",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                const Image(image: AssetImage("images/donetachi.png")),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: QuitouchButton("OK"),
              onPressed: () async {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit?!'),
            content: Text('Do you want to exit this App?'),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: QuitouchButton('NO'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: QuitouchButton('YES'),
                  ),
                ],
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var bannerId = "";
    if (Platform.isIOS) {
      bannerId = iosBanner;
    } else if (Platform.isAndroid) {
      bannerId = androidBanner;
    } else {
      bannerId = androidBanner;
    }

    final BannerAdListener listener = BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
    );

    final BannerAd quitouchBanner = BannerAd(
      adUnitId: bannerId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: listener,
    );

    quitouchBanner.load();

    final AdWidget adWidget = AdWidget(ad: quitouchBanner);

    final Container adContainer = Container(
      alignment: Alignment.center,
      child: adWidget,
      width: quitouchBanner.size.width.toDouble(),
      height: quitouchBanner.size.height.toDouble(),
    );

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/backgroundImage.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          //
          drawer: QuitouchDrawer(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              "Quitouch",
              style: TextStyles.textStyle02white,
            ),
            leading: TextButton(
              child: Image(
                image: AssetImage("images/quitouch_cate.png"),
              ),
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            ),
            actions: [
              TextButton(
                child: Image(
                  image: AssetImage("images/quitouch_record.png"),
                ),
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
              TextButton(
                child:
                    Image(image: AssetImage("images/quitouch_real_cate.png")),
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
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //cates in home(bigger then records cates)
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: FutureBuilder(
                    future: vm.fetchCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Category> categories =
                            snapshot.data as List<Category>;
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
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                child: Text(
                                  categories[index].name,
                                  style: TextStyles.textStyle06white,
                                ),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "images/quitouch_button.png"),
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

                //donebutton
                TextButton(
                  child: QuitouchButton("DONE!!"),
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

                //kitachi
                AnimatedContainer(
                  width: animeBool
                      ? MediaQuery.of(context).size.width * 0.8
                      : MediaQuery.of(context).size.width * 0.7,
                  height: animeBool
                      ? MediaQuery.of(context).size.width * 0.8
                      : MediaQuery.of(context).size.width * 0.7,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.bounceOut,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedCategory != null) {
                          animeBool = !animeBool;
                          touchCount++;
                          HapticFeedback.mediumImpact();
                        }
                      });
                    },
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image(
                          image: AssetImage(
                              'images/quitachi${touchCount % 4}.png'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //touchCount
                            if (touchCount != 0)
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  touchCount.toString(),
                                  style: TextStyles.textStyle07white,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //banner ads
                adContainer
              ],
            ),
          ),
        ),
      ),
    );
  }
}
