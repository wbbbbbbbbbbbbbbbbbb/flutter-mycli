# Json转Dart Model类 用法


## 前提（本项目已经做好，无需再次配置）
1. 项目根目录创建jsons文件夹，以用于存放待转的json文件
2. ./lib 目录下创建models文件夹，以用于存放转换后的Dart Model类
3. 为项目引入[json_model库](https://github.com/flutterchina/json_model/blob/master/README-ZH.md) 并在pubspec.yaml中配置相应的dev_dependencies

## 使用
项目中使用命令行 `flutter packages pub run json_model`

## 踩坑和提示
1. [The binary program does not contain ‘main’.](https://www.dart-china.org/t/topic/1176) 的原因可能是因为没有保存文件，转换前所有文件都得保存
2. type 'List<dynamic>' is not a subtype of type 'Map<String, dynamic>' 貌似是他不支持最外层为数组的结构，哪你完全可以最外层用一层对象包裹一层数组来实现你的结构