import 'package:flutter/material.dart';
import 'package:flutter_app/route/index.dart';

class RouteView extends StatelessWidget {
  const RouteView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("路由 教程"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () => Router.pop(),
              child: Text("返回路由 Router.pop()"),
            ),
            RaisedButton(
              onPressed: () => Router.to("/route"),
              child: Text("跳转路由 Router.to('/route')"),
            ),
            RaisedButton(
              onPressed: () => Router.replaceTo("/route"),
              child: Text("替换路由 Router.replaceTo('/route')"),
            ),
            RaisedButton(
              onPressed: () => Router.clearStackTo("/"),
              child: Text("清栈跳转路由 Router.clearStackTo('/')"),
            ),
            RaisedButton(
              onPressed: () => Router.clearStackTo("/bloc", action: ModalRoute.withName('/')),
              child: Text("清栈跳转路由并保留首页 Router.clearStackTo('/', action: ModalRoute.withName('/'))"),
            ),
            RaisedButton(
              onPressed: () => Router.popUntil(),
              child: Text("清栈路由 Router.popUntil()"),
            ),
          ],
        ),
      ),
    );
  }
}
