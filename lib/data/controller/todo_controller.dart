import 'package:flutter/material.dart';
import 'package:flutter_todo/data/model/task_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final todoControllerProvider = ChangeNotifierProvider<ToDoNotifier>((ref) {
  return ToDoNotifier(ref);
});

class ToDoNotifier extends ChangeNotifier {
  final Ref ref;

  ToDoNotifier(this.ref);

  final List<Task> tasks = [];

  addTodo(String title, DateTime date) {
    tasks.add(Task(
      title: title,
      date: date,
    ));
    notifyListeners();
  }

  toggleTask(Task task) {
    task.isComplete = !task.isComplete;
    notifyListeners();
  }

  deleteTodo(String title, DateTime date) {
    tasks.removeWhere((tasks) => tasks.title == title && tasks.date == date);
    notifyListeners();
  }
}
