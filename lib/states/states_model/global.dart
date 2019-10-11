import 'package:flutter/material.dart';

class GlobalState with ChangeNotifier {
  int test = 0;

  testState() {
    test++;
    notifyListeners();
  }
}