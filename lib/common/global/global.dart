// +----------------------------------------------------------------------
// | 全局配置
// | global文件夹说明：
// |    本文件用于项目构建时的初始化
// |    以及项目时用到的全局函数，类，变量的存放和初始化
// |    为了性能着想，请不要将耗性能，运行时间长，以及大量代码放到 [global文件夹] 中来
// |    同时，本文件夹 [global文件夹] 不能有任何报错，以及不确定会不会报错的代码(一错就炸你信不信=-=)
// +----------------------------------------------------------------------

// flutter and dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// package
import 'package:shared_preferences/shared_preferences.dart'; // 数据持久化
import 'package:provide/provide.dart'; // 状态管理
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 屏幕适配
import 'package:overlay_support/overlay_support.dart'; // toast
import 'package:fluro/fluro.dart'; // 路由

// local
import '../../states/states.dart';
import '../../http/http.dart';
import '../../routes/routes.dart';

// part
part 'global.sugar.dart';
part 'global.config.dart';

class Global {
  static SharedPreferences prefs; // 缓存
  static Providers providers; // 状态
  static Http http; // 网络请求
  static Router router; // 路由

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    prefs = await SharedPreferences.getInstance(); // 初始化缓存

    providers = States.init(); // 初始化状态管理
      
    http = Http(); // 网络请求初始化

    final route = Router(); // 路由初始化
    Routes.configureRoutes(route);
    router = route;
  }
}
