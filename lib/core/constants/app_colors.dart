import 'package:flutter/material.dart';

class AppColors {
  // Couleurs principales
  static const Color primary = Color(0xFF2E7D99); // Bleu médical
  static const Color primaryLight = Color(0xFF4A9BB5);
  static const Color primaryDark = Color(0xFF1F5A6F);

  // Couleurs secondaires
  static const Color secondary = Color(0xFF4CAF50); // Vert succès
  static const Color secondaryLight = Color(0xFF6FBF73);
  static const Color secondaryDark = Color(0xFF388E3C);

  // Couleurs d'accent
  static const Color accent = Color(0xFFFF9800); // Orange
  static const Color accentLight = Color(0xFFFFAB40);
  static const Color accentDark = Color(0xFFF57C00);

  // Couleurs d'état
  static const Color success = Color(0xFF4CAF50); // Vert
  static const Color error = Color(0xFFF44336); // Rouge
  static const Color warning = Color(0xFFFF9800); // Orange
  static const Color info = Color(0xFF2196F3); // Bleu

  // Couleurs de difficulté
  static const Color difficultyEasy = Color(0xFF4CAF50); // Vert
  static const Color difficultyMedium = Color(0xFFFF9800); // Orange
  static const Color difficultyHard = Color(0xFFF44336); // Rouge

  // Couleurs de fond
  static const Color background = Color(0xFFFAFAFA); // Blanc cassé
  static const Color surface = Color(0xFFFFFFFF); // Blanc
  static const Color surfaceVariant = Color(0xFFF5F5F5); // Gris très clair

  // Couleurs de texte
  static const Color textPrimary = Color(0xFF212121); // Gris foncé
  static const Color textSecondary = Color(0xFF757575); // Gris moyen
  static const Color textTertiary = Color(0xFF9E9E9E); // Gris clair
  static const Color textDisabled = Color(0xFFBDBDBD); // Gris très clair

  // Couleurs des bordures
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFEEEEEE);

  // Couleurs pour les catégories (correspondant aux catégories dans seed_data)
  static const Color categoryAnatomy = Color(0xFFE91E63); // Rose
  static const Color categoryPhysiology = Color(0xFF2196F3); // Bleu
  static const Color categoryBiochemistry = Color(0xFF4CAF50); // Vert
  static const Color categoryCell = Color(0xFFFF9800); // Orange
  static const Color categoryPharmacology = Color(0xFF9C27B0); // Violet
  static const Color categoryPathology = Color(0xFFF44336); // Rouge
  static const Color categoryImmunology = Color(0xFF00BCD4); // Cyan
  static const Color categoryMicrobiology = Color(0xFF8BC34A); // Vert clair
  static const Color categorySemiology = Color(0xFF3F51B5); // Indigo
  static const Color categoryCardiology = Color(0xFFE91E63); // Rose
  static const Color categoryNeurology = Color(0xFF673AB7); // Violet profond
  static const Color categoryRadiology = Color(0xFF607D8B); // Bleu gris

  // Année de niveau
  static const Color yearL1 = Color(0xFF4CAF50); // Vert
  static const Color yearL2 = Color(0xFF2196F3); // Bleu
  static const Color yearL3 = Color(0xFF9C27B0); // Violet

  // Overlay et ombres
  static const Color overlay = Color(0x80000000); // Noir avec opacité
  static const Color shadow = Color(0x1A000000); // Ombre légère

  // Obtenir la couleur selon la difficulté
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

  // Obtenir la couleur selon l'année
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

  // Obtenir la couleur par nom de catégorie
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
