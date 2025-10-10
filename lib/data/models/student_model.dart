import 'package:equatable/equatable.dart';

class StudentModel extends Equatable {
  final int? id;
  final String name;
  final String yearLevel;
  final DateTime createdAt;

  const StudentModel({
    this.id,
    required this.name,
    required this.yearLevel,
    required this.createdAt,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      yearLevel: map['year_level'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'year_level': yearLevel,
      'created_at': createdAt.toIso8601String(),
    };
  }

  StudentModel copyWith({
    int? id,
    String? name,
    String? yearLevel,
    DateTime? createdAt,
  }) {
    return StudentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      yearLevel: yearLevel ?? this.yearLevel,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, yearLevel, createdAt];

  @override
  String toString() =>
      'StudentModel(id: $id, name: $name, yearLevel: $yearLevel, createdAt: $createdAt)';
}
