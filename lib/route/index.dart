import 'package:flutter/material.dart';

/// 路由操作
/// https://juejin.im/post/5be2d6546fb9a049be5cf6d5
class Router {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// 返回路由 - pop
  static Future pop({Map param}) async {
    return navigatorKey.currentState.maybePop(param);
  }

  /// 跳转路由 - pushNamed
  static Future to(String route, {Map param}) async {
    return navigatorKey.currentState.pushNamed('$route', arguments: param);
  }

  /// 替换路由 - pushReplacement
  static Future replaceTo(String route, {Map param}) async {
    return navigatorKey.currentState.pushReplacementNamed('$route', arguments: param);
  }

  /// 清栈跳转路由 - pushNamedAndRemoveUntil
  static Future clearStackTo(
    String route, {
    Map param,
    Function action,
  }) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
      '$route',
      action ?? (Route router) => false,
      arguments: param,
    );
  }

  /// 清栈路由 - pushNamedAndRemoveUntil
  static popUntil({String route = "/"}) {
    return navigatorKey.currentState.popUntil(
      ModalRoute.withName('$route'),
    );
  }
}