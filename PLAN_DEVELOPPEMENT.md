# Plan de Développement - HippoQuiz

## 📋 Vue d'ensemble du projet

**Nom:** HippoQuiz
**Description:** Application mobile Flutter permettant aux étudiants en médecine (L1 à L3) de s'entraîner avec des quiz interactifs.
**Technologies:** Flutter, SQLite, Architecture Clean

---

## 🏗️ Architecture de l'application

### Structure des dossiers

```
lib/
├── core/
│   ├── constants/        # Constantes globales (couleurs, textes, etc.)
│   ├── theme/           # Thème de l'application
│   ├── utils/           # Utilitaires et helpers
│   └── widgets/         # Widgets réutilisables globaux
├── data/
│   ├── datasources/     # Sources de données (SQLite)
│   ├── models/          # Modèles de données
│   └── repositories/    # Implémentation des repositories
├── domain/
│   ├── entities/        # Entités métier
│   └── repositories/    # Interfaces des repositories
├── presentation/
│   ├── screens/         # Écrans de l'application
│   ├── widgets/         # Widgets spécifiques aux écrans
│   └── providers/       # State management (Provider/Riverpod)
└── main.dart
```

---

## 📊 Modèle de données

### Tables SQLite

#### 1. **students**

- `id` (INTEGER PRIMARY KEY)
- `name` (TEXT)
- `year_level` (TEXT) - L1, L2, ou L3
- `created_at` (TIMESTAMP)

#### 2. **categories**

- `id` (INTEGER PRIMARY KEY)
- `name` (TEXT) - Ex: Anatomie, Physiologie, Pharmacologie
- `year_level` (TEXT) - L1, L2, L3
- `icon` (TEXT) - Nom de l'icône
- `color` (TEXT) - Couleur hexadécimale

#### 3. **questions**

- `id` (INTEGER PRIMARY KEY)
- `category_id` (INTEGER FOREIGN KEY)
- `year_level` (TEXT)
- `question_text` (TEXT)
- `difficulty` (TEXT) - Facile, Moyen, Difficile
- `explanation` (TEXT) - Explication de la bonne réponse

#### 4. **answers**

- `id` (INTEGER PRIMARY KEY)
- `question_id` (INTEGER FOREIGN KEY)
- `answer_text` (TEXT)
- `is_correct` (BOOLEAN)

#### 5. **user_progress**

- `id` (INTEGER PRIMARY KEY)
- `student_id` (INTEGER FOREIGN KEY)
- `question_id` (INTEGER FOREIGN KEY)
- `is_correct` (BOOLEAN)
- `answered_at` (TIMESTAMP)

#### 6. **quiz_sessions**

- `id` (INTEGER PRIMARY KEY)
- `student_id` (INTEGER FOREIGN KEY)
- `category_id` (INTEGER FOREIGN KEY)
- `score` (INTEGER)
- `total_questions` (INTEGER)
- `started_at` (TIMESTAMP)
- `completed_at` (TIMESTAMP)

---

## 🎨 Design et UI/UX

### Palette de couleurs moderne

- **Primaire:** Bleu médical (#2E7D99)
- **Secondaire:** Vert succès (#4CAF50)
- **Accent:** Orange (#FF9800)
- **Erreur:** Rouge (#F44336)
- **Fond:** Blanc cassé (#FAFAFA)
- **Texte:** Gris foncé (#212121)

### Écrans principaux

1. **Splash Screen** - Logo et chargement
2. **Onboarding** - Introduction pour nouveaux utilisateurs
3. **Profil Setup** - Choix du nom et de l'année (L1/L2/L3)
4. **Home/Dashboard** - Vue d'ensemble avec statistiques
5. **Sélection de catégorie** - Liste des matières par année
6. **Quiz** - Questions avec réponses multiples
7. **Résultats** - Score et analyse détaillée
8. **Statistiques** - Progression globale et par matière
9. **Paramètres** - Préférences utilisateur

---

## 📝 Étapes de développement

### **PHASE 1: Configuration initiale (Jour 1)**

#### Étape 1.1: Initialiser le projet Flutter

```bash
flutter create hippoquiz
cd hippoquiz
```

#### Étape 1.2: Configurer pubspec.yaml

Ajouter les dépendances:

- `sqflite` - Base de données SQLite
- `path_provider` - Gestion des chemins de fichiers
- `provider` ou `riverpod` - State management
- `google_fonts` - Polices modernes
- `flutter_svg` - Icônes SVG
- `shared_preferences` - Stockage local
- `intl` - Internationalisation et formatage dates
- `fl_chart` - Graphiques pour statistiques
- `shimmer` - Effet de chargement
- `lottie` - Animations

#### Étape 1.3: Créer l'architecture des dossiers

Créer tous les dossiers selon la structure définie ci-dessus.

---

### **PHASE 2: Configuration de la base de données (Jour 1-2)**

#### Étape 2.1: Créer le Database Helper

- Fichier: `lib/data/datasources/database_helper.dart`
- Singleton pour gérer la connexion SQLite
- Méthodes pour créer/mettre à jour les tables
- Version de la base de données

#### Étape 2.2: Créer les modèles de données

- `lib/data/models/student_model.dart`
- `lib/data/models/category_model.dart`
- `lib/data/models/question_model.dart`
- `lib/data/models/answer_model.dart`
- `lib/data/models/user_progress_model.dart`
- `lib/data/models/quiz_session_model.dart`

Chaque modèle doit inclure:

- `fromMap()` - Convertir depuis SQLite
- `toMap()` - Convertir vers SQLite
- `fromJson()` / `toJson()` - Sérialisation

#### Étape 2.3: Pré-remplir la base de données

- Créer un fichier `lib/data/datasources/seed_data.dart`
- Insérer des données de test (minimum 50 questions par année)
- Questions variées par catégorie et difficulté

---

### **PHASE 3: Couche Domain et Repositories (Jour 2)**

#### Étape 3.1: Créer les entités

- Versions "propres" des modèles dans `lib/domain/entities/`
- Sans logique de persistence

#### Étape 3.2: Créer les interfaces de repositories

- `lib/domain/repositories/student_repository.dart`
- `lib/domain/repositories/question_repository.dart`
- `lib/domain/repositories/quiz_repository.dart`
- `lib/domain/repositories/progress_repository.dart`

#### Étape 3.3: Implémenter les repositories

Dans `lib/data/repositories/`:

- Implémentation concrète avec SQLite
- Gestion des erreurs
- Conversion modèles ↔ entités

---

### **PHASE 4: State Management (Jour 3)**

#### Étape 4.1: Configurer Provider/Riverpod

- Setup dans `main.dart`
- Créer les providers principaux

#### Étape 4.2: Créer les providers/notifiers

- `student_provider.dart` - Gestion du profil étudiant
- `quiz_provider.dart` - Gestion de l'état du quiz
- `progress_provider.dart` - Statistiques et progression
- `category_provider.dart` - Gestion des catégories

---

### **PHASE 5: Thème et Design System (Jour 3)**

#### Étape 5.1: Créer le thème

- `lib/core/theme/app_theme.dart`
- ThemeData personnalisé avec Material 3
- Mode clair uniquement (ou ajouter mode sombre)

#### Étape 5.2: Définir les constantes

- `lib/core/constants/app_colors.dart`
- `lib/core/constants/app_text_styles.dart`
- `lib/core/constants/app_sizes.dart`
- `lib/core/constants/app_strings.dart`

#### Étape 5.3: Créer les widgets réutilisables

- `custom_button.dart` - Boutons personnalisés
- `custom_card.dart` - Cartes avec ombre et radius
- `loading_indicator.dart` - Indicateur de chargement
- `answer_option_card.dart` - Carte pour les réponses
- `progress_bar.dart` - Barre de progression
- `stat_card.dart` - Carte de statistique

---

### **PHASE 6: Écrans - Onboarding et Setup (Jour 4)**

#### Étape 6.1: Splash Screen

- Animation du logo
- Chargement de la base de données
- Navigation automatique

#### Étape 6.2: Onboarding

- 3-4 slides explicatifs avec PageView
- Skip/Next navigation
- Animations Lottie ou illustrations

#### Étape 6.3: Profil Setup

- Formulaire de saisie du nom
- Sélection de l'année (L1/L2/L3) avec cards
- Validation et sauvegarde dans SQLite

---

### **PHASE 7: Écran principal - Dashboard (Jour 4-5)**

#### Étape 7.1: Layout du Dashboard

- AppBar avec nom de l'utilisateur
- Section "Mes statistiques" avec cartes:
  - Questions réussies
  - Taux de réussite
  - Streak (jours consécutifs)
- Section "Continuer" - Dernière catégorie
- Bouton principal "Nouveau Quiz"

#### Étape 7.2: Intégrer les données

- Charger les statistiques depuis SQLite
- Affichage dynamique
- Pull-to-refresh

---

### **PHASE 8: Sélection de catégorie (Jour 5)**

#### Étape 8.1: Écran de catégories

- Grid/List de catégories filtrées par année
- Chaque carte affiche:
  - Icône de la catégorie
  - Nom
  - Nombre de questions
  - Progression (%)

#### Étape 8.2: Navigation

- Tap sur une catégorie → Écran de configuration du quiz
- Choix de la difficulté (optionnel)
- Nombre de questions

---

### **PHASE 9: Écran de Quiz (Jour 6-7)**

#### Étape 9.1: UI du Quiz

- Barre de progression en haut
- Numéro de la question
- Texte de la question (scrollable si long)
- Liste des réponses (4 options)
- Boutons: Précédent, Suivant, Terminer

#### Étape 9.2: Logique du Quiz

- Chargement aléatoire des questions
- Sélection d'une réponse
- Validation (couleur verte/rouge)
- Affichage de l'explication après réponse
- Navigation entre questions
- Timer optionnel

#### Étape 9.3: Animations

- Transition entre questions
- Feedback visuel lors de la sélection
- Shake animation si erreur

---

### **PHASE 10: Écran de Résultats (Jour 7)**

#### Étape 10.1: Vue d'ensemble

- Score final avec animation
- Pourcentage de réussite
- Message motivant selon le score
- Badge de performance

#### Étape 10.2: Détails par question

- Liste expansible des questions
- Réponse donnée vs correcte
- Explication complète

#### Étape 10.3: Actions

- Revoir les questions ratées
- Nouveau quiz dans la même catégorie
- Retour au dashboard

---

### **PHASE 11: Statistiques et Progression (Jour 8)**

#### Étape 11.1: Écran de statistiques

- Vue par catégorie avec graphiques
- Graphique en ligne: progression dans le temps
- Graphique circulaire: répartition par matière
- Utiliser `fl_chart` pour les graphiques

#### Étape 11.2: Historique des sessions

- Liste des quiz passés
- Date, score, catégorie
- Possibilité de revoir les détails

---

### **PHASE 12: Paramètres et Profil (Jour 8)**

#### Étape 12.1: Écran de paramètres

- Modifier le profil (nom, année)
- Réinitialiser la progression
- À propos de l'app
- Version

#### Étape 12.2: Gestion du profil

- Changer d'année → recharger les catégories
- Confirmation avant réinitialisation

---

### **PHASE 13: Polissage et Optimisation (Jour 9)**

#### Étape 13.1: Performance

- Optimiser les requêtes SQLite (indexes)
- Lazy loading des questions
- Cache des images/icônes

#### Étape 13.2: UX/UI

- Transitions fluides
- Micro-animations
- Haptic feedback
- States vides (empty states)
- Gestion des erreurs

#### Étape 13.3: Accessibilité

- Taille de police ajustable
- Contraste suffisant
- Support des lecteurs d'écran

---

### **PHASE 14: Tests et Debug (Jour 10)**

#### Étape 14.1: Tests unitaires

- Tests des repositories
- Tests des providers
- Tests des modèles

#### Étape 14.2: Tests d'intégration

- Flow complet: setup → quiz → résultats
- Navigation entre écrans

#### Étape 14.3: Tests manuels

- Tester sur différents appareils
- Android et iOS
- Différentes tailles d'écran

---

### **PHASE 15: Préparation au déploiement (Jour 11)**

#### Étape 15.1: Configuration Android

- `android/app/build.gradle` - Version, nom du package
- Icône de l'application
- Splash screen natif
- Permissions

#### Étape 15.2: Configuration iOS

- `ios/Runner/Info.plist`
- Icône et launch screen
- Bundle identifier

#### Étape 15.3: Build

- `flutter build apk --release`
- `flutter build ios --release`

---

## 🎯 Fonctionnalités avancées (Bonus)

### À ajouter après la V1:

1. **Mode révision espacée** - Algorithme de répétition espacée
2. **Mode challenge** - Quiz contre la montre
3. **Favoris** - Marquer des questions pour révision
4. **Notes personnelles** - Ajouter des notes sur les questions
5. **Partage de score** - Partager sur les réseaux sociaux
6. **Mode hors ligne** - Tout fonctionne sans internet
7. **Notifications** - Rappels de révision
8. **Mode sombre**
9. **Synchronisation cloud** - Backup Firebase (optionnel)
10. **Multi-profils** - Plusieurs étudiants sur un appareil

---

## 📦 Dépendances principales

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Database
  sqflite: ^2.3.0
  path_provider: ^2.1.1
  path: ^1.8.3

  # State Management
  provider: ^6.1.1
  # OU riverpod: ^2.4.9

  # UI/UX
  google_fonts: ^6.1.0
  flutter_svg: ^2.0.9
  lottie: ^2.7.0
  shimmer: ^3.0.0
  fl_chart: ^0.65.0

  # Utilities
  shared_preferences: ^2.2.2
  intl: ^0.18.1
  equatable: ^2.0.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  mockito: ^5.4.4
```

---

## ✅ Checklist finale avant lancement

- [ ] Toutes les fonctionnalités core sont implémentées
- [ ] Au moins 100 questions par année (L1, L2, L3)
- [ ] Tests unitaires passent
- [ ] Tests d'intégration passent
- [ ] Performance fluide (60 FPS)
- [ ] Pas de bugs critiques
- [ ] UI responsive sur tous les écrans
- [ ] Icône et splash screen configurés
- [ ] Build release Android fonctionne
- [ ] Build release iOS fonctionne
- [ ] Documentation du code

---

## 📚 Bonnes pratiques à suivre

1. **Commits Git réguliers** - Petits commits avec messages clairs
2. **Code commenté** - Expliquer la logique complexe
3. **Nommage cohérent** - snake_case pour fichiers, camelCase pour variables
4. **DRY (Don't Repeat Yourself)** - Extraire le code dupliqué
5. **Séparation des responsabilités** - Chaque classe a un seul rôle
6. **Gestion d'erreurs** - Try-catch et messages d'erreur clairs
7. **Optimisation des images** - Utiliser des formats optimisés
8. **Lazy loading** - Charger les données à la demande

---

## 🚀 Timeline estimé

- **Jours 1-2:** Setup + Base de données
- **Jours 3-4:** Architecture + Onboarding
- **Jours 5-7:** Écrans principaux (Quiz, Dashboard)
- **Jours 8-9:** Statistiques + Polissage
- **Jours 10-11:** Tests + Déploiement

**Total:** 11 jours de développement pour la V1

---

## 📞 Support et maintenance

### Post-lancement:

- Collecter les retours utilisateurs
- Corriger les bugs critiques
- Ajouter des questions régulièrement
- Optimisations basées sur les analytics
- Nouvelles fonctionnalités selon les besoins

---

**Bon développement! 🎓💻**
