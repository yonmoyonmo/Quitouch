import 'package:flutter/material.dart';

class QuitouchButton extends StatelessWidget {
  QuitouchButton(this.buttonText);
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 106,
      height: 50,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/done_button.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
