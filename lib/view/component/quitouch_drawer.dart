import 'package:flutter/material.dart';
import 'package:quitouch/view/component/textstyles.dart';

class QuitouchDrawer extends StatelessWidget {
  const QuitouchDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            DrawerHeader(
              child: Container(
                  height: 142,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "images/wonmonaeLogo.png",
                  )),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            Text(
              "01010101",
              style: TextStyles.textStyle01white,
            ),
            Text(
              "02010101",
              style: TextStyles.textStyle01white,
            ),
            Text(
              "03010101",
              style: TextStyles.textStyle01white,
            ),
          ],
        ),
      ),
    );
  }
}
