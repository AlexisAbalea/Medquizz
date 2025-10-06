import 'package:equatable/equatable.dart';

class AnswerModel extends Equatable {
  final int? id;
  final int questionId;
  final String answerText;
  final bool isCorrect;

  const AnswerModel({
    this.id,
    required this.questionId,
    required this.answerText,
    required this.isCorrect,
  });

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      id: map['id'] as int?,
      questionId: map['question_id'] as int,
      answerText: map['answer_text'] as String,
      isCorrect: (map['is_correct'] as int) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'question_id': questionId,
      'answer_text': answerText,
      'is_correct': isCorrect ? 1 : 0,
    };
  }

  AnswerModel copyWith({
    int? id,
    int? questionId,
    String? answerText,
    bool? isCorrect,
  }) {
    return AnswerModel(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      answerText: answerText ?? this.answerText,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  @override
  List<Object?> get props => [id, questionId, answerText, isCorrect];

  @override
  String toString() =>
      'AnswerModel(id: $id, questionId: $questionId, isCorrect: $isCorrect)';
}
