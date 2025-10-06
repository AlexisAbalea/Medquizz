import 'package:medquizz_pass/data/datasources/database_helper.dart';
import 'package:medquizz_pass/domain/repositories/progress_repository.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  final DatabaseHelper _dbHelper;

  ProgressRepositoryImpl(this._dbHelper);

  @override
  Future<int> getTotalQuestionsAnswered(int studentId) async {
    final result = await _dbHelper.rawQuery(
      'SELECT COUNT(*) as count FROM user_progress WHERE student_id = ?',
      [studentId],
    );
    return result.first['count'] as int;
  }

  @override
  Future<int> getCorrectAnswersCount(int studentId) async {
    final result = await _dbHelper.rawQuery(
      'SELECT COUNT(*) as count FROM user_progress WHERE student_id = ? AND is_correct = 1',
      [studentId],
    );
    return result.first['count'] as int;
  }

  @override
  Future<double> getSuccessRate(int studentId) async {
    final total = await getTotalQuestionsAnswered(studentId);
    if (total == 0) return 0.0;

    final correct = await getCorrectAnswersCount(studentId);
    return (correct / total) * 100;
  }

  @override
  Future<Map<int, double>> getSuccessRateByCategory(int studentId) async {
    final result = await _dbHelper.rawQuery('''
      SELECT
        q.category_id,
        SUM(CASE WHEN up.is_correct = 1 THEN 1 ELSE 0 END) as correct,
        COUNT(*) as total
      FROM user_progress up
      INNER JOIN questions q ON up.question_id = q.id
      WHERE up.student_id = ?
      GROUP BY q.category_id
    ''', [studentId]);

    final Map<int, double> successRates = {};
    for (var row in result) {
      final categoryId = row['category_id'] as int;
      final correct = row['correct'] as int;
      final total = row['total'] as int;
      successRates[categoryId] = total > 0 ? (correct / total) * 100 : 0.0;
    }

    return successRates;
  }

  @override
  Future<int> getCurrentStreak(int studentId) async {
    // Récupérer les dates uniques des réponses (triées par ordre décroissant)
    final result = await _dbHelper.rawQuery('''
      SELECT DISTINCT DATE(answered_at) as date
      FROM user_progress
      WHERE student_id = ?
      ORDER BY date DESC
    ''', [studentId]);

    if (result.isEmpty) return 0;

    int streak = 1;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    for (int i = 0; i < result.length - 1; i++) {
      final currentDate = DateTime.parse(result[i]['date'] as String);
      final nextDate = DateTime.parse(result[i + 1]['date'] as String);

      // Vérifier si la première date est aujourd'hui ou hier
      if (i == 0) {
        final diff = today.difference(currentDate).inDays;
        if (diff > 1) return 0; // Le streak est cassé
      }

      // Vérifier la continuité
      final daysDiff = currentDate.difference(nextDate).inDays;
      if (daysDiff == 1) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }

  @override
  Future<Map<String, dynamic>> getOverallStats(int studentId) async {
    final totalQuestions = await getTotalQuestionsAnswered(studentId);
    final correctAnswers = await getCorrectAnswersCount(studentId);
    final successRate = await getSuccessRate(studentId);
    final streak = await getCurrentStreak(studentId);

    // Récupérer le nombre de sessions complétées
    final sessions = await _dbHelper.rawQuery(
      'SELECT COUNT(*) as count FROM quiz_sessions WHERE student_id = ? AND completed_at IS NOT NULL',
      [studentId],
    );
    final completedSessions = sessions.first['count'] as int;

    return {
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'successRate': successRate,
      'currentStreak': streak,
      'completedSessions': completedSessions,
    };
  }
}
