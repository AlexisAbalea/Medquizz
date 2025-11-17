import 'package:flutter/material.dart';
import 'package:hippoquiz/core/constants/app_colors.dart';
import 'package:hippoquiz/core/constants/app_sizes.dart';
import 'package:hippoquiz/core/constants/app_strings.dart';
import 'package:hippoquiz/core/constants/app_text_styles.dart';
import 'package:hippoquiz/core/services/sound_service.dart';
import 'package:hippoquiz/core/widgets/custom_button.dart';
import 'package:hippoquiz/data/models/quiz_session_model.dart';
import 'package:hippoquiz/presentation/providers/quiz_provider.dart';
import 'package:hippoquiz/presentation/screens/category_selection_screen.dart';
import 'package:hippoquiz/presentation/screens/dashboard_screen.dart';
import 'package:provider/provider.dart';

class QuizResultScreen extends StatefulWidget {
  final QuizSessionModel session;

  const QuizResultScreen({
    super.key,
    required this.session,
  });

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  final SoundService _soundService = SoundService();

  @override
  void initState() {
    super.initState();
    // Play end sound when result screen is displayed
    _soundService.playEndSound();
  }

  Color _getScoreColor(double percentage) {
    if (percentage >= 80) return AppColors.success;
    if (percentage >= 60) return AppColors.info;
    if (percentage >= 40) return AppColors.warning;
    return AppColors.error;
  }

  IconData _getScoreIcon(double percentage) {
    if (percentage >= 80) return Icons.emoji_events;
    if (percentage >= 60) return Icons.thumb_up;
    if (percentage >= 40) return Icons.trending_up;
    return Icons.refresh;
  }

  @override
  Widget build(BuildContext context) {
    final percentage = widget.session.percentage;
    final scoreColor = _getScoreColor(percentage);
    final motivationalMessage = AppStrings.getMotivationalMessage(percentage);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.results),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.paddingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icône et score
              Icon(
                _getScoreIcon(percentage),
                size: AppSizes.iconXxxl,
                color: scoreColor,
              ),
              const SizedBox(height: AppSizes.spacingLg),

              // Score principal
              Text(
                AppStrings.yourScore,
                style: AppTextStyles.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spacingSm),
              Text(
                '${widget.session.score}/${widget.session.totalQuestions}',
                style: AppTextStyles.score.copyWith(color: scoreColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spacingSm),
              Text(
                motivationalMessage,
                style: AppTextStyles.headlineSmall.copyWith(
                  color: scoreColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spacingXl),

              // Statistiques détaillées
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingLg),
                  child: Column(
                    children: [
                      _StatRow(
                        label: AppStrings.totalQuestions,
                        value: widget.session.totalQuestions.toString(),
                        icon: Icons.quiz,
                      ),
                      const Divider(),
                      _StatRow(
                        label: AppStrings.correctAnswers,
                        value: widget.session.score.toString(),
                        icon: Icons.check_circle,
                        valueColor: AppColors.success,
                      ),
                      const Divider(),
                      _StatRow(
                        label: 'Réponses incorrectes',
                        value:
                            (widget.session.totalQuestions - widget.session.score)
                                .toString(),
                        icon: Icons.cancel,
                        valueColor: AppColors.error,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spacingXl),

              // Boutons d'action
              CustomButton(
                text: AppStrings.backToDashboard,
                icon: Icons.home,
                onPressed: () {
                  // Réinitialiser le quiz et retourner au dashboard
                  context.read<QuizProvider>().resetQuiz();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const DashboardScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: AppSizes.spacingMd),
              CustomButton(
                text: 'Nouveau quiz',
                icon: Icons.refresh,
                isOutlined: true,
                onPressed: () {
                  // Réinitialiser le quiz et aller à la sélection de catégorie
                  context.read<QuizProvider>().resetQuiz();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const CategorySelectionScreen(),
                    ),
                    (route) => route.isFirst,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;

  const _StatRow({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spacingSm),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.textSecondary,
            size: AppSizes.iconMd,
          ),
          const SizedBox(width: AppSizes.spacingMd),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyLarge,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.titleLarge.copyWith(
              color: valueColor ?? AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
