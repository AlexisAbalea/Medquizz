import 'package:hippoquiz/data/datasources/database_helper.dart';
import 'package:hippoquiz/data/models/quiz_session_model.dart';
import 'package:hippoquiz/data/models/user_progress_model.dart';
import 'package:hippoquiz/domain/repositories/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  final DatabaseHelper _dbHelper;

  QuizRepositoryImpl(this._dbHelper);

  @override
  Future<int> createQuizSession(QuizSessionModel session) async {
    return await _dbHelper.insert('quiz_sessions', session.toMap());
  }

  @override
  Future<void> updateQuizSession(QuizSessionModel session) async {
    if (session.id == null) {
      throw Exception('Quiz session ID cannot be null for update');
    }
    await _dbHelper.update(
      'quiz_sessions',
      session.toMap(),
      'id = ?',
      [session.id],
    );
  }

  @override
  Future<QuizSessionModel?> getQuizSessionById(int id) async {
    final sessions = await _dbHelper.queryWhere(
      'quiz_sessions',
      'id = ?',
      [id],
    );
    if (sessions.isEmpty) return null;
    return QuizSessionModel.fromMap(sessions.first);
  }

  @override
  Future<List<QuizSessionModel>> getQuizSessionsByStudent(int studentId) async {
    final sessions = await _dbHelper.queryWhere(
      'quiz_sessions',
      'student_id = ?',
      [studentId],
    );
    return sessions.map((s) => QuizSessionModel.fromMap(s)).toList();
  }

  @override
  Future<List<QuizSessionModel>> getRecentSessions(
      int studentId, int limit) async {
    final sessions = await _dbHelper.rawQuery(
      'SELECT * FROM quiz_sessions WHERE student_id = ? ORDER BY started_at DESC LIMIT ?',
      [studentId, limit],
    );
    return sessions.map((s) => QuizSessionModel.fromMap(s)).toList();
  }

  @override
  Future<int> saveUserProgress(UserProgressModel progress) async {
    return await _dbHelper.insert('user_progress', progress.toMap());
  }

  @override
  Future<List<UserProgressModel>> getUserProgressByStudent(
      int studentId) async {
    final progress = await _dbHelper.queryWhere(
      'user_progress',
      'student_id = ?',
      [studentId],
    );
    return progress.map((p) => UserProgressModel.fromMap(p)).toList();
  }

  @override
  Future<List<UserProgressModel>> getUserProgressByQuestion(
      int questionId) async {
    final progress = await _dbHelper.queryWhere(
      'user_progress',
      'question_id = ?',
      [questionId],
    );
    return progress.map((p) => UserProgressModel.fromMap(p)).toList();
  }
}
