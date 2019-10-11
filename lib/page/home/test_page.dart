import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test(
    this.url,
    this.title, {
    Key key,
  }) : super(key: key);

  final url;
  final title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter demo"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(url.toString()),
            Text(url[0]),
            Text(title),
            RaisedButton(
              onPressed: () async {
                Navigator.pop(context, "haha");
              },
              child: Text("返回"),
            ),
          ],
        ),
      ),
    );
  }
}
