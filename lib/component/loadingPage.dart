import 'package:flutter/material.dart';

class loadingPage with ChangeNotifier {
  bool _value = false;

  bool get value => _value;

  set value(bool newValue) {
    _value = newValue;
    notifyListeners();
  }
}