import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ListX with ChangeNotifier {
  // int _count = 0;
  /// my state

  List<String> _todos = [];

  List<String> get todos => _todos;

  void addTask(String task) {
    _todos.add(task);
    notifyListeners();
  }
}
