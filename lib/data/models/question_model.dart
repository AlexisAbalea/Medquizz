import 'package:equatable/equatable.dart';

class QuestionModel extends Equatable {
  final int? id;
  final int categoryId;
  final String yearLevel; // L1, L2, L3
  final String questionText;
  final String difficulty; // Facile, Moyen, Difficile
  final String explanation;

  const QuestionModel({
    this.id,
    required this.categoryId,
    required this.yearLevel,
    required this.questionText,
    required this.difficulty,
    required this.explanation,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'] as int?,
      categoryId: map['category_id'] as int,
      yearLevel: map['year_level'] as String,
      questionText: map['question_text'] as String,
      difficulty: map['difficulty'] as String,
      explanation: map['explanation'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'category_id': categoryId,
      'year_level': yearLevel,
      'question_text': questionText,
      'difficulty': difficulty,
      'explanation': explanation,
    };
  }

  QuestionModel copyWith({
    int? id,
    int? categoryId,
    String? yearLevel,
    String? questionText,
    String? difficulty,
    String? explanation,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      yearLevel: yearLevel ?? this.yearLevel,
      questionText: questionText ?? this.questionText,
      difficulty: difficulty ?? this.difficulty,
      explanation: explanation ?? this.explanation,
    );
  }

  @override
  List<Object?> get props =>
      [id, categoryId, yearLevel, questionText, difficulty, explanation];

  @override
  String toString() =>
      'QuestionModel(id: $id, categoryId: $categoryId, difficulty: $difficulty)';
}
