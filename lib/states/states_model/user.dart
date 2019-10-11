import 'package:flutter/material.dart';

import '../../common/global/global.dart';

class UserState with ChangeNotifier {
  String token; // 用户登录凭证
  Map info; // 用户信息

  // 登录
  login(val) {
    token = val;
    cache.setString("token", val);
    notifyListeners();
  }

  // 注销
  logout() {
    token = null;
    cache.remove("token");
    notifyListeners();
  }

  userInfo() {
    // 假如你想拿用户信息时自动获取接口，你可以这样做👇
    // get("/memberInfo").then((res) {
    //   if (res['code'] == 0) {
    //     info = res['data'];
    //     notifyListeners();
    //   }
    // });
  }
}