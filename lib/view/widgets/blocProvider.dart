import 'package:flutter/widgets.dart';

///
/// 如何使用 BlocProvider
/// 
/// - 注入 BLoC
/// Widget build(BuildContext context){
///     return BlocProvider<MyBloc>{
///         bloc: myBloc,
///         child: ...
///     }
/// }
/// 
/// - 获取 BLoC
/// Widget build(BuildContext context){
///     MyBloc myBloc = BlocProvider.of<MyBloc>(context);
///     ...
/// }
/// 

Type _typeOf<T>() => T;

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }): super(key: key);

  final Widget child;
  final T bloc;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context){
    final type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider = 
            context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>>{
  @override
  void dispose(){
    widget.bloc?.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    return new _BlocProviderInherited<T>(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}