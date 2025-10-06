import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medquizz_pass/core/constants/app_colors.dart';
import 'package:medquizz_pass/core/constants/app_sizes.dart';
import 'package:medquizz_pass/core/constants/app_text_styles.dart';
import 'package:medquizz_pass/core/widgets/custom_button.dart';
import 'package:medquizz_pass/core/widgets/custom_card.dart';
import 'package:medquizz_pass/presentation/providers/student_provider.dart';
import 'package:medquizz_pass/presentation/providers/category_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _selectedYear;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final studentProvider = context.read<StudentProvider>();
    _selectedYear = studentProvider.currentStudent?.yearLevel;
  }

  Future<void> _saveSettings() async {
    if (_selectedYear == null) return;

    final studentProvider = context.read<StudentProvider>();
    final currentStudent = studentProvider.currentStudent;

    if (currentStudent == null) return;

    // Si le niveau n'a pas changé, on ne fait rien
    if (_selectedYear == currentStudent.yearLevel) {
      Navigator.pop(context);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Mettre à jour le niveau de l'étudiant
      await studentProvider.updateStudent(currentStudent.name, _selectedYear!);

      // Recharger les catégories pour le nouveau niveau
      if (mounted) {
        await context.read<CategoryProvider>().loadCategoriesByYear(_selectedYear!);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Paramètres enregistrés avec succès'),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section Profil
            Text(
              'Profil',
              style: AppTextStyles.headlineSmall,
            ),
            const SizedBox(height: AppSizes.spacingMd),

            // Carte Niveau d'études
            CustomCard(
              padding: const EdgeInsets.all(AppSizes.paddingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.school,
                        color: AppColors.primary,
                        size: AppSizes.iconMd,
                      ),
                      const SizedBox(width: AppSizes.spacingSm),
                      Text(
                        'Niveau d\'études',
                        style: AppTextStyles.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacingMd),
                  Text(
                    'Sélectionnez votre année',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingMd),

                  // Options de niveau
                  ..._buildYearOptions(),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.spacingXl),

            // Bouton Enregistrer
            CustomButton(
              text: 'Enregistrer les modifications',
              icon: Icons.save,
              onPressed: _isLoading ? null : _saveSettings,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildYearOptions() {
    const years = ['L1', 'L2', 'L3'];

    return years.map((year) {
      final isSelected = _selectedYear == year;
      final color = AppColors.getYearColor(year);

      return Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.spacingSm),
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedYear = year;
            });
          },
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          child: Container(
            padding: const EdgeInsets.all(AppSizes.paddingMd),
            decoration: BoxDecoration(
              color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
              border: Border.all(
                color: isSelected ? color : AppColors.border,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? color : AppColors.border,
                      width: 2,
                    ),
                    color: isSelected ? color : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 14,
                          color: Colors.white,
                        )
                      : null,
                ),
                const SizedBox(width: AppSizes.spacingMd),
                Text(
                  year,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: isSelected ? color : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const SizedBox(width: AppSizes.spacingSm),
                Text(
                  _getYearDescription(year),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  String _getYearDescription(String year) {
    switch (year) {
      case 'L1':
        return '(Première année)';
      case 'L2':
        return '(Deuxième année)';
      case 'L3':
        return '(Troisième année)';
      default:
        return '';
    }
  }
}
