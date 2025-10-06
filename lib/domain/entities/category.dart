import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int? id;
  final String name;
  final String yearLevel;
  final String icon;
  final String color;
  final String? description;

  const Category({
    this.id,
    required this.name,
    required this.yearLevel,
    required this.icon,
    required this.color,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, yearLevel, icon, color, description];
}
