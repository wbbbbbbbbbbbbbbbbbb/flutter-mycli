// +----------------------------------------------------------------------
// | 语法糖
// | 本页面守则
// | 1. 本页面用于存放常用方法的快速封装，便于日常代码编辑
// | 2. 本页面不可存放和编写完整的一个类、完整的一个组件widget等，只能是相应的方法调用
// | 3. 不常用的和过于长的封装不能放在这里，请自行在需要用的页面引入后调用
// | 4. 实在要存放组件，可以放在lib/widgets，这是专门存放组件的地方
// +----------------------------------------------------------------------

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import './global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 颜色转换
Color col(String c) {
  return Color(int.parse(c, radix: 16) | 0xFF000000);
}

/// px转dp适配函数.
double px(double px) {
  return ScreenUtil().setWidth(px);
}

/// toast 土司弹窗
showToast(String message, {Duration duration = Toast.LENGTH_SHORT}) {
  toast(message, duration: duration);
}

/// tab toast 通知型土司弹窗
showNotif(
  Widget content, {
  Widget leading,
  Widget subtitle,
  Widget trailing,
  EdgeInsetsGeometry contentPadding,
  Color background,
  Color foreground,
  double elevation = 16,
  Key key,
  bool autoDismiss = true,
  bool slideDismiss = false,
}) {
  showSimpleNotification(
    content,
    leading: leading,
    subtitle: subtitle,
    trailing: trailing,
    contentPadding: contentPadding,
    background: background,
    foreground: foreground,
    elevation: elevation,
    autoDismiss: autoDismiss,
    slideDismiss: slideDismiss,
  );
}

// 构建底部弹窗toast
snackBuider(builder) {
  return Builder(builder: (BuildContext context) {
    return builder(Scaffold.of(context).showSnackBar);
  });
}

/// 宽度相对于屏幕100%
w100(context) {
  return MediaQuery.of(context).size.width;
}

/// 高度相对于屏幕100%
h100(context) {
  return MediaQuery.of(context).size.height;
}

/// 宽度或者高度获取剩余空间
double flex1 = double.infinity;

/// 判断是否iOS
bool isIos = Platform.isIOS;

/// 缓存
SharedPreferences cache = Global.prefs;

// 解开json
deJson(val) {
  return val != null ? json.decode(val) : null;
}

// 转换json
toJson(val) {
  return val != null ? json.encode(val) : null;
}