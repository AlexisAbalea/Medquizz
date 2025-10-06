import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final int? id;
  final String name;
  final String yearLevel;
  final DateTime createdAt;

  const Student({
    this.id,
    required this.name,
    required this.yearLevel,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, yearLevel, createdAt];
}
