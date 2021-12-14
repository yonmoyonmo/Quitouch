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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DrawerHeader(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/quitachi2.png"),
                  ),
                  color: Colors.transparent,
                ),
                child: Text("MENU", style: TextStyles.textStyle08white),
              ),
            ),
            //menus
            ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Image.asset("images/quitouch_appIcon.png"),
              title: Text(
                "About Quitouch",
                style: TextStyles.textStyle02white,
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Image.asset("images/logo_for_quittouch.png"),
              title: Text(
                "About wonmonae",
                style: TextStyles.textStyle02white,
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Icon(
                Icons.share,
                color: Color.fromRGBO(142, 255, 129, 1),
                size: 50,
              ),
              title: Text(
                "Sharing Quitouch",
                style: TextStyles.textStyle02white,
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Icon(
                Icons.money_off,
                color: Color.fromRGBO(142, 255, 129, 1),
                size: 50,
              ),
              title: Text(
                "Removing ads",
                style: TextStyles.textStyle02white,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
