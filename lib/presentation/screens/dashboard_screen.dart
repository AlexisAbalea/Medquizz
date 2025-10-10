import 'package:flutter/material.dart';
import 'package:hippoquiz/core/constants/app_colors.dart';
import 'package:hippoquiz/core/constants/app_sizes.dart';
import 'package:hippoquiz/core/constants/app_strings.dart';
import 'package:hippoquiz/core/constants/app_text_styles.dart';
import 'package:hippoquiz/core/widgets/custom_button.dart';
import 'package:hippoquiz/core/widgets/loading_indicator.dart';
import 'package:hippoquiz/core/widgets/stat_card.dart';
import 'package:hippoquiz/presentation/providers/category_provider.dart';
import 'package:hippoquiz/presentation/providers/progress_provider.dart';
import 'package:hippoquiz/presentation/providers/student_provider.dart';
import 'package:hippoquiz/presentation/screens/category_selection_screen.dart';
import 'package:hippoquiz/presentation/screens/settings_screen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final studentProvider = context.read<StudentProvider>();
    final categoryProvider = context.read<CategoryProvider>();
    final progressProvider = context.read<ProgressProvider>();

    await studentProvider.loadCurrentStudent();

    if (studentProvider.currentStudent != null) {
      await Future.wait([
        categoryProvider.loadAllCategories(), // Charger toutes les catégories
        categoryProvider.loadCategoriesByYear(
          studentProvider.currentStudent!.yearLevel,
        ),
        progressProvider.loadAllStats(studentProvider.currentStudent!.id!),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.dashboard),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
              // Recharger les données après retour des paramètres
              _loadData();
            },
          ),
        ],
      ),
      body: Consumer3<StudentProvider, CategoryProvider, ProgressProvider>(
        builder:
            (context, studentProvider, categoryProvider, progressProvider, _) {
          if (studentProvider.isLoading) {
            return const LoadingIndicator(message: AppStrings.loading);
          }

          if (studentProvider.currentStudent == null) {
            return const Center(
              child: Text(AppStrings.error),
            );
          }

          final student = studentProvider.currentStudent!;

          return RefreshIndicator(
            onRefresh: _loadData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppSizes.paddingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // En-tête avec nom de l'utilisateur
                  _buildHeader(student.name, student.yearLevel),
                  const SizedBox(height: AppSizes.spacingLg),

                  // Statistiques
                  Text(
                    AppStrings.myStats,
                    style: AppTextStyles.headlineSmall,
                  ),
                  const SizedBox(height: AppSizes.spacingMd),
                  _buildStatsGrid(progressProvider),
                  const SizedBox(height: AppSizes.spacingXl),

                  // Bouton principal
                  CustomButton(
                    text: AppStrings.newQuiz,
                    icon: Icons.play_arrow,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CategorySelectionScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSizes.spacingLg),

                  // Statistiques par matière
                  _buildCategoryStats(categoryProvider, progressProvider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(String name, String year) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Text(
              name[0].toUpperCase(),
              style: AppTextStyles.headlineLarge.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppStrings.welcome}, $name',
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSizes.spacingXs),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingSm,
                    vertical: AppSizes.paddingXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                  child: Text(
                    year,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(ProgressProvider progressProvider) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSizes.spacingMd,
      crossAxisSpacing: AppSizes.spacingMd,
      childAspectRatio: 1.3,
      children: [
        StatCard(
          label: AppStrings.questionsAnswered,
          value: progressProvider.totalQuestions.toString(),
          icon: Icons.quiz,
          color: AppColors.primary,
        ),
        StatCard(
          label: AppStrings.successRate,
          value: '${progressProvider.successRate.toStringAsFixed(0)}%',
          icon: Icons.check_circle,
          color: AppColors.success,
        ),
        StatCard(
          label: AppStrings.currentStreak,
          value: '${progressProvider.currentStreak} ${AppStrings.days}',
          icon: Icons.local_fire_department,
          color: AppColors.accent,
        ),
        StatCard(
          label: AppStrings.completedSessions,
          value: progressProvider.completedSessions.toString(),
          icon: Icons.emoji_events,
          color: AppColors.info,
        ),
      ],
    );
  }

  Widget _buildCategoryStats(
      CategoryProvider categoryProvider, ProgressProvider progressProvider) {
    if (progressProvider.successRatesByCategory.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingLg),
          child: Text(
            'Complétez des quiz pour voir vos statistiques par matière',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // Récupérer toutes les catégories triées par taux de réussite (meilleur au moins bon)
    final allCategoriesStats = progressProvider.getTopCategories(limit: 100);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.analytics, color: AppColors.primary, size: 20),
            const SizedBox(width: AppSizes.spacingSm),
            Text(
              'Vos résultats',
              style: AppTextStyles.headlineSmall,
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spacingMd),

        // Afficher toutes les catégories classées par taux de réussite
        ...allCategoriesStats.asMap().entries.map((mapEntry) {
          final index = mapEntry.key;
          final entry = mapEntry.value;

          // Chercher la catégorie correspondante
          final categoryMatch =
              categoryProvider.allCategories.where((c) => c.id == entry.key);

          // Si la catégorie n'existe pas, on ignore cette entrée
          if (categoryMatch.isEmpty) {
            return const SizedBox.shrink();
          }

          final category = categoryMatch.first;
          final color = AppColors.getCategoryColor(category.name);
          final percentage = entry.value;

          // Déterminer la couleur du badge selon le pourcentage
          Color badgeColor;
          if (percentage >= 80) {
            badgeColor = AppColors.success;
          } else if (percentage >= 60) {
            badgeColor = AppColors.info;
          } else if (percentage >= 40) {
            badgeColor = AppColors.warning;
          } else {
            badgeColor = AppColors.error;
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.spacingSm),
            child: Card(
              child: ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Numéro de classement
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: AppTextStyles.titleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.spacingSm),
                    // Icône de la catégorie
                    CircleAvatar(
                      backgroundColor: color.withOpacity(0.1),
                      radius: 18,
                      child: Icon(Icons.book, color: color, size: 18),
                    ),
                  ],
                ),
                title: Text(
                  category.name,
                  style: AppTextStyles.titleMedium,
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingSm,
                    vertical: AppSizes.paddingXs,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                  child: Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: badgeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
