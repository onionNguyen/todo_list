import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/src/features/todo/models/todo.dart';

class TodoScreenController extends GetxController {
  final RxList<Todo> todoList = <Todo>[].obs;
  final _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int value) => _selectedIndex.value = value;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final RxBool isCompleted = false.obs;
  final _todos = <Todo>[].obs;
  List<Todo> get todos => _todos.toList();
  RxInt tabIndex = 0.obs;

  // Create task function
  void createTask(String task, String description) {
    final newTodo = Todo(
      title: task,
      id: UniqueKey().toString(),
      description: description,
    );
    todoList.add(newTodo);
    titleController.clear();
    descriptionController.clear();
  }

  void onCheckBoxChanged(bool? value, int index) {
    final todo = todoList[index];
    final updatedTodo = todo.copyWith(isCompleted: value ?? false);
    todoList[index] = updatedTodo;
  }

  void onDeletePressed(int index) {
    todoList.removeAt(index);
  }

  List<Todo> getTodoList(bool isCompleted) {
    return todoList.where((todo) => todo.isCompleted == isCompleted).toList();
  }

  void createTimer(int index) {
    final todo = todoList[index];
    final updatedTodo = todo.copyWith(date: DateTime.now());
    todoList[index] = updatedTodo;
  }
}
