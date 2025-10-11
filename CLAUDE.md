# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**HippoQuiz** is a Flutter mobile application for medical students (L1 to L3) to practice with interactive quizzes. The app uses SQLite for local data storage and follows Clean Architecture principles.

## Development Commands

### Running the Application

```bash
flutter run                    # Run on connected device/emulator
flutter run -d chrome          # Run in web browser for testing
```

### Code Quality

```bash
flutter analyze                # Static code analysis
flutter test                   # Run all tests
flutter test test/specific_test.dart  # Run single test file
```

### Building

```bash
flutter build apk --release    # Build Android APK
flutter build ios --release    # Build iOS (requires macOS)
```

### Database Management

The SQLite database is automatically initialized with seed data on first launch via `SeedData.initialize()` in `main.dart`. To reset the database during development, clear the app data or reinstall.

## Architecture

### Clean Architecture Layers

The codebase follows Clean Architecture with clear separation of concerns:

**Data Layer** (`lib/data/`)

- `datasources/database_helper.dart`: Singleton SQLite manager with CRUD operations
- `datasources/seed_data.dart`: Pre-populates 45+ questions across 12 medical categories
- `models/`: Data models with `fromMap()`/`toMap()` for SQLite serialization
- `repositories/`: Concrete implementations of domain repository interfaces

**Domain Layer** (`lib/domain/`)

- `entities/`: Pure business objects without persistence logic
- `repositories/`: Abstract repository interfaces defining data contracts

**Presentation Layer** (`lib/presentation/`)

- `providers/`: State management using Provider pattern (StudentProvider, QuizProvider, CategoryProvider, ProgressProvider)
- `screens/`: Full-page UI components
- `widgets/`: Screen-specific reusable widgets

**Core** (`lib/core/`)

- `constants/`: App-wide constants (colors, text styles, sizes, strings)
- `theme/app_theme.dart`: Material 3 theme with Google Fonts (Poppins)
- `widgets/`: Globally reusable widgets (CustomButton, CustomCard, AnswerOptionCard, etc.)

### Database Schema

Six main tables with foreign key relationships:

- `students`: User profiles with name and year level (L1/L2/L3)
- `categories`: 12 medical subjects (Anatomie, Physiologie, etc.) filtered by year
- `questions`: Quiz questions with difficulty levels and explanations
- `answers`: Multiple choice answers (4 per question) with correctness flag
- `user_progress`: Individual answer history for tracking
- `quiz_sessions`: Completed quiz records with scores

Indexes are created on frequently queried columns (category_id, year_level, student_id) for performance.

### State Management Flow

Provider pattern with ChangeNotifier:

1. **StudentProvider**: Manages current user profile, loads on app start
2. **CategoryProvider**: Loads categories filtered by student's year level, caches question counts
3. **QuizProvider**: Handles quiz lifecycle (start, answer selection, navigation, completion)
4. **ProgressProvider**: Calculates statistics (success rate, streak, session history)

All providers are injected in `main.dart` using MultiProvider and accessed via `context.read<T>()` for mutations or `Consumer<T>` for reactive rebuilds.

### Navigation Flow

```
SplashScreen (checks for existing student)
    ├─> ProfileSetupScreen (if new user)
    │       └─> DashboardScreen
    └─> DashboardScreen (if returning user)
            └─> CategorySelectionScreen
                    └─> QuizScreen (10 random questions)
                            └─> QuizResultScreen
```

The app uses `Navigator.push/pushReplacement` with MaterialPageRoute. Quiz screens prevent back navigation via `PopScope` to avoid losing progress.

### Design System

**Colors** (`app_colors.dart`):

- Dynamic category colors: Each of the 12 categories has a unique color
- Difficulty colors: Green (Facile), Orange (Moyen), Red (Difficile)
- Year level colors: Different colors for L1, L2, L3
- Helper methods: `getCategoryColor()`, `getDifficultyColor()`, `getYearColor()`

**Typography** (`app_text_styles.dart`):

- Material 3 styles using Google Fonts Poppins
- Specialized styles for quiz questions, answers, explanations, scores

**Sizes** (`app_sizes.dart`):

- Consistent spacing (xs, sm, md, lg, xl) and border radius
- Standardized icon and button sizes

**Strings** (`app_strings.dart`):

- All UI text in French
- Helper method: `getMotivationalMessage(percentage)` for score feedback

### Key Widget Patterns

**AnswerOptionCard** has 4 states:

- `normal`: Default state
- `selected`: User has tapped this answer
- `correct`: After validation, shows green with checkmark
- `incorrect`: After validation, shows red with X

**StatCard** displays metrics with icon, value, and label in a consistent format used throughout the dashboard.

## Adding New Questions

Edit `lib/data/datasources/seed_data.dart`:

1. Add questions using `_insertQuestion()` helper:

```dart
await _insertQuestion(
  db,
  categoryId: 1,  // Must match existing category ID
  yearLevel: 'L1',
  questionText: 'Your question here?',
  difficulty: 'Facile',  // or 'Moyen', 'Difficile'
  explanation: 'Detailed explanation...',
  answers: [
    {'text': 'Option A', 'isCorrect': false},
    {'text': 'Option B', 'isCorrect': true},
    {'text': 'Option C', 'isCorrect': false},
    {'text': 'Option D', 'isCorrect': false},
  ],
);
```

2. Questions are loaded automatically on app first run via `SeedData.initialize()` in `main.dart`

## Code Conventions

- **File naming**: `snake_case.dart`
- **Class naming**: `PascalCase`
- **Variables/methods**: `camelCase`
- **Constants**: `camelCase` in constant classes (not SCREAMING_SNAKE_CASE)
- **Models**: Include `fromMap()`, `toMap()`, `copyWith()`, extend `Equatable`
- **Providers**: Expose `isLoading`, `error` states and call `notifyListeners()` after mutations
- **Widgets**: Extract complex UI into private widgets with `_` prefix when used only in one file

## Current Implementation Status

✅ **Completed**:

- Database schema with seed data (45+ questions)
- All data models and repositories
- Provider state management
- Design system (theme, colors, typography)
- Core reusable widgets
- 5 main screens (Setup, Dashboard, Category Selection, Quiz, Results)
- Navigation flow with automatic routing based on user state

⏳ **Not Yet Implemented** (from PLAN_DEVELOPPEMENT.md):

- Onboarding slides
- Settings screen
- Statistics screen with charts (fl_chart)
- Unit and integration tests
- Dark mode
- Advanced features (spaced repetition, favorites, notes, etc.)
