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
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
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
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconRow(
                            title: 'Set Time:',
                            iconButton: IconButton(
                              onPressed: () {
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());
                              },
                              icon: const Icon(Icons.timer,
                                  size: 40,
                                  color: Color.fromARGB(255, 197, 95, 129)),
                            ),
                          ),
                          IconRow(
                              title: 'Set Date:',
                              iconButton: IconButton(
                                onPressed: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 90)));
                                },
                                icon: const Icon(
                                  Icons.calendar_today,
                                  size: 40,
                                  color: Color.fromARGB(255, 197, 95, 129),
                                ),
                              ))
                        ])
                  ],
                ),
              ),
            ),
            context: context,
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.tabIndex.value,
            onTap: (index) {
              controller.tabIndex.value = index;
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
          )),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2021),
                lastDate: DateTime(2025),
              );
            },
            icon: const Icon(
              Icons.calendar_month,
              size: 30,
              color: Color.fromARGB(255, 197, 95, 129),
            ),
          ),
        ],
        title: const Text('Todo List',
            style: TextStyle(
                fontSize: 30, color: Color.fromARGB(255, 197, 95, 129))),
      ),
      body: Obx(() {
        final todos = controller.getTodoList(controller.isCompleted.value);
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return Dismissible(
              onDismissed: (direction) {
                controller.onDeletePressed(index);
              },
              background: Container(
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              key: ValueKey(todos[index].id),
              child: TodoWidgets(
                  key: ValueKey(todos[index].id),
                  todo: todos[index],
                  onChanged: (value) {
                    controller.onCheckBoxChanged(value, index);
                  },
                  onDeleted: () {
                    controller.onDeletePressed(index);
                  }),
            );
          },
        );
      }),
    );
  }
}

class IconRow extends StatelessWidget {
  const IconRow({super.key, required this.title, required this.iconButton});

  final String title;
  final Widget iconButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const SizedBox(
          width: 16,
        ),
        iconButton
      ],
    );
  }
}
