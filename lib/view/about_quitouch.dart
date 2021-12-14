import 'package:flutter/material.dart';

class AboutQuitouch extends StatelessWidget {
  const AboutQuitouch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Quitouch"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text("about quitouch"),
            ),
          ],
        ),
      ),
    );
  }
}
