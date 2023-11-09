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

  //copyWith({required String title, required String description, required DateTime date, required Category category}) {}
  Task copyWith({
  String? title,
  String? description,
  DateTime? date,
  Category? category,
}) {
  return Task(
    title: title ?? this.title,
    description: description ?? this.description,
    date: date ?? this.date,
    category: category ?? this.category,
  );
}

}













