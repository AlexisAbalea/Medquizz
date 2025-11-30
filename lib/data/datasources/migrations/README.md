# Système de Migrations de Base de Données

Ce dossier contient le système de migrations pour la base de données SQLite de HippoQuiz.

## 📁 Structure

```
migrations/
├── README.md                     # Ce fichier
├── migration_manager.dart        # Gestionnaire principal des migrations
├── migrations.dart               # Index des migrations (actuellement vide)
├── migration_2_example.dart      # Exemple de migration
└── migration_X.dart              # Futures migrations
```

## 🎯 Objectif

Le système de migrations permet de :
- ✅ Ajouter de nouvelles questions sans réinstaller l'app
- ✅ Modifier le schéma de la base de données
- ✅ Préserver les données utilisateur (profils, progression, historique)
- ✅ Versionner les changements de données de manière incrémentale

## 🔧 Comment créer une nouvelle migration

### Étape 1 : Créer le fichier de migration

Créez un nouveau fichier `migration_X.dart` (où X est le prochain numéro de version) :

```dart
import 'package:sqflite/sqflite.dart';

/// Migration X : Description de ce que fait cette migration
class MigrationX {
  static Future<void> migrate(Database db) async {
    // Votre code de migration ici

    // Exemple : Ajouter des questions
    await _addQuestion(
      db,
      categoryId: 1,
      yearLevel: 'L1',
      questionText: 'Votre question ici ?',
      difficulty: 'Facile', // ou 'Moyen', 'Difficile'
      explanation: 'Explication détaillée...',
      answers: [
        {'text': 'Option A', 'isCorrect': false},
        {'text': 'Option B', 'isCorrect': true},
        {'text': 'Option C', 'isCorrect': false},
        {'text': 'Option D', 'isCorrect': false},
      ],
    );
  }

  static Future<void> _addQuestion(
    Database db, {
    required int categoryId,
    required String yearLevel,
    required String questionText,
    required String difficulty,
    required String explanation,
    required List<Map<String, dynamic>> answers,
  }) async {
    final questionId = await db.insert('questions', {
      'category_id': categoryId,
      'year_level': yearLevel,
      'question_text': questionText,
      'difficulty': difficulty,
      'explanation': explanation,
    });

    for (var answer in answers) {
      await db.insert('answers', {
        'question_id': questionId,
        'answer_text': answer['text'],
        'is_correct': answer['isCorrect'] ? 1 : 0,
      });
    }
  }
}
```

### Étape 2 : Enregistrer la migration

Dans `migration_manager.dart`, ajoutez votre migration à la map `_migrations` :

```dart
final Map<int, Future<void> Function(Database)> _migrations = {
  2: Migration2.migrate,
  3: Migration3.migrate,
  X: MigrationX.migrate,  // ← Ajoutez votre migration ici
};
```

Et importez votre fichier en haut de `migration_manager.dart` :

```dart
import 'package:hippoquiz/data/datasources/migrations/migration_X.dart';
```

### Étape 3 : Tester

1. Lancez l'application - les migrations se déclenchent automatiquement au démarrage
2. Vérifiez dans les logs que la migration s'est bien exécutée
3. Testez que les nouvelles questions apparaissent dans l'app

## 📝 Obtenir les IDs de catégories

Pour ajouter des questions à une catégorie spécifique, vous devez connaître son ID. Voici comment :

```dart
// Récupérer l'ID d'une catégorie par son nom
final categoriesResult = await db.query(
  'categories',
  where: 'name = ? AND year_level = ?',
  whereArgs: ['Anatomie', 'L1'],
);

if (categoriesResult.isNotEmpty) {
  final categoryId = categoriesResult.first['id'] as int;
  // Utilisez categoryId pour ajouter des questions
}
```

### Liste des catégories disponibles

**L1:**
- Anatomie (id ~1)
- Physiologie (id ~2)
- Biochimie (id ~3)
- Biologie Cellulaire (id ~4)
- Histologie (id ~5)
- Biophysique (id ~6)

**L2:**
- Anatomie détaillée (id ~7)
- Physiologie approfondie (id ~8)
- Pharmacologie (id ~9)
- Pathologie (id ~10)
- Immunologie (id ~11)
- Microbiologie (id ~12)

**L3:**
- Sémiologie (id ~13)
- Cardiologie (id ~14)
- Neurologie (id ~15)
- Radiologie (id ~16)
- Pharmacologie (id ~17)

**Note:** Les IDs peuvent varier. Utilisez toujours une requête pour obtenir l'ID exact.

## 🔄 Fonctionnement interne

1. **Table de versioning:** `database_version` stocke la version actuelle de la DB
2. **Au démarrage de l'app:** `MigrationManager.runMigrations()` est appelé
3. **Vérification:** Compare la version actuelle avec la version cible
4. **Exécution:** Applique toutes les migrations manquantes dans l'ordre
5. **Mise à jour:** Incrémente le numéro de version après chaque migration

## ⚠️ Bonnes pratiques

- ✅ **Ne jamais modifier une migration déjà déployée** - créez-en une nouvelle
- ✅ **Testez toujours sur une copie des données** avant de déployer
- ✅ **Utilisez des transactions** pour les opérations critiques
- ✅ **Documentez** ce que fait chaque migration
- ✅ **Incrémentez la version** de manière séquentielle (2, 3, 4...)
- ❌ **Ne sautez jamais de numéro** de version
- ❌ **N'utilisez pas de migrations destructrices** sans confirmation utilisateur

## 🧪 Exemple complet : Migration 2

Voir [migration_2_example.dart](migration_2_example.dart) pour un exemple fonctionnel d'ajout de nouvelles questions en Anatomie L1.

Pour activer cet exemple :
1. Renommez `migration_2_example.dart` en `migration_2.dart`
2. Importez-le dans `migration_manager.dart`
3. Ajoutez `2: Migration2.migrate` dans la map `_migrations`
4. Relancez l'application

## 🐛 Débogage

Si une migration échoue :
- Vérifiez les logs dans la console (recherchez les emojis 🔄 📦 ✅ ❌)
- La migration s'arrête et l'erreur est affichée
- Corrigez le problème dans le code de migration
- Réinstallez l'app pour réessayer (ou supprimez la DB en développement)

## 📚 Ressources

- [Documentation SQLite](https://www.sqlite.org/docs.html)
- [Package sqflite](https://pub.dev/packages/sqflite)
- [CLAUDE.md](../../../../CLAUDE.md) - Instructions pour Claude Code
