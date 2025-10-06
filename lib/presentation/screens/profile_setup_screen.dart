import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medquizz_pass/core/constants/app_colors.dart';
import 'package:medquizz_pass/core/constants/app_sizes.dart';
import 'package:medquizz_pass/core/constants/app_strings.dart';
import 'package:medquizz_pass/core/constants/app_text_styles.dart';
import 'package:medquizz_pass/core/widgets/custom_button.dart';
import 'package:medquizz_pass/presentation/providers/student_provider.dart';
import 'package:medquizz_pass/presentation/screens/dashboard_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String? _selectedYear;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _createProfile() async {
    if (_formKey.currentState!.validate()) {
      final studentProvider = context.read<StudentProvider>();

      final success = await studentProvider.createStudent(
        _nameController.text.trim(),
        _selectedYear!,
      );

      if (success && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const DashboardScreen(),
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(studentProvider.error ?? AppStrings.somethingWentWrong),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.paddingLg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSizes.spacingXl),
                // Icône
                Icon(
                  Icons.person_add,
                  size: AppSizes.iconXxxl,
                  color: AppColors.primary,
                ),
                const SizedBox(height: AppSizes.spacingLg),
                // Titre
                Text(
                  AppStrings.setupTitle,
                  style: AppTextStyles.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.spacingSm),
                Text(
                  AppStrings.setupSubtitle,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.spacingXl),
                // Champ nom
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.nameLabel,
                    hintText: AppStrings.nameHint,
                    prefixIcon: Icon(Icons.person),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppStrings.nameRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSizes.spacingLg),
                // Sélection de l'année
                Text(
                  AppStrings.yearLabel,
                  style: AppTextStyles.titleMedium,
                ),
                const SizedBox(height: AppSizes.spacingMd),
                _YearSelector(
                  selectedYear: _selectedYear,
                  onYearSelected: (year) {
                    setState(() {
                      _selectedYear = year;
                    });
                  },
                ),
                if (_selectedYear == null && _formKey.currentState?.validate() == false)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSizes.spacingSm),
                    child: Text(
                      AppStrings.yearRequired,
                      style: AppTextStyles.errorText,
                    ),
                  ),
                const SizedBox(height: AppSizes.spacingXl),
                // Bouton continuer
                Consumer<StudentProvider>(
                  builder: (context, provider, _) {
                    return CustomButton(
                      text: AppStrings.continueButton,
                      onPressed: _createProfile,
                      isLoading: provider.isLoading,
                      icon: Icons.arrow_forward,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _YearSelector extends StatelessWidget {
  final String? selectedYear;
  final ValueChanged<String> onYearSelected;

  const _YearSelector({
    required this.selectedYear,
    required this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    final years = [
      AppStrings.yearL1,
      AppStrings.yearL2,
      AppStrings.yearL3,
    ];

    return Row(
      children: years.map((year) {
        final isSelected = selectedYear == year;
        final color = AppColors.getYearColor(year);

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingXs),
            child: GestureDetector(
              onTap: () => onYearSelected(year),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.paddingLg,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? color : color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  border: Border.all(
                    color: color,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.school,
                      color: isSelected ? Colors.white : color,
                      size: AppSizes.iconLg,
                    ),
                    const SizedBox(height: AppSizes.spacingSm),
                    Text(
                      year,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: isSelected ? Colors.white : color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
