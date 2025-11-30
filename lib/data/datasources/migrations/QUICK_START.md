# Guide Rapide - Ajouter des Questions via Migration

## ⚡ En 3 étapes

### 1️⃣ Créer votre fichier de migration

Créez `migration_2.dart` dans ce dossier :

```dart
import 'package:sqflite/sqflite.dart';

class Migration2 {
  static Future<void> migrate(Database db) async {
    // Récupérer l'ID de votre catégorie
    final cat = await db.query(
      'categories',
      where: 'name = ? AND year_level = ?',
      whereArgs: ['Anatomie', 'L1'],
    );
    final categoryId = cat.first['id'] as int;

    // Ajouter vos questions
    await _addQuestion(
      db,
      categoryId: categoryId,
      yearLevel: 'L1',
      questionText: 'Quelle est votre question ?',
      difficulty: 'Facile',
      explanation: 'Votre explication ici...',
      answers: [
        {'text': 'Réponse A', 'isCorrect': false},
        {'text': 'Réponse B', 'isCorrect': true},
        {'text': 'Réponse C', 'isCorrect': false},
        {'text': 'Réponse D', 'isCorrect': false},
      ],
    );

    // Ajoutez autant de questions que nécessaire
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

### 2️⃣ Enregistrer la migration

Éditez `migration_manager.dart` :

**Ajoutez l'import en haut :**
```dart
import 'package:hippoquiz/data/datasources/migrations/migration_2.dart';
```

**Ajoutez dans la map `_migrations` :**
```dart
final Map<int, Future<void> Function(Database)> _migrations = {
  2: Migration2.migrate,  // ← Ajoutez cette ligne
};
```

### 3️⃣ Testez

```bash
flutter run
```

Vérifiez dans les logs :
```
🔄 Migration de la base de données de v1 vers v2
📦 Application de la migration vers v2...
✅ Migration v2 terminée avec succès
```

## 📋 Catégories disponibles

| Nom | Year | Description |
|-----|------|-------------|
| Anatomie | L1 | Structure du corps humain |
| Physiologie | L1 | Fonctionnement des organes |
| Biochimie | L1 | Réactions chimiques |
| Biologie Cellulaire | L1 | Étude des cellules |
| Histologie | L1 | Étude des tissus |
| Biophysique | L1 | Physique appliquée |
| Anatomie détaillée | L2 | Anatomie approfondie |
| Physiologie approfondie | L2 | Fonctionnement approfondi |
| Pharmacologie | L2 | Médicaments et effets |
| Pathologie | L2 | Étude des maladies |
| Immunologie | L2 | Système immunitaire |
| Microbiologie | L2 | Micro-organismes |
| Sémiologie | L3 | Signes et symptômes |
| Cardiologie | L3 | Maladies cardiaques |
| Neurologie | L3 | Système nerveux |
| Radiologie | L3 | Imagerie médicale |
| Pharmacologie | L3 | Thérapeutique |

## 🎓 Niveaux de difficulté

- `'Facile'` - Questions basiques
- `'Moyen'` - Questions intermédiaires
- `'Difficile'` - Questions avancées

## 💡 Conseils

- ✅ Toujours vérifier que la catégorie existe avant d'insérer
- ✅ Fournir exactement 4 réponses par question
- ✅ Une seule réponse correcte (`isCorrect: true`)
- ✅ Inclure une explication détaillée
- ✅ Tester sur un émulateur avant de déployer

## 🆘 Besoin d'aide ?

Consultez [README.md](README.md) pour la documentation complète.
