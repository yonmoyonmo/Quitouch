import 'package:flutter/material.dart';

class AboutWonmonae extends StatelessWidget {
  const AboutWonmonae({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Wonmonae"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text("about wonmonae"),
            ),
          ],
        ),
      ),
    );
  }
}
