import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/widgets/task_item.dart';

class TasksList extends StatelessWidget {
  
  const TasksList({
    Key? key,
    required this.tasks,
    required void Function(Task task) onEdit,
    required void Function(Task task) onDelete,
  }) : onEdit = onEdit, onDelete = onDelete, super(key: key);


  final List<Task> tasks;
  final void Function(Task) onEdit; 
  final void Function(Task) onDelete; // 

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (ctx, index) => TaskItem(
        task: tasks[index],
        onEdit: () {
          onEdit(tasks[index]);
        },
        onDelete: () {
            onDelete(tasks[index]);
          
        },
      ),
    );
  }
}

