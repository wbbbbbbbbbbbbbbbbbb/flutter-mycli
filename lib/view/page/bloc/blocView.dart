import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class BlocView extends StatelessWidget {
  const BlocView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (BuildContext context) => CounterBloc(),
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("BloC 教程"),
            ),
            body: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<CounterBloc>(context).add(CounterEvent.increment);
                },
                child: Text("+"),
              ),
              body: Center(
                child: BlocBuilder<CounterBloc, int>(builder: (context, state) {
                  return Text("$state");
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
