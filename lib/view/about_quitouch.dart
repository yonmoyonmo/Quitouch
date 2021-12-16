import 'package:flutter/material.dart';
import 'package:quitouch/view/component/textstyles.dart';

class AboutQuitouch extends StatelessWidget {
  const AboutQuitouch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("About Quitouch"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width > 700
                    ? MediaQuery.of(context).size.width * 0.3
                    : MediaQuery.of(context).size.width * 0.6,
                child: Image(
                  image: AssetImage("images/quitouch_appIcon.png"),
                ),
                margin: EdgeInsets.all(20),
              ),
              Container(
                width: MediaQuery.of(context).size.width > 700
                    ? MediaQuery.of(context).size.width * 0.4
                    : MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  """Quitouch is designed for quitting bad habits like smoking cigarettes.

By keeping touching this app's character: quitachi, you could endure your bad desires.

With the same way, you can endure whatever needed patience like sudden poop!

Have a nice Quitouch!""",
                  style: TextStyles.textForDocs,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
