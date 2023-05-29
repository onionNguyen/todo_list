// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Todo {
  Todo({
    required this.title,
    required this.id,
    required this.description,
    this.isCompleted = false,
    this.date,
  });
  final String title;
  final String id;
  final String description;
  final bool isCompleted;
  final DateTime? date;

  Todo copyWith({
    String? title,
    String? id,
    String? description,
    bool? isCompleted,
    DateTime? date,
  }) {
    return Todo(
      title: title ?? this.title,
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'id': id,
      'description': description,
      'isCompleted': isCompleted,
      'date': date?.millisecondsSinceEpoch,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'] as String,
      id: map['id'] as String,
      description: map['description'] as String,
      isCompleted: map['isCompleted'] as bool,
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Todo(title: $title, id: $id, description: $description, isCompleted: $isCompleted, date: $date)';
  }

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.id == id &&
        other.description == description &&
        other.isCompleted == isCompleted &&
        other.date == date;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        description.hashCode ^
        isCompleted.hashCode ^
        date.hashCode;
  }
}
