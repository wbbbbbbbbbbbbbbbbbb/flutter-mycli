import 'package:flutter/material.dart';
import 'package:flutter_app/route/index.dart';

class BlocView extends StatelessWidget {
  const BlocView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BloC 教程"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () => Router.to("/bloc"),
              child: Text("bloc 例子"),
            ),
            RaisedButton(
              onPressed: () => Router.clearStackTo("/"),
              child: Text("bloc 清栈"),
            ),
          ],
        ),
      ),
    );
  }
}
