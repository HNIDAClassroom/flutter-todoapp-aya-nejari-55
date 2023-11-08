import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { personal, work, shopping, others }

class Task {
  Task({
    required this.title,
    this.description = "",
    DateTime? date,
    this.category = Category.others,
  })   : id = uuid.v4(),
        date = date ?? DateTime.now();

  final String id;
  final String title;
  final String description;
  final DateTime date;
  final Category category;

  copyWith({required String title, required String description, required DateTime date, required Category category}) {}
}




