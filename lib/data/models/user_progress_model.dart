import 'package:equatable/equatable.dart';

class UserProgressModel extends Equatable {
  final int? id;
  final int studentId;
  final int questionId;
  final bool isCorrect;
  final DateTime answeredAt;

  const UserProgressModel({
    this.id,
    required this.studentId,
    required this.questionId,
    required this.isCorrect,
    required this.answeredAt,
  });

  factory UserProgressModel.fromMap(Map<String, dynamic> map) {
    return UserProgressModel(
      id: map['id'] as int?,
      studentId: map['student_id'] as int,
      questionId: map['question_id'] as int,
      isCorrect: (map['is_correct'] as int) == 1,
      answeredAt: DateTime.parse(map['answered_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'student_id': studentId,
      'question_id': questionId,
      'is_correct': isCorrect ? 1 : 0,
      'answered_at': answeredAt.toIso8601String(),
    };
  }

  UserProgressModel copyWith({
    int? id,
    int? studentId,
    int? questionId,
    bool? isCorrect,
    DateTime? answeredAt,
  }) {
    return UserProgressModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      questionId: questionId ?? this.questionId,
      isCorrect: isCorrect ?? this.isCorrect,
      answeredAt: answeredAt ?? this.answeredAt,
    );
  }

  @override
  List<Object?> get props =>
      [id, studentId, questionId, isCorrect, answeredAt];

  @override
  String toString() =>
      'UserProgressModel(id: $id, studentId: $studentId, questionId: $questionId, isCorrect: $isCorrect)';
}
