// 原生库
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 外部库
import 'package:provide/provide.dart'; // 状态管理
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 屏幕适配
import 'package:overlay_support/overlay_support.dart'; // toast

// 本地库
import './common/global/global.dart';
import './page/home/home_page.dart';
import './page/home/bloc_page.dart';

void main() {
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
        debugShowCheckedModeBanner: true,
        onGenerateRoute: Global.router.generator,
        theme: ThemeData(primarySwatch: Colors.yellow),
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
    String token = cache.getString("token");
    state(context, "user").login(token);
    
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // 设计稿的尺寸初始化为iphone6
    ScreenUtil.instance = ScreenUtil(
      width: 750,
      height: 1334,
      allowFontScaling: Config.allowFontScaling,
    )..init(context);
    return BloCPage();
  }
}
