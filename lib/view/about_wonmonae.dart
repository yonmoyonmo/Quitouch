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
                  """The Wonmonae is a cyber general store supplying apps that seem like useless.
                      Sometimes, we all feel like buying something cute and useless aren't we? 
                            But buisnesses wouldn't want to make things like that because of profit. 
                            But me, I want to make that sort of things. It's almost a sense of duty.
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
