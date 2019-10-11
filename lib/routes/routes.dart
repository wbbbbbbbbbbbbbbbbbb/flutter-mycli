import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../page/home/home_page.dart';
import '../page/home/test_page.dart';
import '../page/test/test2_page.dart';

class Routes {
  /// 路由配置
  /// 配置项：
  ///   widget 路由生产函数，包含传参和不传参两种，参数需要手动处理参数
  ///   isLogin 是否需要登录才能进的路由
  static Map routes = {
    // 导航页
    "/": {
      "widget": (params) => Home(),
    },
    
    // 导航页
    "/test": {
      "widget": (params) {
        var url = deJson(params["url"]?.first);
        var title = deJson(params["title"]?.first);
        return Test(url, title);
      },
      "isLogin": true,
    },

    // 导航页
    "/test2": {
      "widget": (params) => Test2(),
    },
  };

  /// 路由初始化
  static void configureRoutes(Router router) {
    // 空路由跳去哪里
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print("没有这个路由!");
        return null;
      },
    );

    routes.forEach((key,value) {
      router.define(key, handler: handlerBuild(key));
    });
  }

  /// 构建路由处理函数 - 路由拦截
  static Handler handlerBuild(String handlerName) {
    return Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        var route = routes[handlerName];
        return route["widget"](params);
      },
    );
  }
}

// 解开json
deJson(val) {
  return val != null ? json.decode(val) : null;
}