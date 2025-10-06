import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final int? id;
  final int categoryId;
  final String yearLevel;
  final String questionText;
  final String difficulty;
  final String explanation;

  const Question({
    this.id,
    required this.categoryId,
    required this.yearLevel,
    required this.questionText,
    required this.difficulty,
    required this.explanation,
  });

  @override
  List<Object?> get props =>
      [id, categoryId, yearLevel, questionText, difficulty, explanation];
}
