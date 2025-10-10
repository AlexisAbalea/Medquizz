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
  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final student = context.read<StudentProvider>().currentStudent;
    if (student != null) {
      await context
          .read<CategoryProvider>()
          .loadCategoriesByYear(student.yearLevel);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.selectCategory),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const LoadingIndicator(message: AppStrings.loading);
          }

          if (provider.categories.isEmpty) {
            return Center(
              child: Text(
                AppStrings.noCategoriesForYear,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(AppSizes.paddingMd),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: AppSizes.spacingMd,
              mainAxisSpacing: AppSizes.spacingMd,
            ),
            itemCount: provider.categories.length,
            itemBuilder: (context, index) {
              final category = provider.categories[index];
              return _CategoryCard(
                category: category,
                onTap: () => _startQuiz(category),
              );
            },
          );
        },
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.getCategoryColor(category.name);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingSm),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icône
                Container(
                  padding: const EdgeInsets.all(AppSizes.paddingSm),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.medical_services,
                    size: AppSizes.iconLg,
                    color: color,
                  ),
                ),
                const SizedBox(height: AppSizes.spacingSm),
                // Nom de la catégorie
                Text(
                  category.name,
                  style: AppTextStyles.categoryName.copyWith(
                    fontSize: 14,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
