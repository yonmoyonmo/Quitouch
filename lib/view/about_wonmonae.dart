import 'package:flutter/material.dart';

import 'component/textstyles.dart';

class AboutWonmonae extends StatelessWidget {
  const AboutWonmonae({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("About Wonmonae"),
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
                  image: AssetImage("images/logo_for_quittouch.png"),
                ),
                margin: EdgeInsets.all(20),
              ),
              Container(
                width: MediaQuery.of(context).size.width > 700
                    ? MediaQuery.of(context).size.width * 0.4
                    : MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.all(20),
                child: Text(
                  """The Wonmonae is a cyber general store supplying apps that seem like somewhat useless.

Sometimes, we all feel like buying something cute and useless aren't we? 

When it comes to the apptores, that sort of apps are few.

Because most app developers think that app should be useful, useless apps have no chance to be published.

"Then where we can download cute and useless apps?!"

Even for the sake of diversity of software, someone has to make cute and useless apps!  

So wonmonae creates that sort of apps. Download apps at wonmonae!
                      """,
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
