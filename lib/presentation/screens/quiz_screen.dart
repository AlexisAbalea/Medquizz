import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medquizz_pass/core/constants/app_colors.dart';
import 'package:medquizz_pass/core/constants/app_sizes.dart';
import 'package:medquizz_pass/core/constants/app_strings.dart';
import 'package:medquizz_pass/core/constants/app_text_styles.dart';
import 'package:medquizz_pass/core/widgets/answer_option_card.dart';
import 'package:medquizz_pass/core/widgets/custom_button.dart';
import 'package:medquizz_pass/core/widgets/loading_indicator.dart';
import 'package:medquizz_pass/core/widgets/progress_bar.dart';
import 'package:medquizz_pass/data/models/category_model.dart';
import 'package:medquizz_pass/presentation/providers/quiz_provider.dart';
import 'package:medquizz_pass/presentation/providers/student_provider.dart';
import 'package:medquizz_pass/presentation/screens/quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  final CategoryModel category;

  const QuizScreen({
    super.key,
    required this.category,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool _showExplanation = false;

  @override
  void initState() {
    super.initState();
    _startQuiz();
  }

  Future<void> _startQuiz() async {
    final student = context.read<StudentProvider>().currentStudent;
    if (student != null) {
      // Vérifier si c'est la catégorie "Questions aléatoires"
      if (widget.category.name == 'Questions aléatoires') {
        await context.read<QuizProvider>().startRandomQuiz(
              widget.category.id!,
              widget.category.yearLevel,
              student.id!,
              limit: 15, // 15 questions par quiz
            );
      } else {
        await context.read<QuizProvider>().startQuiz(
              widget.category.id!,
              student.id!,
              limit: 15, // 15 questions par quiz
            );
      }
    }
  }

  void _selectAnswer(int answerId) {
    context.read<QuizProvider>().selectAnswer(answerId);
    setState(() {
      _showExplanation = true;
    });
  }

  void _nextQuestion() {
    final quizProvider = context.read<QuizProvider>();
    quizProvider.nextQuestion();
    setState(() {
      _showExplanation = false;
    });
  }

  Future<void> _finishQuiz() async {
    final quizProvider = context.read<QuizProvider>();
    final student = context.read<StudentProvider>().currentStudent;

    if (student != null) {
      final session = await quizProvider.finishQuiz(student.id!);

      if (session != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => QuizResultScreen(session: session),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Quitter le quiz ?'),
            content: const Text(
                'Votre progression sera perdue si vous quittez maintenant.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(AppStrings.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
                child: const Text(AppStrings.yes),
              ),
            ],
          ),
        );
        if (shouldPop == true && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.category.name),
        ),
        body: Consumer<QuizProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading || provider.questions.isEmpty) {
              return const LoadingIndicator(message: AppStrings.loading);
            }

            final question = provider.currentQuestion;
            final answers = provider.currentAnswers;

            if (question == null || answers.isEmpty) {
              return const Center(
                child: Text(AppStrings.noQuestionsAvailable),
              );
            }

            return Column(
              children: [
                // Barre de progression
                Container(
                  padding: const EdgeInsets.all(AppSizes.paddingMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${AppStrings.question} ${provider.currentQuestionIndex + 1} ${AppStrings.of} ${provider.totalQuestions}',
                            style: AppTextStyles.titleMedium,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.paddingSm,
                              vertical: AppSizes.paddingXs,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.getDifficultyColor(
                                      question.difficulty)
                                  .withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.circular(AppSizes.radiusSm),
                            ),
                            child: Text(
                              question.difficulty,
                              style: AppTextStyles.labelSmall.copyWith(
                                color:
                                    AppColors.getDifficultyColor(question.difficulty),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.spacingSm),
                      CustomProgressBar(
                        progress: provider.progress,
                        color: AppColors.getCategoryColor(widget.category.name),
                      ),
                    ],
                  ),
                ),

                // Contenu scrollable
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSizes.paddingMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Question
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(AppSizes.paddingLg),
                            child: Text(
                              question.questionText,
                              style: AppTextStyles.questionText,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.spacingLg),

                        // Réponses
                        ...List.generate(answers.length, (index) {
                          final answer = answers[index];
                          final isSelected =
                              provider.selectedAnswer == answer.id;

                          AnswerState state = AnswerState.normal;
                          if (_showExplanation) {
                            // Afficher la bonne réponse en vert
                            if (answer.isCorrect) {
                              state = AnswerState.correct;
                            }
                            // Afficher la mauvaise réponse sélectionnée en rouge
                            else if (isSelected) {
                              state = AnswerState.incorrect;
                            }
                          } else if (isSelected) {
                            state = AnswerState.selected;
                          }

                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: AppSizes.spacingMd),
                            child: AnswerOptionCard(
                              text: answer.answerText,
                              optionLabel: String.fromCharCode(65 + index), // A, B, C, D
                              state: state,
                              onTap: _showExplanation
                                  ? null
                                  : () => _selectAnswer(answer.id!),
                              isEnabled: !_showExplanation,
                            ),
                          );
                        }),

                        // Explication avec animation
                        const SizedBox(height: AppSizes.spacingMd),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          child: _showExplanation
                              ? AnimatedOpacity(
                                  duration: const Duration(milliseconds: 300),
                                  opacity: _showExplanation ? 1.0 : 0.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.info.withOpacity(0.15),
                                          AppColors.info.withOpacity(0.05),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                                      border: Border.all(
                                        color: AppColors.info.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(AppSizes.paddingLg),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: AppColors.info.withOpacity(0.2),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.lightbulb_outline,
                                                  color: AppColors.info,
                                                  size: 20,
                                                ),
                                              ),
                                              const SizedBox(width: AppSizes.spacingMd),
                                              Text(
                                                AppStrings.explanation,
                                                style: AppTextStyles.titleMedium.copyWith(
                                                  color: AppColors.info,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: AppSizes.spacingMd),
                                          Container(
                                            padding: const EdgeInsets.all(AppSizes.paddingMd),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.7),
                                              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                                            ),
                                            child: Text(
                                              question.explanation,
                                              style: AppTextStyles.explanationText.copyWith(
                                                height: 1.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),

                // Boutons de navigation
                Container(
                  padding: const EdgeInsets.all(AppSizes.paddingMd),
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: _showExplanation
                        ? CustomButton(
                            text: provider.isLastQuestion
                                ? AppStrings.finish
                                : AppStrings.nextQuestion,
                            onPressed: provider.isLastQuestion
                                ? _finishQuiz
                                : _nextQuestion,
                            icon: provider.isLastQuestion
                                ? Icons.check
                                : Icons.arrow_forward,
                          )
                        : const CustomButton(
                            text: AppStrings.selectAnswer,
                            onPressed: null,
                            backgroundColor: AppColors.textTertiary,
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
