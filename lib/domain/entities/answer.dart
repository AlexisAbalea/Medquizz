import 'package:equatable/equatable.dart';

class Answer extends Equatable {
  final int? id;
  final int questionId;
  final String answerText;
  final bool isCorrect;

  const Answer({
    this.id,
    required this.questionId,
    required this.answerText,
    required this.isCorrect,
  });

  @override
  List<Object?> get props => [id, questionId, answerText, isCorrect];
}
