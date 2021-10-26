import 'package:flutter/material.dart';
import 'package:quitouch/view/quitouch_home.dart';

void main() {
  runApp(const Quitouch());
}

class Quitouch extends StatelessWidget {
  const Quitouch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuitouchHome(),
    );
  }
}
