import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class TodosListProvider with ChangeNotifier {
  final List<String> _todos = [];

  List<String> get todos => _todos;

  void addTask(String task) {
    _todos.add(task);
    notifyListeners();
  }

  void clearAll() {
    _todos.clear();
    notifyListeners();
  }
}
