import 'package:flutter/cupertino.dart';

class CategoryEdit extends StatefulWidget {
  const CategoryEdit({Key? key}) : super(key: key);

  @override
  _CategoryEditState createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Text("category edit"),
        ],
      ),
    );
  }
}
