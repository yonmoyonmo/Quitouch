import 'package:flutter/cupertino.dart';

class QuitouchHome extends StatefulWidget {
  const QuitouchHome({Key? key}) : super(key: key);

  @override
  _QuitouchHomeState createState() => _QuitouchHomeState();
}

class _QuitouchHomeState extends State<QuitouchHome> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Quitouch"),
          CupertinoButton(
            child: Text("category CRUD"),
            onPressed: () => Navigator.pushNamed(context, '/edit'),
          )
        ],
      ),
    );
  }
}
