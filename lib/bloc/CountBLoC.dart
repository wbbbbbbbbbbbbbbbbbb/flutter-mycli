import 'dart:async';

class CountBLoC {
  int _count;
  StreamController<int> _countController;

  CountBLoC() {
    _count = 0;
    _countController = StreamController<int>();
  }

  // 出口
  Stream<int> get stream => _countController.stream;

  // 默认值
  int get value => _count;

  increment() {
    // 入口
    _countController.sink.add(++_count);
  }

  dispose() {
    _countController.close();
  }
}

CountBLoC bLoC = CountBLoC();