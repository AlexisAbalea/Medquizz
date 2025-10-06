import 'package:equatable/equatable.dart';

class QuizSession extends Equatable {
  final int? id;
  final int studentId;
  final int categoryId;
  final int score;
  final int totalQuestions;
  final DateTime startedAt;
  final DateTime? completedAt;

  const QuizSession({
    this.id,
    required this.studentId,
    required this.categoryId,
    required this.score,
    required this.totalQuestions,
    required this.startedAt,
    this.completedAt,
  });

  double get percentage =>
      totalQuestions > 0 ? (score / totalQuestions) * 100 : 0;

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
}
