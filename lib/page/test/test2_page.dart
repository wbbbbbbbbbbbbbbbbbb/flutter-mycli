import 'package:flutter/material.dart';

class Test2 extends StatelessWidget {
  const Test2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter demo"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text("haha"),
          ],
        ),
      ),
    );
  }
}
