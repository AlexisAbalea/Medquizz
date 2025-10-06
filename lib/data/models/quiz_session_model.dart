import 'package:equatable/equatable.dart';

class QuizSessionModel extends Equatable {
  final int? id;
  final int studentId;
  final int categoryId;
  final int score;
  final int totalQuestions;
  final DateTime startedAt;
  final DateTime? completedAt;

  const QuizSessionModel({
    this.id,
    required this.studentId,
    required this.categoryId,
    required this.score,
    required this.totalQuestions,
    required this.startedAt,
    this.completedAt,
  });

  factory QuizSessionModel.fromMap(Map<String, dynamic> map) {
    return QuizSessionModel(
      id: map['id'] as int?,
      studentId: map['student_id'] as int,
      categoryId: map['category_id'] as int,
      score: map['score'] as int,
      totalQuestions: map['total_questions'] as int,
      startedAt: DateTime.parse(map['started_at'] as String),
      completedAt: map['completed_at'] != null
          ? DateTime.parse(map['completed_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'student_id': studentId,
      'category_id': categoryId,
      'score': score,
      'total_questions': totalQuestions,
      'started_at': startedAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
    };
  }

  // Calculer le pourcentage de réussite
  double get percentage =>
      totalQuestions > 0 ? (score / totalQuestions) * 100 : 0;

  QuizSessionModel copyWith({
    int? id,
    int? studentId,
    int? categoryId,
    int? score,
    int? totalQuestions,
    DateTime? startedAt,
    DateTime? completedAt,
  }) {
    return QuizSessionModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      categoryId: categoryId ?? this.categoryId,
      score: score ?? this.score,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        studentId,
        categoryId,
        score,
        totalQuestions,
        startedAt,
        completedAt
      ];

  @override
  String toString() =>
      'QuizSessionModel(id: $id, score: $score/$totalQuestions, percentage: ${percentage.toStringAsFixed(1)}%)';
}
