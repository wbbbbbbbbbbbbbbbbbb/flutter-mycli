import 'package:provide/provide.dart'; // 状态管理

import './states_model/index.dart';

class States {
  // 获取状态值的配置
  static Map stateOption = {
    'global': (context) {
      return Provide.value<GlobalState>(context);
    },
    'user': (context) {
      return Provide.value<UserState>(context);
    },
  };

  // 构建状态builder的配置
  static Map stateBuilder = {
    'global': (context, builder) {
      return Provide<GlobalState>(
        builder: (context, child, val) {
          return builder(val);
        },
      );
    },
    'user': (context, builder) {
      return Provide<UserState>(
        builder: (context, child, val) {
          return builder(val);
        },
      );
    },
  };

  // 初始化方法 provideAll
  static init() {
    return Providers() 
      ..provide(Provider<GlobalState>.value(GlobalState()))
      ..provide(Provider<UserState>.value(UserState()));
  }
}