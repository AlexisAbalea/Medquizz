import 'package:medquizz_pass/data/models/question_model.dart';
import 'package:medquizz_pass/data/models/answer_model.dart';

abstract class QuestionRepository {
  Future<List<QuestionModel>> getQuestionsByCategory(int categoryId);
  Future<List<QuestionModel>> getQuestionsByCategoryAndDifficulty(
      int categoryId, String difficulty);
  Future<QuestionModel?> getQuestionById(int id);
  Future<List<AnswerModel>> getAnswersForQuestion(int questionId);
  Future<List<QuestionModel>> getRandomQuestions(
      int categoryId, int limit);
  Future<List<QuestionModel>> getRandomQuestionsByYear(
      String yearLevel, int limit);
}
