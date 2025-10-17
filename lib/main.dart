import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hippoquiz/core/theme/app_theme.dart';
import 'package:hippoquiz/data/datasources/database_helper.dart';
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

  // Configuration du mode immersif pour Android
  // Les barres système se cachent automatiquement et réapparaissent au besoin
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );

  // Style des barres système quand elles sont visibles
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );

  await SeedData.initialize();
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
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
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
          ],
        ),
      ),
    );
  }
}
