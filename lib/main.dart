import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quitouch/repository/dbclient.dart';
import 'package:quitouch/view/category_edit.dart';
import 'package:quitouch/view/quitouch_home.dart';
import 'package:quitouch/view/records.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        primaryColor: Colors.blueGrey,
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        '/': (_) => QuitouchHome(),
        '/edit': (_) => CategoryEdit(),
        '/records': (_) => Records(),
      },
    );
  }
}
