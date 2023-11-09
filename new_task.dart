import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key, required this.onAddTask});

  final void Function(Task task) onAddTask;

  @override
  State<NewTask> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  Category _selectedCategory = Category.personal;
  DateTime _selectedDate = DateTime.now(); 

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitTaskData() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text('Merci de saisir le titre de la tâche à ajouter dans la liste'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    final newTask = Task(
      title: title,
      description: description,
      category: _selectedCategory,
      date: _selectedDate, 
    );

    widget.onAddTask(newTask);
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Task title',
            ),
          ),
          TextField(
            controller: _descriptionController,
            maxLength: 100,
            decoration: InputDecoration(
              labelText: 'Task description',
            ),
          ),
          ElevatedButton(
            onPressed: _selectDate,
            child: Text('Date ${_selectedDate.toLocal()}'.split(' ')[0]),
          ),
          DropdownButton<Category>(
            value: _selectedCategory,
            onChanged: (Category? newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
            },
            items: Category.values
                .map((Category category) => DropdownMenuItem<Category>(
                      value: category,
                      child: Text(category.toString().split('.').last),
                    ))
                .toList(),
          ),
          ElevatedButton(
            onPressed: _submitTaskData,
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }
}


