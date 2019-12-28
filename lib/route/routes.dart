import 'package:flutter/material.dart';
import 'package:flutter_app/view/page/bloc/blocView.dart';
import 'package:flutter_app/view/page/route/routeView.dart';
import '../common/global/global.sugar.dart';

class Routes {
  /// 路由拦截
  static Route onGenerateRoute(RouteSettings routeSettings) {
    /// 路由名称
    String url = routeSettings.name;

    /// 路由参数
    Object args = routeSettings.arguments ?? const {};

    int i = configs.indexWhere((item) => item['url'] == url);
    if (i < 0) {
      showToast('找不到路由');
      return null;
    }
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return configs[i]['page'](args);
      },
      settings: routeSettings,
    );
  }

  /// 路由配置
  static List<Map<String, dynamic>> configs = [
    {
      'url': '/bloc',
      'page': (args) {
        return BlocView();
      }
    },
    {
      'url': '/route',
      'page': (args) {
        return RouteView();
      }
    },
    // {
    //   'url': '/test_router',
    //   'page': (args) {
    //     int id = args['id'];
    //     return TestRouterPage(
    //       pageCount: id
    //     );
    //   }
    // },
  ];
}
