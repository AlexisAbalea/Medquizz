import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2E7D99);
  static const Color primaryLight = Color(0xFF4A9BB5);
  static const Color primaryDark = Color(0xFF1F5A6F);
  static const Color secondary = Color(0xFF4CAF50);
  static const Color secondaryLight = Color(0xFF6FBF73);
  static const Color secondaryDark = Color(0xFF388E3C);
  static const Color accent = Color(0xFFFF9800);
  static const Color accentLight = Color(0xFFFFAB40);
  static const Color accentDark = Color(0xFFF57C00);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  static const Color difficultyEasy = Color(0xFF4CAF50);
  static const Color difficultyMedium = Color(0xFFFF9800);
  static const Color difficultyHard = Color(0xFFF44336);
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFEEEEEE);
  static const Color categoryAnatomy = Color(0xFFE91E63);
  static const Color categoryPhysiology = Color(0xFF2196F3);
  static const Color categoryBiochemistry = Color(0xFF4CAF50);
  static const Color categoryCell = Color(0xFFFF9800);
  static const Color categoryPharmacology = Color(0xFF9C27B0);
  static const Color categoryPathology = Color(0xFFF44336);
  static const Color categoryImmunology = Color(0xFF00BCD4);
  static const Color categoryMicrobiology = Color(0xFF8BC34A);
  static const Color categorySemiology = Color(0xFF3F51B5);
  static const Color categoryCardiology = Color(0xFFE91E63);
  static const Color categoryNeurology = Color(0xFF673AB7);
  static const Color categoryRadiology = Color(0xFF607D8B);
  static const Color yearL1 = Color(0xFF4CAF50);
  static const Color yearL2 = Color(0xFF2196F3);
  static const Color yearL3 = Color(0xFF9C27B0);
  static const Color overlay = Color(0x80000000);
  static const Color shadow = Color(0x1A000000);

  static Color getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'facile':
        return difficultyEasy;
      case 'moyen':
        return difficultyMedium;
      case 'difficile':
        return difficultyHard;
      default:
        return textSecondary;
    }
  }

  static Color getYearColor(String year) {
    switch (year.toUpperCase()) {
      case 'L1':
        return yearL1;
      case 'L2':
        return yearL2;
      case 'L3':
        return yearL3;
      default:
        return primary;
    }
  }

  static Color getCategoryColor(String categoryName) {
    final colorMap = {
      'anatomie': categoryAnatomy,
      'physiologie': categoryPhysiology,
      'biochimie': categoryBiochemistry,
      'biologie cellulaire': categoryCell,
      'pharmacologie': categoryPharmacology,
      'pathologie': categoryPathology,
      'immunologie': categoryImmunology,
      'microbiologie': categoryMicrobiology,
      'sémiologie': categorySemiology,
      'cardiologie': categoryCardiology,
      'neurologie': categoryNeurology,
      'radiologie': categoryRadiology,
    };

    return colorMap[categoryName.toLowerCase()] ?? primary;
  }
}
