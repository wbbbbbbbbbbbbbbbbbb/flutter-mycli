import 'package:flutter/material.dart';

import '../../http/apis/api.dart';
import '../../common/global/global.dart';
import '../../widgets/index.dart';
import '../../http/myio.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            stateBuilder(context, 'user', (user) {
              return Text('token: ${user.token}');
            }),
            RaisedButton(
              onPressed: () async {
                state(context, "user").login(
                    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE5NDc0IiwiZXhwIjoxNTcwNjg4MzY4fQ.fL-Rkw4QcY7Jn3EvfUdY9JV1LGAD6CDqIdYCYvGNHxg");
              },
              child: Text(
                "登录",
                style: TextStyle(
                  color: col("ffffff"),
                  fontSize: sp(50),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () async {
                state(context, "user").logout();
              },
              child: Text("注销"),
            ),
            stateBuilder(context, 'global', (global) {
              return Text('${global.test}');
            }),
            RaisedButton(
              onPressed: () async {
                YYResultModel haha = await MyIo.requestGet('productList');
                print(haha.code);
                print(haha.success);
                print("==============");
                // state(context, 'global').testState();
                // var test = await ProductApis.productList();
                // print(test);
                // if (Config.debug) {
                //   showToast("哈哈哈，我是你爸爸吖！");
                //   showNotif(
                //     Text("哼，我是你爷爷"),
                //     background: Colors.green,
                //   );
                // }
              },
              child: Text("点我"),
            ),
            RaisedButton(
              onPressed: () async {
                var url = ["我是你爷爷", "我是你奶奶"];
                goPage(context, "/test", param: {
                  "url": url,
                  "title": "title321",
                })?.then((res) {
                  print(res);
                });
              },
              child: Text("跳转"),
            ),
            snackBuider((callback) {
              return RaisedButton(
                onPressed: () {
                  callback(SnackBar(
                    content: Text('哈哈'),
                    action: SnackBarAction(
                      label: '撤消',
                      onPressed: () => {},
                    ),
                  ));
                },
                child: Text('显示SnackBar'),
              );
            }),
            RaisedButton(
              onPressed: () async {
                showDialog<Null>(
                  context: context, //BuildContext对象
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return LoadingDialog(
                      text: '正在转菊花...',
                    );
                  },
                );
              },
              child: Text("弹窗"),
            ),
          ],
        ),
      ),
    );
  }
}
