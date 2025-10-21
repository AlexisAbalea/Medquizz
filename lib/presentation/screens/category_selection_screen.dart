import 'package:flutter/material.dart';
import 'package:hippoquiz/core/constants/app_colors.dart';
import 'package:hippoquiz/core/constants/app_sizes.dart';
import 'package:hippoquiz/core/constants/app_strings.dart';
import 'package:hippoquiz/core/constants/app_text_styles.dart';
import 'package:hippoquiz/core/widgets/loading_indicator.dart';
import 'package:hippoquiz/data/models/category_model.dart';
import 'package:hippoquiz/presentation/providers/category_provider.dart';
import 'package:hippoquiz/presentation/providers/student_provider.dart';
import 'package:hippoquiz/presentation/screens/quiz_screen.dart';
import 'package:provider/provider.dart';

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({super.key});

  @override
  State<CategorySelectionScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  late Map<String, bool> _expandedSections;

  @override
  void initState() {
    super.initState();
    _initializeExpandedSections();
    // Charger les catégories après le premier build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCategories();
    });
  }

  void _initializeExpandedSections() {
    final student = context.read<StudentProvider>().currentStudent;
    final studentYear = student?.yearLevel ?? 'L1';

    // Ouvrir uniquement la section de l'année de l'étudiant
    _expandedSections = {
      'L1': studentYear == 'L1',
      'L2': studentYear == 'L2',
      'L3': studentYear == 'L3',
    };
  }

  Future<void> _loadCategories() async {
    final provider = context.read<CategoryProvider>();
    // Ne recharger que si les catégories ne sont pas déjà chargées
    if (provider.allCategories.isEmpty) {
      await provider.loadAllCategories();
    }
  }

  void _startQuiz(CategoryModel category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizScreen(category: category),
      ),
    );
  }

  void _toggleSection(String yearLevel) {
    setState(() {
      _expandedSections[yearLevel] = !(_expandedSections[yearLevel] ?? false);
    });
  }

  String _getYearFullName(String yearLevel) {
    switch (yearLevel) {
      case 'L1':
        return AppStrings.yearL1Full;
      case 'L2':
        return AppStrings.yearL2Full;
      case 'L3':
        return AppStrings.yearL3Full;
      default:
        return yearLevel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.selectCategory),
        elevation: 0,
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const LoadingIndicator(message: AppStrings.loading);
          }

          final groupedCategories = provider.getCategoriesGroupedByYear();

          if (groupedCategories.values.every((list) => list.isEmpty)) {
            return Center(
              child: Text(
                AppStrings.noCategories,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(AppSizes.paddingMd),
            children: [
              // Section L1 (PASS/L.AS)
              _YearSection(
                yearLevel: 'L1',
                yearTitle: _getYearFullName('L1'),
                categories: groupedCategories['L1'] ?? [],
                isExpanded: _expandedSections['L1'] ?? false,
                onToggle: () => _toggleSection('L1'),
                onCategoryTap: _startQuiz,
                provider: provider,
              ),
              const SizedBox(height: AppSizes.spacingMd),

              // Section L2 (FGSM2)
              _YearSection(
                yearLevel: 'L2',
                yearTitle: _getYearFullName('L2'),
                categories: groupedCategories['L2'] ?? [],
                isExpanded: _expandedSections['L2'] ?? false,
                onToggle: () => _toggleSection('L2'),
                onCategoryTap: _startQuiz,
                provider: provider,
              ),
              const SizedBox(height: AppSizes.spacingMd),

              // Section L3 (FGSM3)
              _YearSection(
                yearLevel: 'L3',
                yearTitle: _getYearFullName('L3'),
                categories: groupedCategories['L3'] ?? [],
                isExpanded: _expandedSections['L3'] ?? false,
                onToggle: () => _toggleSection('L3'),
                onCategoryTap: _startQuiz,
                provider: provider,
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Widget pour afficher une section d'année extensible
class _YearSection extends StatelessWidget {
  final String yearLevel;
  final String yearTitle;
  final List<CategoryModel> categories;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Function(CategoryModel) onCategoryTap;
  final CategoryProvider provider;

  const _YearSection({
    required this.yearLevel,
    required this.yearTitle,
    required this.categories,
    required this.isExpanded,
    required this.onToggle,
    required this.onCategoryTap,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final yearColor = AppColors.getYearColor(yearLevel);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Column(
        children: [
          // En-tête de la section
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingMd,
                vertical: AppSizes.paddingSm,
              ),
              decoration: BoxDecoration(
                color: yearColor.withValues(alpha: 0.1),
                borderRadius: isExpanded
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(AppSizes.radiusLg),
                        topRight: Radius.circular(AppSizes.radiusLg),
                      )
                    : BorderRadius.circular(AppSizes.radiusLg),
              ),
              child: Row(
                children: [
                  // Icône d'expansion
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_right,
                    color: yearColor,
                    size: 28,
                  ),
                  const SizedBox(width: AppSizes.spacingSm),
                  // Titre de l'année
                  Expanded(
                    child: Text(
                      yearTitle,
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: yearColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Badge avec le nombre de matières
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingSm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: yearColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                    ),
                    child: Text(
                      '${categories.length - 1} ${categories.length - 1 > 1 ? 'matières' : 'matière'}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: yearColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Liste des catégories
          if (isExpanded && categories.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingSm),
              child: Column(
                children: categories.map((category) {
                  return _CategoryListItem(
                    category: category,
                    onTap: () => onCategoryTap(category),
                  );
                }).toList(),
              ),
            ),
          // Message si aucune catégorie
          if (isExpanded && categories.isEmpty)
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingMd),
              child: Text(
                'Aucune matière disponible',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Widget pour afficher une catégorie dans la liste
class _CategoryListItem extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const _CategoryListItem({
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.getCategoryColor(category.name);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingSm),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(AppSizes.paddingSm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.08),
                color.withValues(alpha: 0.02),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            children: [
              // Icône de la catégorie
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingXs),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: Icon(
                  Icons.medical_services,
                  size: 28,
                  color: color,
                ),
              ),
              const SizedBox(width: AppSizes.spacingSm),
              // Nom de la catégorie
              Expanded(
                child: Text(
                  category.name,
                  style: AppTextStyles.categoryName.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Flèche
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: color.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
