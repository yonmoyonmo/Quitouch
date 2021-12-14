import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quitouch/repository/dbclient.dart';
import 'package:quitouch/view/category_edit.dart';
import 'package:quitouch/view/component/animated_splash.dart';
import 'package:quitouch/view/quitouch_home.dart';
import 'package:quitouch/view/records.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //ads : admon
  MobileAds.instance.initialize();
  //sqflite
  final dBClient = DBClient();
  await dBClient.database;

  runApp(const Quitouch());
}

class Quitouch extends StatelessWidget {
  const Quitouch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'DungGeunMo',
        primarySwatch: Colors.deepPurple,
      ),
      routes: {
        '/': (context) => AnimatedSplashPage(),
        '/home': (context) => QuitouchHome(),
        '/edit': (_) => CategoryEdit(),
        '/records': (_) => Records(),
      },
    );
  }
}
