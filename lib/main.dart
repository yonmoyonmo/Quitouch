import 'package:flutter/cupertino.dart';
import 'package:quitouch/view/category_edit.dart';
import 'package:quitouch/view/quitouch_home.dart';

void main() {
  runApp(const Quitouch());
}

class Quitouch extends StatelessWidget {
  const Quitouch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      routes: {
        '/': (_) => QuitouchHome(),
        '/edit': (_) => CategoryEdit(),
      },
    );
  }
}
