import 'package:flutter/foundation.dart';
import 'package:medquizz_pass/data/models/question_model.dart';
import 'package:medquizz_pass/data/models/answer_model.dart';
import 'package:medquizz_pass/data/models/quiz_session_model.dart';
import 'package:medquizz_pass/data/models/user_progress_model.dart';
import 'package:medquizz_pass/domain/repositories/question_repository.dart';
import 'package:medquizz_pass/domain/repositories/quiz_repository.dart';
import 'package:medquizz_pass/core/services/sound_service.dart';

class QuizProvider with ChangeNotifier {
  final QuestionRepository _questionRepository;
  final QuizRepository _quizRepository;
  final SoundService _soundService = SoundService();

  List<QuestionModel> _questions = [];
  final Map<int, List<AnswerModel>> _answers = {};
  int _currentQuestionIndex = 0;
  final Map<int, int?> _selectedAnswers = {}; // questionId -> answerId
  QuizSessionModel? _currentSession;
  bool _isLoading = false;
  String? _error;

  QuizProvider(this._questionRepository, this._quizRepository);

  List<QuestionModel> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  QuestionModel? get currentQuestion =>
      _questions.isNotEmpty ? _questions[_currentQuestionIndex] : null;
  List<AnswerModel> get currentAnswers =>
      currentQuestion != null ? _answers[currentQuestion!.id] ?? [] : [];
  int? get selectedAnswer =>
      currentQuestion != null ? _selectedAnswers[currentQuestion!.id] : null;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get totalQuestions => _questions.length;
  double get progress =>
      _questions.isNotEmpty ? (_currentQuestionIndex + 1) / _questions.length : 0;
  QuizSessionModel? get currentSession => _currentSession;

  bool get hasNextQuestion => _currentQuestionIndex < _questions.length - 1;
  bool get hasPreviousQuestion => _currentQuestionIndex > 0;
  bool get isLastQuestion => _currentQuestionIndex == _questions.length - 1;

  Future<void> startQuiz(int categoryId, int studentId, {int? limit}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      print('Starting quiz for categoryId: $categoryId with limit: $limit');

      // Charger les questions
      if (limit != null && limit > 0) {
        _questions =
            await _questionRepository.getRandomQuestions(categoryId, limit);
      } else {
        _questions = await _questionRepository.getQuestionsByCategory(categoryId);
        _questions.shuffle(); // Mélanger les questions
      }

      print('Loaded ${_questions.length} questions');

      if (_questions.isEmpty) {
        _error = 'Aucune question disponible pour cette catégorie';
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Charger les réponses pour chaque question
      _answers.clear();
      for (var question in _questions) {
        if (question.id != null) {
          final answers =
              await _questionRepository.getAnswersForQuestion(question.id!);
          answers.shuffle(); // Mélanger les réponses
          _answers[question.id!] = answers;
        }
      }

      // Créer une nouvelle session
      _currentSession = QuizSessionModel(
        studentId: studentId,
        categoryId: categoryId,
        score: 0,
        totalQuestions: _questions.length,
        startedAt: DateTime.now(),
      );

      _currentQuestionIndex = 0;
      _selectedAnswers.clear();
    } catch (e) {
      _error = 'Erreur lors du démarrage du quiz: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectAnswer(int answerId) {
    if (currentQuestion?.id != null) {
      _selectedAnswers[currentQuestion!.id!] = answerId;
      notifyListeners();
    }
  }

  bool isAnswerSelected(int answerId) {
    return selectedAnswer == answerId;
  }

  bool? isAnswerCorrect(int answerId) {
    final answers = currentAnswers;
    final answer = answers.firstWhere((a) => a.id == answerId);
    return answer.isCorrect;
  }

  void nextQuestion() {
    if (hasNextQuestion) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (hasPreviousQuestion) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  void goToQuestion(int index) {
    if (index >= 0 && index < _questions.length) {
      _currentQuestionIndex = index;
      notifyListeners();
    }
  }

  Future<QuizSessionModel?> finishQuiz(int studentId) async {
    if (_currentSession == null) return null;

    _isLoading = true;
    notifyListeners();

    try {
      // Calculer le score
      int score = 0;
      for (var question in _questions) {
        if (question.id != null && _selectedAnswers.containsKey(question.id)) {
          final selectedAnswerId = _selectedAnswers[question.id!];
          final answers = _answers[question.id!] ?? [];
          final selectedAnswer =
              answers.firstWhere((a) => a.id == selectedAnswerId);

          if (selectedAnswer.isCorrect) {
            score++;
          }

          // Enregistrer la progression
          final progress = UserProgressModel(
            studentId: studentId,
            questionId: question.id!,
            isCorrect: selectedAnswer.isCorrect,
            answeredAt: DateTime.now(),
          );
          await _quizRepository.saveUserProgress(progress);
        }
      }

      // Mettre à jour la session
      final completedSession = QuizSessionModel(
        studentId: _currentSession!.studentId,
        categoryId: _currentSession!.categoryId,
        score: score,
        totalQuestions: _currentSession!.totalQuestions,
        startedAt: _currentSession!.startedAt,
        completedAt: DateTime.now(),
      );

      final sessionId = await _quizRepository.createQuizSession(completedSession);
      _currentSession = completedSession.copyWith(id: sessionId);

      return _currentSession;
    } catch (e) {
      _error = 'Erreur lors de la finalisation du quiz: $e';
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  int getAnsweredQuestionsCount() {
    return _selectedAnswers.length;
  }

  bool isQuestionAnswered(int questionId) {
    return _selectedAnswers.containsKey(questionId);
  }

  Future<void> startRandomQuiz(int categoryId, String yearLevel, int studentId, {int? limit}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Charger des questions aléatoires de toutes les catégories du niveau
      _questions = await _questionRepository.getRandomQuestionsByYear(
        yearLevel,
        limit ?? 10,
      );

      if (_questions.isEmpty) {
        _error = 'Aucune question disponible pour ce niveau';
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Charger les réponses pour chaque question
      _answers.clear();
      for (var question in _questions) {
        if (question.id != null) {
          final answers =
              await _questionRepository.getAnswersForQuestion(question.id!);
          answers.shuffle(); // Mélanger les réponses
          _answers[question.id!] = answers;
        }
      }

      // Créer une nouvelle session avec le categoryId fourni (la catégorie "Questions aléatoires")
      _currentSession = QuizSessionModel(
        studentId: studentId,
        categoryId: categoryId,
        score: 0,
        totalQuestions: _questions.length,
        startedAt: DateTime.now(),
      );

      _currentQuestionIndex = 0;
      _selectedAnswers.clear();
    } catch (e) {
      _error = 'Erreur lors du démarrage du quiz: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetQuiz() {
    _questions = [];
    _answers.clear();
    _currentQuestionIndex = 0;
    _selectedAnswers.clear();
    _currentSession = null;
    _error = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Play sound based on whether answer is correct or not
  void playAnswerSound(bool isCorrect) {
    if (isCorrect) {
      _soundService.playCorrectSound();
    } else {
      _soundService.playWrongSound();
    }
  }
}
