import 'package:flutter/material.dart';
import 'package:hippoquiz/core/constants/app_colors.dart';
import 'package:hippoquiz/core/constants/app_sizes.dart';
import 'package:hippoquiz/core/constants/app_text_styles.dart';
import 'package:hippoquiz/core/widgets/custom_button.dart';
import 'package:hippoquiz/core/widgets/custom_card.dart';
import 'package:hippoquiz/presentation/providers/category_provider.dart';
import 'package:hippoquiz/presentation/providers/student_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
        await context
            .read<CategoryProvider>()
            .loadCategoriesByYear(_selectedYear!);
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

  void _showLegalNotice() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mentions légales'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ÉDITEUR DE L\'APPLICATION',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('Nom : HippoQuiz'),
              Text('Éditeur : Monsieur ALEXIS ABALEA'),
              Text('Statut juridique : Auto-entrepreneur'),
              Text('SIRET : 90926936700035'),
              Text('Adresse : 9 rue Saint-Exupéry, Plougastel-Daoulas, France'),
              Text('Email : hippoquiz.app@gmail.com'),
              SizedBox(height: 16),
              Text(
                'HÉBERGEMENT',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                  'Cette application mobile ne dispose pas de serveur d\'hébergement. '
                  'Toutes les données sont stockées localement sur votre appareil.'),
              SizedBox(height: 16),
              Text(
                'PROPRIÉTÉ INTELLECTUELLE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                  'L\'ensemble du contenu de cette application (textes, images, questions, '
                  'design) est la propriété exclusive de Monsieur ALEXIS ABALEA. '
                  'Toute reproduction, distribution ou utilisation sans autorisation est interdite.'),
              SizedBox(height: 16),
              Text(
                'RESPONSABILITÉ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                  'Cette application est fournie à titre éducatif. L\'éditeur ne saurait '
                  'être tenu responsable des erreurs ou omissions dans le contenu des questions. '
                  'Les informations médicales fournies ne remplacent en aucun cas un enseignement '
                  'médical officiel.'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Politique de confidentialité'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'COLLECTE DES DONNÉES',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('HippoQuiz ne collecte AUCUNE donnée personnelle.'),
              SizedBox(height: 8),
              Text('Les seules données enregistrées sont :'),
              Text('• Votre prénom (stocké localement sur votre appareil)'),
              Text('• Votre niveau d\'études (L1, L2 ou L3)'),
              Text('• Vos résultats de quiz et statistiques'),
              SizedBox(height: 8),
              Text(
                  'Ces données sont stockées UNIQUEMENT sur votre appareil et ne sont '
                  'jamais transmises à un serveur externe.'),
              SizedBox(height: 16),
              Text(
                'UTILISATION DES DONNÉES',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('Les données locales sont utilisées exclusivement pour :'),
              Text('• Personnaliser votre expérience'),
              Text('• Sauvegarder votre progression'),
              Text('• Afficher vos statistiques'),
              SizedBox(height: 16),
              Text(
                'PARTAGE DES DONNÉES',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('Aucune donnée n\'est partagée avec des tiers.'),
              Text('Aucune donnée n\'est vendue.'),
              Text('Aucune donnée n\'est transmise à des serveurs externes.'),
              SizedBox(height: 16),
              Text(
                'VOS DROITS (RGPD)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('Vous pouvez à tout moment :'),
              Text('• Supprimer vos données en désinstallant l\'application'),
              Text('• Modifier votre profil dans les paramètres'),
              SizedBox(height: 16),
              Text(
                'COOKIES ET TRACEURS',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                  'Cette application n\'utilise aucun cookie ni outil de tracking/analytics.'),
              SizedBox(height: 16),
              Text(
                'CONTACT',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('Pour toute question : hippoquiz.app@gmail.com'),
              SizedBox(height: 8),
              Text('Dernière mise à jour : Janvier 2025'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _showTermsOfService() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Conditions d\'utilisation'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ACCEPTATION DES CONDITIONS',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                  'En utilisant HippoQuiz, vous acceptez les présentes conditions d\'utilisation. '
                  'Si vous n\'acceptez pas ces conditions, veuillez ne pas utiliser l\'application.'),
              SizedBox(height: 16),
              Text(
                'OBJET DE L\'APPLICATION',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                  'HippoQuiz est une application éducative destinée aux étudiants en médecine '
                  '(PASS L1 à L3) pour s\'entraîner aux QCM. Elle est fournie gratuitement '
                  'à des fins pédagogiques.'),
              SizedBox(height: 16),
              Text(
                'UTILISATION AUTORISÉE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('Vous vous engagez à :'),
              Text(
                  '• Utiliser l\'application uniquement à des fins personnelles et éducatives'),
              Text('• Ne pas copier, distribuer ou modifier le contenu'),
              Text(
                  '• Ne pas tenter de décompiler ou reverse-engineer l\'application'),
              Text('• Ne pas utiliser l\'application à des fins commerciales'),
              SizedBox(height: 16),
              Text(
                'CONTENU ET EXACTITUDE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                  'L\'éditeur s\'efforce de fournir un contenu exact et à jour, mais ne garantit pas :'),
              Text('• L\'exhaustivité des informations'),
              Text('• L\'absence d\'erreurs dans les questions'),
              Text('• L\'adéquation avec les programmes officiels'),
              SizedBox(height: 8),
              Text(
                  'Les utilisateurs sont invités à vérifier les informations et à signaler '
                  'toute erreur à : hippoquiz.app@gmail.com'),
              SizedBox(height: 16),
              Text(
                'LIMITATION DE RESPONSABILITÉ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('L\'éditeur ne peut être tenu responsable :'),
              Text('• Des résultats académiques des utilisateurs'),
              Text('• Des erreurs ou omissions dans le contenu'),
              Text('• Des interruptions de service'),
              Text(
                  '• De la perte de données due à un dysfonctionnement de l\'appareil'),
              SizedBox(height: 16),
              Text(
                'PROPRIÉTÉ INTELLECTUELLE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                  'Tous les contenus de l\'application (questions, textes, design, graphismes) '
                  'sont protégés par le droit d\'auteur et appartiennent à Monsieur ALEXIS ABALEA.'),
              SizedBox(height: 16),
              Text(
                'MODIFICATION DES CONDITIONS',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                  'L\'éditeur se réserve le droit de modifier ces conditions à tout moment. '
                  'Les utilisateurs seront informés des modifications majeures.'),
              SizedBox(height: 16),
              Text(
                'LOI APPLICABLE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                  'Les présentes conditions sont régies par le droit français.'),
              SizedBox(height: 8),
              Text('Dernière mise à jour : Janvier 2025'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  Future<void> _contactSupport() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'hippoquiz.app@gmail.com',
      query: 'subject=Contact depuis HippoQuiz&body=Bonjour,\n\n',
    );

    try {
      final canLaunch = await canLaunchUrl(emailUri);
      if (canLaunch) {
        await launchUrl(
          emailUri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Aucune application mail trouvée. Veuillez installer Gmail ou une autre app mail.'),
              backgroundColor: AppColors.error,
              duration: Duration(seconds: 4),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de l\'ouverture: $e'),
            backgroundColor: AppColors.error,
            duration: const Duration(seconds: 4),
          ),
        );
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
                      const Icon(
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

            const SizedBox(height: AppSizes.spacingXl),

            // Section Contact
            Text(
              'Support',
              style: AppTextStyles.headlineSmall,
            ),
            const SizedBox(height: AppSizes.spacingMd),

            // Carte Contact
            CustomCard(
              padding: const EdgeInsets.all(AppSizes.paddingMd),
              child: InkWell(
                onTap: _contactSupport,
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingSm),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSizes.paddingSm),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusMd),
                        ),
                        child: const Icon(
                          Icons.mail_outline,
                          color: AppColors.primary,
                          size: AppSizes.iconMd,
                        ),
                      ),
                      const SizedBox(width: AppSizes.spacingMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nous contacter',
                              style: AppTextStyles.titleMedium,
                            ),
                            const SizedBox(height: AppSizes.spacingXs),
                            Text(
                              'Envoyez-nous vos questions ou suggestions',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSizes.spacingMd),

            // Carte Mentions légales
            CustomCard(
              padding: const EdgeInsets.all(AppSizes.paddingMd),
              child: InkWell(
                onTap: _showLegalNotice,
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingSm),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSizes.paddingSm),
                        decoration: BoxDecoration(
                          color: AppColors.textSecondary.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusMd),
                        ),
                        child: const Icon(
                          Icons.description_outlined,
                          color: AppColors.textSecondary,
                          size: AppSizes.iconMd,
                        ),
                      ),
                      const SizedBox(width: AppSizes.spacingMd),
                      Expanded(
                        child: Text(
                          'Mentions légales',
                          style: AppTextStyles.titleMedium,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSizes.spacingMd),

            // Carte Politique de confidentialité
            CustomCard(
              padding: const EdgeInsets.all(AppSizes.paddingMd),
              child: InkWell(
                onTap: _showPrivacyPolicy,
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingSm),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSizes.paddingSm),
                        decoration: BoxDecoration(
                          color: AppColors.textSecondary.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusMd),
                        ),
                        child: const Icon(
                          Icons.privacy_tip_outlined,
                          color: AppColors.textSecondary,
                          size: AppSizes.iconMd,
                        ),
                      ),
                      const SizedBox(width: AppSizes.spacingMd),
                      Expanded(
                        child: Text(
                          'Politique de confidentialité',
                          style: AppTextStyles.titleMedium,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSizes.spacingMd),

            // Carte CGU
            CustomCard(
              padding: const EdgeInsets.all(AppSizes.paddingMd),
              child: InkWell(
                onTap: _showTermsOfService,
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingSm),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSizes.paddingSm),
                        decoration: BoxDecoration(
                          color: AppColors.textSecondary.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusMd),
                        ),
                        child: const Icon(
                          Icons.gavel_outlined,
                          color: AppColors.textSecondary,
                          size: AppSizes.iconMd,
                        ),
                      ),
                      const SizedBox(width: AppSizes.spacingMd),
                      Expanded(
                        child: Text(
                          'Conditions d\'utilisation',
                          style: AppTextStyles.titleMedium,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
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
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
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
