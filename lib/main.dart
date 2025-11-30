import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hippoquiz/core/theme/app_theme.dart';
import 'package:hippoquiz/data/datasources/database_helper.dart';
import 'package:hippoquiz/data/datasources/migrations/migration_manager.dart';
import 'package:hippoquiz/data/datasources/seed_data.dart';
import 'package:hippoquiz/data/repositories/category_repository_impl.dart';
import 'package:hippoquiz/data/repositories/progress_repository_impl.dart';
import 'package:hippoquiz/data/repositories/question_repository_impl.dart';
import 'package:hippoquiz/data/repositories/quiz_repository_impl.dart';
import 'package:hippoquiz/data/repositories/student_repository_impl.dart';
import 'package:hippoquiz/presentation/providers/category_provider.dart';
import 'package:hippoquiz/presentation/providers/progress_provider.dart';
import 'package:hippoquiz/presentation/providers/quiz_provider.dart';
import 'package:hippoquiz/presentation/providers/student_provider.dart';
import 'package:hippoquiz/presentation/screens/dashboard_screen.dart';
import 'package:hippoquiz/presentation/screens/profile_setup_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configuration edge-to-edge pour Android 15+ (SDK 35)
  // La configuration native est maintenant gérée dans MainActivity.kt
  // On active juste le mode edgeToEdge côté Flutter
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  // L'initialisation de la BD se fait maintenant dans le SplashScreen
  // pour permettre l'affichage d'un indicateur de progression
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper.instance;

    return MultiProvider(
      providers: [
        Provider(create: (_) => StudentRepositoryImpl(dbHelper)),
        Provider(create: (_) => CategoryRepositoryImpl(dbHelper)),
        Provider(create: (_) => QuestionRepositoryImpl(dbHelper)),
        Provider(create: (_) => QuizRepositoryImpl(dbHelper)),
        Provider(create: (_) => ProgressRepositoryImpl(dbHelper)),
        ChangeNotifierProvider(
          create: (context) => StudentProvider(
            context.read<StudentRepositoryImpl>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(
            context.read<CategoryRepositoryImpl>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => QuizProvider(
            context.read<QuestionRepositoryImpl>(),
            context.read<QuizRepositoryImpl>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ProgressProvider(
            context.read<ProgressRepositoryImpl>(),
            context.read<QuizRepositoryImpl>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'HippoQuiz',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _loadingMessage = 'Initialisation...';

  @override
  void initState() {
    super.initState();
    _initializeAndNavigate();
  }

  Future<void> _initializeAndNavigate() async {
    try {
      // Étape 1 : Initialiser la base de données
      setState(() {
        _loadingMessage = 'Préparation de la base de données...';
      });

      final db = DatabaseHelper.instance;
      final categories = await db.queryAll('categories');
      final questions = await db.queryAll('questions');

      // Initialiser les données de base si nécessaire
      if (categories.isEmpty || questions.isEmpty) {
        setState(() {
          _loadingMessage = 'Chargement des données...';
        });

        await SeedData.initialize();
      }

      // Étape 2 : Exécuter les migrations si nécessaire
      setState(() {
        _loadingMessage = 'Vérification des mises à jour...';
      });

      final migrationManager = MigrationManager(db);
      await migrationManager.runMigrations();

      // Étape 3 : Petite pause pour montrer le logo
      setState(() {
        _loadingMessage = 'Chargement...';
      });
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      // Étape 4 : Vérifier le profil utilisateur
      final studentProvider = context.read<StudentProvider>();
      final hasStudent = await studentProvider.checkIfHasStudent();
      if (!mounted) return;

      if (hasStudent) {
        await studentProvider.loadCurrentStudent();
        if (!mounted) return;

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const DashboardScreen(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const ProfileSetupScreen(),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadingMessage = 'Erreur lors de l\'initialisation';
      });
      // Afficher l'erreur à l'utilisateur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/logo/logo_no_bg.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 24),
            Text(
              'HippoQuiz',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Quiz médical pour étudiants',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                _loadingMessage,
                key: ValueKey<String>(_loadingMessage),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
