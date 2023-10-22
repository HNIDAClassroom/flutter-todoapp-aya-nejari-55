import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/widgets/new_task.dart';
import 'package:todolist_app/widgets/tasks_list_dart.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() {
    return _TasksState();
  }
}

class _TasksState extends State<Tasks> {
  final List<Task> _registeredTasks = [
  Task(
    title: 'Apprendre Flutter',
    description: 'Suivre le cours pour apprendre de nouvelles compétences',
    date: DateTime.now(),
    category: Category.work,
  ),
  Task(
    title: 'Faire les courses',
    description: 'Acheter des provisions pour la semaine',
    date: DateTime.now().subtract(const Duration(days: 1)),
    category: Category.shopping,
  ),
  Task(
    title: 'Rediger un CR',
    description: 'Le CR détaillé',
    date: DateTime.now().subtract(const Duration(days: 2)),
    category: Category.personal,
  ),
  // Add more tasks with descriptions as needed
];

  void _openAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NewTask(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My App'),),
        actions: [
          IconButton(
            onPressed:() {}, icon: Ink(
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 219, 108, 169),),
              child: const Padding(
                padding: EdgeInsets.all(8),
               child: Icon(Icons.add)))),
          


        ],
      ),

      body:TasksList(tasks: _registeredTasks)
    );
  }
}
