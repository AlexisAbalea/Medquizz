import 'package:medquizz_pass/data/models/quiz_session_model.dart';
import 'package:medquizz_pass/data/models/user_progress_model.dart';

abstract class QuizRepository {
  Future<int> createQuizSession(QuizSessionModel session);
  Future<void> updateQuizSession(QuizSessionModel session);
  Future<QuizSessionModel?> getQuizSessionById(int id);
  Future<List<QuizSessionModel>> getQuizSessionsByStudent(int studentId);
  Future<List<QuizSessionModel>> getRecentSessions(int studentId, int limit);

  Future<int> saveUserProgress(UserProgressModel progress);
  Future<List<UserProgressModel>> getUserProgressByStudent(int studentId);
  Future<List<UserProgressModel>> getUserProgressByQuestion(int questionId);
}
