import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/services/firestore.dart';
import 'package:todolist_app/widgets/new_task.dart';
import 'package:todolist_app/widgets/tasks_list_dart.dart';
import 'package:intl/intl.dart';
class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() {
    return _TasksState();
  }
}

class _TasksState extends State<Tasks> {
  final FirestoreService firestoreService = FirestoreService();
  List<Task> _registeredTasks = [
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
    // Vous pouvez ajouter plus de tâches ici si nécessaire
  ];

  @override
  void initState() {
    super.initState();
    _loadTasksFromFirebase();
  }

  Future<void> _loadTasksFromFirebase() async {
    final tasks = await firestoreService.getTasksFromFirebase();
    setState(() {
      _registeredTasks.addAll(tasks);
    });
  }

  void _openAddTaskOverlay() {
    print("Bouton '+' appuyé");
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTask(onAddTask: _addTask),
    );
  }

  void _addTask(Task task) {
    setState(() {
      _registeredTasks.add(task);
      firestoreService.addTask(task);
      Navigator.pop(context);
    });
  }

 
  String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(date);
}
  void _editTask(Task task) {
  showDialog(
    context: context,
    builder: (ctx) {
      String editedTitle = task.title;
      String editedDescription = task.description;
      DateTime editedDate = task.date;
      Category editedCategory = task.category;

      return AlertDialog(
        title: Text('Modifier la tâche'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Titre'),
              onChanged: (value) {
                editedTitle = value;
              },
              controller: TextEditingController(text: editedTitle),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                editedDescription = value;
              },
              controller: TextEditingController(text: editedDescription),
            ),
            
            TextField(
                decoration: InputDecoration(labelText: 'Date'),
                controller: TextEditingController(
                text: DateFormat('yyyy-MM-dd').format(editedDate),
                ),
                onTap: () async {
                final selectedDate = await showDatePicker(
                context: ctx,
                initialDate: editedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
                );

                if (selectedDate != null) {
                setState(() {
               editedDate = selectedDate;
             });
    }
  },
),

            DropdownButton<Category>(
              value: editedCategory,
              onChanged: (Category? newValue) {
                if (newValue != null) {
                  setState(() {
                    editedCategory = newValue;
                  });
                }
              },
              items: Category.values.map((Category category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.toString().split('.').last),
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () async {
              final updatedTask = task.copyWith(
                title: editedTitle,
                description: editedDescription,
                date: editedDate,
                category: editedCategory,
              );
              await _updateTask(updatedTask);
              Navigator.of(ctx).pop();
            },
            child: Text('Enregistrer'),
          ),
        ],
      );
    },
  );
}


  void _deleteTask(Task task) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Confirmez la suppression'),
          content: Text('Voulez-vous vraiment supprimer cette tâche : ${task.title} ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                _removeTask(task);
                Navigator.of(ctx).pop();
              },
              child: Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }

  
  Future<void> _updateTask(Task updatedTask) async {
  setState(() {
    final index = _registeredTasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _registeredTasks[index] = updatedTask;
    }
  });

  await firestoreService.updateTask(updatedTask);
  print('Tâche mise à jour : ${updatedTask.title}');
}

Future<void> _removeTask(Task task) async {
  await firestoreService.deleteTask(task.id);

  setState(() {
    _registeredTasks.remove(task);
  });
  print('Tâche supprimée : ${task.title}');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My App')),
        actions: [
          IconButton(
            onPressed: _openAddTaskOverlay,
            icon: Ink(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 219, 108, 169),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
      body: TasksList(
        tasks: _registeredTasks,
        onEdit: _editTask,
        onDelete: _deleteTask,
      ),
    );
  }
}























