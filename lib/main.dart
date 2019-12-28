// 原生库
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/route/index.dart';

// 外部库
import 'package:provide/provide.dart'; // 状态管理
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 屏幕适配
import 'package:overlay_support/overlay_support.dart'; // toast
import 'package:shared_preferences/shared_preferences.dart';

// 本地库
import 'common/global/global.dart';
import 'common/global/global.config.dart';
import 'common/global/global.sugar.dart';
import 'route/routes.dart';

void main() {
  return runApp(
    MyApp(),
  );
  Global.init().then((e) {
    // 屏幕方向
    if (Config.screenDirection == "column") {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } else if (Config.screenDirection == "row") {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }

    // statusBar设置为透明，去除半透明遮罩
    if (Config.immersive) {
      SystemChrome.setSystemUIOverlayStyle(Config.statusBarStyle);
    }

    // 隐藏状态栏或者底部虚拟键
    if (Config.systemUiOverlay == "top") {
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    } else if (Config.systemUiOverlay == "bottom") {
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    }

    return runApp(
      ProviderNode(
        child: MyApp(),
        providers: Global.providers,
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: Router.navigatorKey,
        onGenerateRoute: Routes.onGenerateRoute,
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          platform: Platform.isIOS ? TargetPlatform.iOS : TargetPlatform.android,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // 异步加载缓存
  Future lodingPrefs() async {
    // Global.prefs = await SharedPreferences.getInstance(); // 初始化缓存
    // return Global.prefs;
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    // 设计稿的尺寸初始化为iphone6
    ScreenUtil.instance = ScreenUtil(
      width: 750,
      height: 1334,
    )..init(context);
    return FutureBuilder(
      future: lodingPrefs(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: Text("测试"),
        ),
          appBar: AppBar(
            title: Text("趣果 - FlutterCli 使用教程"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("$count"),
                RaisedButton(
                  onPressed: () => Router.to("/route"),
                  child: Text("路由 的 例子"),
                ),
                RaisedButton(
                  onPressed: () => Router.to("/bloc"),
                  child: Text("bloc 的 例子"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
