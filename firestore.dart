import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirestoreService {
  final CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  
  Future<void> addTask(Task task) {
  final title = task.title ?? 'Titre par défaut';
  final description = task.description ?? 'Description par défaut';
  final category = task.category != null ? task.category.toString() : 'Autre';

  return FirebaseFirestore.instance.collection('tasks').add({
    'taskTitle': title,
    'taskDesc': description,
    'taskCategory': category,
    'taskDate': task.date.toUtc(), 
  }).then((docRef) {
    print('Tâche ajoutée avec succès : ${docRef.id}');
  }).catchError((error) {
    print('Erreur lors de l\'ajout de la tâche : $error');
  });
}

  Future<List<Task>> getTasksFromFirebase() async {
  final querySnapshot = await tasks.get();
  return querySnapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Task(
      title: data['taskTitle'] as String,
      description: data['taskDesc'] as String,
      category: Category.values.firstWhere(
        (cat) => cat.toString() == data['taskCategory'],
        orElse: () => Category.others,
      ),
    );
  }).toList();
}
Future<void> updateTask(Task task) async {
  final DocumentReference documentReference =
      FirebaseFirestore.instance.collection('tasks').doc(task.id);

  await documentReference.update({
    'title': task.title,
    'description': task.description,
    'date': task.date.toUtc(), 
    'category': task.category.toString(),
  });
}
Future<void> deleteTask(String taskId) async {
  final DocumentReference documentReference =
      FirebaseFirestore.instance.collection('tasks').doc(taskId);

  await documentReference.delete();
}




  Stream<QuerySnapshot> getTasks() {
    final taskStream = tasks.snapshots();
    return taskStream;
  }
}


