abstract class ProgressRepository {
  Future<int> getTotalQuestionsAnswered(int studentId);
  Future<int> getCorrectAnswersCount(int studentId);
  Future<double> getSuccessRate(int studentId);
  Future<Map<int, double>> getSuccessRateByCategory(int studentId);
  Future<int> getCurrentStreak(int studentId);
  Future<Map<String, dynamic>> getOverallStats(int studentId);
}
