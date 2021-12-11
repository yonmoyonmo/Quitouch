import 'package:flutter/material.dart';
import 'package:quitouch/view/component/textstyles.dart';

class SelectedCateContainer extends StatelessWidget {
  SelectedCateContainer(this.contentText);
  final String contentText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 120,
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
