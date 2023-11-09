import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';


class TaskItem extends StatelessWidget {
  final Task task;
  final Function() onEdit;
  final Function() onDelete;

  TaskItem({
    required this.task,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.task),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(task.description ?? ''),
                    ],
                  ),
                ),
                const SizedBox(width: 30),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ${task.date.toLocal()}',
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Category: ${task.category.toString().split('.').last}',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}




