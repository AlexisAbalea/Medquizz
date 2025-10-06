import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int? id;
  final String name;
  final String yearLevel; // L1, L2, L3
  final String icon; // Nom de l'icône
  final String color; // Couleur hexadécimale
  final String? description;

  const CategoryModel({
    this.id,
    required this.name,
    required this.yearLevel,
    required this.icon,
    required this.color,
    this.description,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      yearLevel: map['year_level'] as String,
      icon: map['icon'] as String,
      color: map['color'] as String,
      description: map['description'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'year_level': yearLevel,
      'icon': icon,
      'color': color,
      'description': description,
    };
  }

  CategoryModel copyWith({
    int? id,
    String? name,
    String? yearLevel,
    String? icon,
    String? color,
    String? description,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      yearLevel: yearLevel ?? this.yearLevel,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [id, name, yearLevel, icon, color, description];

  @override
  String toString() =>
      'CategoryModel(id: $id, name: $name, yearLevel: $yearLevel)';
}
