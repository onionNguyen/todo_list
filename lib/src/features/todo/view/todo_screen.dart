import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/src/features/todo/view/todo_screen_controller.dart';
import 'package:todo_list/src/ui/widgets/generic_text_field.dart';
import 'package:todo_list/src/ui/widgets/todo_widgets.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late final TodoScreenController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(TodoScreenController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('Add Task'),
                actions: [
                  IconButton(
                    onPressed: () {
                      controller.createTask(controller.titleController.text,
                          controller.descriptionController.text);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),
              body: Column(
                children: [
                  GenericTextField(
                      labelText: 'Task',
                      controller: controller.titleController),
                  const SizedBox(
                    height: 16,
                  ),
                  GenericTextField(
                    labelText: 'Description',
                    controller: controller.descriptionController,
                  ),
                ],
              ),
            ),
            context: context,
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          controller.isCompleted.value = index == 1;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Completed',
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.calendar_month),
          ),
        ],
        title: const Text('Todo List'),
      ),
      body: Obx(() {
        final todos = controller.getTodoList(controller.isCompleted.value);
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return TodoWidgets(
                todo: todos[index],
                onChanged: (value) {
                  controller.onCheckBoxChanged(value, index);
                },
                onDeleted: () {
                  controller.onDeletePressed(index);
                });
          },
        );
      }),
    );
  }
}
