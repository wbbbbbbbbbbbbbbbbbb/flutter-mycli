// +----------------------------------------------------------------------
// | 语法糖
// | 本页面守则
// | 1. 本页面用于存放常用方法的快速封装，便于日常代码编辑
// | 2. 本页面不可存放和编写完整的一个类、完整的一个组件widget等，只能是相应的方法调用
// | 3. 不常用的和过于长的封装不能放在这里，请自行在需要用的页面引入后调用
// | 4. 实在要存放组件，可以放在lib/widgets，这是专门存放组件的地方
// +----------------------------------------------------------------------

part of 'global.dart';

/// 颜色转换
Color col(String c) {
  return Color(int.parse(c, radix: 16) | 0xFF000000);
}

/// px转dp适配函数.
double px(double px) {
  return ScreenUtil().setWidth(px);
}

/// px转dp适配函数 - 文字与1px时.
double sp(double sp) {
  return ScreenUtil().setSp(sp);
}

/// text文字不能为null处理
String txt(String text) {
  return text ?? "";
}

/// 状态管理
state(context, type) {
  if (States.stateOption.containsKey(type)) {
    return States.stateOption[type](context);
  } else {
    print("你的状态管理传错参了，辣鸡");
  }
}

// 状态管理组件
stateBuilder(context, type, builder) {
  if (States.stateBuilder.containsKey(type)) {
    return States.stateBuilder[type](context, builder);
  } else {
    print("你的状态管理传错参了，辣鸡");
  }
}

/// 网络请求get方法
Future get(url, {data}) {
  return Global.http.get(url, data: data);
}

/// 网络请求get方法
Future post(url, {data}) {
  return Global.http.post(url, data: data);
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

/// 跳转路由
/// context 上下文
/// route 路由路径
/// param 路由参数
/// clearStack 是否关闭全部页面跳转 包括根路由，慎用
/// replace 是否关闭当前页面跳转
goPage(context, String route, {Map<String, dynamic> param,replace = false, clearStack = false}) {
  String paramString = "";
  if (param != null && param.isNotEmpty) {
    paramString = "?";
    param.forEach((String key, dynamic value) {
      if (key != null && value != null) {
        paramString += "&$key=${Uri.encodeComponent(json.encode(value))}";
      }
    });
  }

  if (!Routes.routes.containsKey(route)) {
    showToast("路由错误");
    return null;
  }

  if (Routes.routes[route].containsKey("isLogin") &&
      Routes.routes[route]["isLogin"] &&
      Global.prefs.getString('token') == null) {
    showToast("请先登录");
    return null;
  }

  return Global.router.navigateTo(context, "$route$paramString", replace: replace, clearStack: clearStack);
}

/// 缓存
SharedPreferences cache = Global.prefs;
