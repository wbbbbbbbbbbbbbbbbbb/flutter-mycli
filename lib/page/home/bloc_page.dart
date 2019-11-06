import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/CountBLoC.dart';

class BloCPage extends StatefulWidget {
  BloCPage({Key key}) : super(key: key);

  @override
  _BloCPageState createState() => _BloCPageState();
}

class _BloCPageState extends State<BloCPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<int>(
          stream: bLoC.stream,
          initialData: bLoC.value, // 初始化数据（默认数据）
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Center(
              child: Text(snapshot.data.toString()),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bLoC.increment(),
        child: Icon(Icons.add),
      ),
    );
  }
}
