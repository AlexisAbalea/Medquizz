import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medquizz_pass/core/constants/app_colors.dart';

class AppTextStyles {
  // Display - Très grands titres
  static TextStyle displayLarge = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle displayMedium = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle displaySmall = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Headline - Titres de sections
  static TextStyle headlineLarge = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineMedium = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineSmall = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Title - Titres de cartes et widgets
  static TextStyle titleLarge = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle titleMedium = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle titleSmall = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  // Body - Texte de corps
  static TextStyle bodyLarge = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle bodyMedium = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle bodySmall = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // Label - Libellés et étiquettes
  static TextStyle labelLarge = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle labelMedium = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle labelSmall = GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  // Styles personnalisés pour l'application

  // Boutons
  static TextStyle buttonLarge = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle buttonMedium = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle buttonSmall = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Badges et chips
  static TextStyle badge = GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Questions de quiz
  static TextStyle questionText = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  // Réponses de quiz
  static TextStyle answerText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  // Explications
  static TextStyle explanationText = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.6,
    fontStyle: FontStyle.italic,
  );

  // Statistiques - grands nombres
  static TextStyle statNumber = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  // Statistiques - labels
  static TextStyle statLabel = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  // Catégories
  static TextStyle categoryName = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Nombre de questions
  static TextStyle questionCount = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // Messages d'erreur
  static TextStyle errorText = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
  );

  // Messages de succès
  static TextStyle successText = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.success,
  );

  // Timer
  static TextStyle timer = GoogleFonts.robotoMono(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Score
  static TextStyle score = GoogleFonts.poppins(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  // Pourcentage
  static TextStyle percentage = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );
}
