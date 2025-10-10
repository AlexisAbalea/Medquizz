import 'package:hippoquiz/data/datasources/database_helper.dart';
import 'package:hippoquiz/data/models/answer_model.dart';
import 'package:hippoquiz/data/models/question_model.dart';
import 'package:hippoquiz/domain/repositories/question_repository.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final DatabaseHelper _dbHelper;

  QuestionRepositoryImpl(this._dbHelper);

  @override
  Future<List<QuestionModel>> getQuestionsByCategory(int categoryId) async {
    final questions = await _dbHelper.queryWhere(
      'questions',
      'category_id = ?',
      [categoryId],
    );
    return questions.map((q) => QuestionModel.fromMap(q)).toList();
  }

  @override
  Future<List<QuestionModel>> getQuestionsByCategoryAndDifficulty(
      int categoryId, String difficulty) async {
    final questions = await _dbHelper.rawQuery(
      'SELECT * FROM questions WHERE category_id = ? AND difficulty = ?',
      [categoryId, difficulty],
    );
    return questions.map((q) => QuestionModel.fromMap(q)).toList();
  }

  @override
  Future<QuestionModel?> getQuestionById(int id) async {
    final questions = await _dbHelper.queryWhere(
      'questions',
      'id = ?',
      [id],
    );
    if (questions.isEmpty) return null;
    return QuestionModel.fromMap(questions.first);
  }

  @override
  Future<List<AnswerModel>> getAnswersForQuestion(int questionId) async {
    final answers = await _dbHelper.queryWhere(
      'answers',
      'question_id = ?',
      [questionId],
    );
    return answers.map((a) => AnswerModel.fromMap(a)).toList();
  }

  @override
  Future<List<QuestionModel>> getRandomQuestions(
      int categoryId, int limit) async {
    final questions = await _dbHelper.rawQuery(
      'SELECT * FROM questions WHERE category_id = ? ORDER BY RANDOM() LIMIT ?',
      [categoryId, limit],
    );
    return questions.map((q) => QuestionModel.fromMap(q)).toList();
  }

  @override
  Future<List<QuestionModel>> getRandomQuestionsByYear(
      String yearLevel, int limit) async {
    final questions = await _dbHelper.rawQuery(
      'SELECT * FROM questions WHERE year_level = ? ORDER BY RANDOM() LIMIT ?',
      [yearLevel, limit],
    );
    return questions.map((q) => QuestionModel.fromMap(q)).toList();
  }
}
