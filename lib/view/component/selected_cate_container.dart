import 'package:flutter/material.dart';
import 'package:quitouch/view/component/textstyles.dart';

class SelectedCateContainer extends StatelessWidget {
  SelectedCateContainer(this.contentText);
  final String contentText;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    print(screenWidth);
    return Container(
      width: screenWidth > 1000
          ? MediaQuery.of(context).size.width * 0.4
          : MediaQuery.of(context).size.width * 0.8,
      height: screenHeight > 1000 ? 150 : (screenWidth < 380 ? 100 : 120),
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Text(
        this.contentText,
        style: TextStyles.textStyle02white,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/selected_cate.png"), fit: BoxFit.fill),
      ),
    );
  }
}
