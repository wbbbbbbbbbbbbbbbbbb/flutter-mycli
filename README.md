# Flutter项目构建模板
模板拉到本地后第一时间请 `flutter packages get` 安装环境

以下内容都留有github网址或者官方文档，不懂先查文档.

## 目录结构 ./lib篇
| 文件夹     | 作用                                                       |
| --------   | :-------------------------------------------------------  |
| common     | 一些工具类，如通用方法类、网络接口类、保存全局变量的静态类等   |
| http       | http接口通讯                                              |
| i10n       | 多语言相关的类都在此目录下                                  |
| page       | 项目的页面存放地                                           |
| models     | Json文件对应的Dart Model类会在此目录下(现在发现这东西没鬼用=-= 已删除)(现在发现这东西是有鬼用的，所以重新加了回来，真香)|
| states     | 保存APP中需要跨组件共享的状态类                             |
| routes     | 存放所有路由页面类                                         |
| widgets    | APP内封装的一些Widget组件都在该目录下                       |

各自的用法以及注意事项放在了相应的目录下，请自行查阅

本项目文档的连接均隐藏在句子中（你可以当成a标签），直接点击即可跳转页面

## 代码规范

```
import 'package:younengapp/component/package/wxpay.dart';

class Test extends StatefulWidget {
  // 构造函数必须排在最前，若有赋值的参数，写在构造函数后  
  Test({Key key}) : super(key: key);

  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  // 定义变量的优先度仅次于构造函数，放第二前 
  // 并且！所有变量声明时就必须规定数据类型！
  // 凡是出现这种报错 ↓
  // type 'List<dynamic>' is not a subtype of type 'List<String>'
  // 都是这个问题，请自行解决
  String text = 'hah..';
  // 需要实例化的类先提前实例化并赋值给变量，
  // 千万不要多次实例化，
  // 以免造成性能下降
  // 当然，静态方法和静态函数除外
  final wx = WxPay();

  // 生命周期方法等放第三前，
  // 其中super.initState()等调用父类构造函数，
  // 放函数最前面
  @override
  void initState() {
    super.initState();
    // 写点什么...
  }
  // super中有个例外，就是dispose中先写自身逻辑，再调用super
  @override
  void dispose() {
    // 写点什么...
    super.dispose();
  }

  // build方法放在第四前，
  // 书写时，所有的最后一个参数必须加上“,”
  // 以便格式化代码时不变形
  @override
  Widget build(BuildContext context) {
    // 写样式时，样式的位置要比child前，以便容易查看和寻找样式
    return Container(
      width: 100.0,
      child: _bulildText(),
    );
  }

  // 多用函数或类(最好)来封装代码，使代码整洁易读，逻辑清晰
  // 私有的函数，变量，类 前要加上 _ 下划线，防止代码污染
  // 自定义的封装函数以及类，要放在build或者主类后
  Widget _bulildText() {
    return Text(
      text,
      style: TextStyle(
        color: Colors.red,
      ),
    );
  }
}
```

## 语法糖使用方法（需要引入global）
> 本项目封装了一些基本的方法作为语法糖，能解决大部分日常的编码需求。

> 如果你想添加一些属于你自己的方法，可以到./lib/common/global/global.sugar.dart中瞧瞧

### col
col("606060") 相当于前端开发中的#606060 参数必须是字符串
### px
px(15) 相当于前端开发中的 width: 15px 参数必须是int或double 
### sp
sp(15) 相当于前端开发中的 fontSize: 15px 参数必须是int或double 当开启了 根据系统字体进行缩放 时启用，不开启时与px()方法效果一致
### txt
txt("我是你爸爸") Text()类中使用，用于处理Text类参数不能为null的情况(比如你的页面打开时红一下的情况)
### state
state(context, 'global').test 下文 状态管理使用方法 有说明
### stateBuilder
stateBuilder(context, 'global', (global) => Text('${global.test}')) 下文 状态管理使用方法 有说明
### get
get("userinfo", {id: id}).then(res => print(res)) 网络请求get Future型封装 下文有说明
### post
post("userinfo", {id: id}).then(res => print(res)) 网络请求post Future型封装 下文有说明
### showToast
showToast("我是你爸爸") 显示toast
### showNotif
showNotif(Text('我是你爸爸')) 显示通知型toast
### w100
w100(context) 屏幕总宽度，也就是width: 100%;
### h100
h100(context) 屏幕总高度，也就是height: 100%;
### flex1 
flex1 宽或者高的剩余空间，也就是无限大
### isIos
isIos 判断是否ios
### goPage
goPage(context, "/test", param: {id: 1}) 路由跳转 下文有说明
### cache
cache 缓存

## 缓存使用方法（需要引入global）
### 增

```
import 'package:flutter_app/common/global/global.dart';

cache.setString(key, value)
cache.setBool(key, value)
cache.setDouble(key, value)
cache.setInt(key, value)
cache.setStringList(key, value)
```

### 删

```
import 'package:flutter_app/common/global/global.dart';

cache.remove(key); //删除指定键
cache.clear(); //清空键值对
```

### 改

> 改和增是一样的，只需要再执行一次setXXX()方法即可覆盖之前的数据。

### 查

```
import 'package:flutter_app/common/global/global.dart';

String test = cache.getString(key);
bool test = cache.getBool(key);
double test = cache.getDouble(key);
int test = cache.getInt(key);
List test = cache.getStringList(key);
```

## 状态管理使用方法（需要引入global）
> 与vuex高度相似，会vuex就会这个用法

### 配置状态
lib/states/states_model 中修改或新增状态模块 新增的模块统一命名为 模块名+State

若新增模块，则必须在 lib/states/states_model/index.dart 中增加 新增模块的出口, 如：
```
export 'user.dart';
```
然后，在 lib/states/states.dart 中配置 stateOption、stateBuilder和init() 如：
```
配置中的 GlobalState 为你定义的模块类名，可自行替换

// 获取状态值的配置 stateOption
static Map stateOption = {
  'global': (context) {
    return Provide.value<GlobalState>(context);
  },
};

// 构建状态builder的配置 stateBuilder
static Map stateBuilder = {
  'global': (context, builder) {
    return Provide<GlobalState>(
      builder: (context, child, val) {
        return builder(val);
      },
    );
  },
};

// 初始化方法 init
static init() {
  return Providers() 
    ..provide(Provider<GlobalState>.value(GlobalState()));
}
```

拥有模块后，修改或新增状态，如：
> 必须规定状态类型，不一定需要赋值默认值
```
int test = 0;
```

修改或新增改变状态的方法，如：
> 函数末尾必须调用 notifyListeners(); 来触发widget的build
```
testState() {
  test++;
  notifyListeners();
}
```
<!-- 路径lib/states/..中创建模块文件，如test.dart，
将同目录下的global.dart的内容复制到自己创建的文件中，修改为自己要使用的 状态变量 和 改变状态的方法，编写方法时记得调用 notifyListeners(); 触发组件build，然后在同目录下的index.dart新增出口 export 'test.dart'; 照着抄就行。 -->

### 使用状态
如果你需要在widget中显示状态的值，如用户头像等，需要立即更新build的值，请使用stateBuilder()方法，例子：
```
// 参数一：上下文
// 参数二：模块名称
// 参数三：回调函数
Container(
    child: stateBuilder(context, 'global', (global) {
        return Text('${global.test}');
    }),
),
```

如果你不需要在widget中显示，只是单纯的获取值，如 token ，你可以做样做
```
int test = state(context, 'global').test;
```

如果你需要改变状态的值，你可以这样
```
state(context, 'global').testState();
```
> 命名统一：为了规范代码，改变状态的函数，命名统一格式为 状态名+State 如： testState()

## 路由使用方法（需要引入global）
### 路由的配置
lib/routes/route_handlers.dart 中新增处理路由处理方法

lib/routes/routes.dart 中定义相应的路径，初始化相应的路由

router.define 参数与用法
```
参数一：路由路径或名称
参数二：路由处理方法
参数三（选填）：路由跳转动画
define(String routePath, {@required Handler handler, TransitionType transitionType})

路由跳转动画除了日常的安卓和iOS外（不填可以根据系统默认）还有一些比较好玩的参数
enum TransitionType {
  native,
  nativeModal,
  inFromLeft,
  inFromRight,
  inFromBottom,
  fadeIn,
  custom, // if using custom then you must also provide a transition
  material,
  materialFullScreenDialog,
  cupertino,
  cupertinoFullScreenDialog,
}
```
### 路由的使用
```
参数一：上下文
参数二：你定义的路由名
参数三：路由参数
构造函数：goPage(context, String route, {Map<String,dynamic> param})
使用示例：goPage(context, "/test", param: {id: 1})
```

## http使用方法（需要引入global）
### http的配置
#### 公共域名的配置（必须）
lib/common/global/global.config.dart 中的 

httpUrls项添加不同环境下的域名

httpEnv项选择当前环境
#### 模块
lib/http/apis 中修改或者新增接口模块
> 新增的模块类命名规则为 模块名+Apis

接口模块中，定义get的写法为
```
static productList() async {
  return await Global.http.dioGet("接口链接");
}
```
定义post的写法为
```
static productList() async {
  return await Global.http.dioPost("接口链接");
}
```
值得注意的是，需要维护一套良好的注释系统，以便以后接手项目的人容易理解，以及让项目更加规范

注释的写法：
```
/// 接口的解释 接口类型
/// url 接口的地址
/// param 
///   接口参数一名 接口参数一的解释
static productInfo(data) async {
  return await Global.http.dioGet("productInfo", data: data);
}
```
例子：
```
/// 商品详情 get
/// url productInfo
/// param 
///   id 商品id
static productInfo(data) async {
  return await Global.http.dioGet("productInfo", data: data);
}
```

## 本cli使用的文档或者借鉴的文章
[Flutter中文网](https://flutterchina.club/)

[Flutter实战](https://book.flutterchina.club/)

[Flutter官方中文社区](https://flutter.cn/)

[Toast](https://juejin.im/post/5c6a47bde51d457f093b217e)

[Toast git](https://github.com/boyan01/overlay_support)

## TODO
1. 本cli为1.0.0版本，如果有机会，会做2.0.0 用mvc的框架思想做（有生之年系列...）