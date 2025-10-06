import 'package:flutter/foundation.dart';
import 'package:medquizz_pass/data/models/quiz_session_model.dart';
import 'package:medquizz_pass/domain/repositories/quiz_repository.dart';
import 'package:medquizz_pass/domain/repositories/progress_repository.dart';

class ProgressProvider with ChangeNotifier {
  final ProgressRepository _progressRepository;
  final QuizRepository _quizRepository;

  Map<String, dynamic>? _overallStats;
  Map<int, double> _successRatesByCategory = {};
  List<QuizSessionModel> _recentSessions = [];
  bool _isLoading = false;
  String? _error;

  ProgressProvider(this._progressRepository, this._quizRepository);

  Map<String, dynamic>? get overallStats => _overallStats;
  Map<int, double> get successRatesByCategory => _successRatesByCategory;
  List<QuizSessionModel> get recentSessions => _recentSessions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  int get totalQuestions => _overallStats?['totalQuestions'] ?? 0;
  int get correctAnswers => _overallStats?['correctAnswers'] ?? 0;
  double get successRate => _overallStats?['successRate'] ?? 0.0;
  int get currentStreak => _overallStats?['currentStreak'] ?? 0;
  int get completedSessions => _overallStats?['completedSessions'] ?? 0;

  Future<void> loadOverallStats(int studentId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _overallStats = await _progressRepository.getOverallStats(studentId);
    } catch (e) {
      _error = 'Erreur lors du chargement des statistiques: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadSuccessRatesByCategory(int studentId) async {
    try {
      _successRatesByCategory =
          await _progressRepository.getSuccessRateByCategory(studentId);
      notifyListeners();
    } catch (e) {
      _error = 'Erreur lors du chargement des taux de réussite: $e';
      notifyListeners();
    }
  }

  Future<void> loadRecentSessions(int studentId, {int limit = 10}) async {
    try {
      _recentSessions = await _quizRepository.getRecentSessions(studentId, limit);
      notifyListeners();
    } catch (e) {
      _error = 'Erreur lors du chargement des sessions récentes: $e';
      notifyListeners();
    }
  }

  Future<void> loadAllStats(int studentId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.wait([
        loadOverallStats(studentId),
        loadSuccessRatesByCategory(studentId),
        loadRecentSessions(studentId),
      ]);
    } catch (e) {
      _error = 'Erreur lors du chargement des statistiques: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<int> getTotalQuestionsAnswered(int studentId) async {
    try {
      return await _progressRepository.getTotalQuestionsAnswered(studentId);
    } catch (e) {
      return 0;
    }
  }

  Future<int> getCorrectAnswersCount(int studentId) async {
    try {
      return await _progressRepository.getCorrectAnswersCount(studentId);
    } catch (e) {
      return 0;
    }
  }

  Future<double> getSuccessRate(int studentId) async {
    try {
      return await _progressRepository.getSuccessRate(studentId);
    } catch (e) {
      return 0.0;
    }
  }

  Future<int> getCurrentStreak(int studentId) async {
    try {
      return await _progressRepository.getCurrentStreak(studentId);
    } catch (e) {
      return 0;
    }
  }

  double getCategorySuccessRate(int categoryId) {
    return _successRatesByCategory[categoryId] ?? 0.0;
  }

  // Obtenir les catégories avec le meilleur taux de réussite
  List<MapEntry<int, double>> getTopCategories({int limit = 3}) {
    final entries = _successRatesByCategory.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries.take(limit).toList();
  }

  // Obtenir les catégories avec le moins bon taux de réussite
  List<MapEntry<int, double>> getWeakestCategories({int limit = 3}) {
    final entries = _successRatesByCategory.entries.toList();
    entries.sort((a, b) => a.value.compareTo(b.value));
    return entries.take(limit).toList();
  }

  void clearStats() {
    _overallStats = null;
    _successRatesByCategory.clear();
    _recentSessions.clear();
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
