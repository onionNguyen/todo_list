// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:todo_list/src/features/todo/models/todo.dart';

class TodoWidgets extends StatelessWidget {
  const TodoWidgets({
    Key? key,
    required this.todo,
    required this.onChanged,
    required this.onDeleted,
  }) : super(key: key);
  final Todo todo;
  final ValueChanged? onChanged;
  final VoidCallback? onDeleted;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      subtitle: Text(
        todo.description,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: onChanged,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDeleted,
      ),
    );
  }
}
