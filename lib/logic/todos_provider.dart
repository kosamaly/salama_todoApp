import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:salama_todoapp/data/models/todo.dart';

class TodosListProvider with ChangeNotifier {
  // State
  final List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  void addTask(String task) {
    _todos.add(
      Todo(task),
    );
    notifyListeners();
  }

  void clearAll() {
    _todos.clear();
    notifyListeners();
  }

  void removeSingleTask(String task) {
    _todos.removeWhere((element) => element.task == task);

    notifyListeners();
  }

  void updateTodoState(String task) {
    final foundTodo = _todos.firstWhere((element) => element.task == task);

    // Change state of the todo
    foundTodo.isDone = true;

    notifyListeners();
  }
}
