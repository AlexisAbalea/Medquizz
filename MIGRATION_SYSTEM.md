# Système de Migrations - Documentation Technique

## 📋 Résumé

Un système complet de migrations SQLite a été ajouté à HippoQuiz pour permettre l'ajout incrémental de nouvelles questions sans perte de données utilisateur.

## ✅ Modifications apportées

### 1. Database Helper ([database_helper.dart](lib/data/datasources/database_helper.dart))

**Ajouts:**
- Table `database_version` créée lors de l'initialisation
- Méthode `getCurrentVersion()` : récupère la version actuelle de la DB
- Méthode `updateVersion(int)` : met à jour le numéro de version
- Méthode `executeMigration(Function)` : exécute une migration
- Callback `onUpgrade` pour compatibilité avec sqflite

**Ligne 126-140:** Création de la table de versioning
**Ligne 207-251:** Méthodes de gestion des migrations

### 2. Migration Manager ([migration_manager.dart](lib/data/datasources/migrations/migration_manager.dart))

**Nouveau fichier** qui orchestre l'exécution des migrations:
- Map `_migrations` contenant toutes les migrations par version
- Méthode `runMigrations()` : applique les migrations manquantes
- Méthode `hasPendingMigrations()` : vérifie si des migrations sont en attente
- Utilise `debugPrint()` pour les logs (pas de `print()` en production)

### 3. Fichiers de migration

**Structure créée:**
```
lib/data/datasources/migrations/
├── README.md                    # Documentation complète
├── migration_manager.dart       # Gestionnaire
├── migrations.dart              # Index (vide pour l'instant)
└── migration_2_example.dart     # Exemple fonctionnel
```

**migration_2_example.dart** montre comment:
- Récupérer l'ID d'une catégorie
- Ajouter plusieurs questions avec leurs réponses
- Gérer les erreurs si la catégorie n'existe pas

### 4. Seed Data ([seed_data.dart](lib/data/datasources/seed_data.dart))

**Modifications:**
- Ajout de commentaires expliquant que c'est pour la première installation
- Séparation claire entre seed initial et futures migrations
- Pas de changement de logique, juste documentation améliorée

**Ligne 7-9:** Documentation clarifiée
**Ligne 16-19:** Commentaire expliquant que les nouvelles questions passent par migrations

### 5. Main ([main.dart](lib/main.dart))

**Modifications:**
- Import de `MigrationManager`
- Ajout d'une étape "Vérification des mises à jour..." dans le SplashScreen
- Exécution automatique des migrations après le seed initial

**Ligne 5:** Import du MigrationManager
**Ligne 118-124:** Exécution des migrations au démarrage

### 6. Documentation

**Fichiers mis à jour:**

1. **[CLAUDE.md](CLAUDE.md)**
   - Section "Database Management" mise à jour
   - Section "Data Layer" enrichie avec le dossier migrations/
   - Section "Database Schema" : ajout de la table database_version
   - Section "Adding New Questions" complètement réécrite

2. **[migrations/README.md](lib/data/datasources/migrations/README.md)** (nouveau)
   - Guide complet pour créer une migration
   - Exemples de code
   - Liste des catégories et leurs IDs approximatifs
   - Bonnes pratiques
   - Section débogage

3. **[MIGRATION_SYSTEM.md](MIGRATION_SYSTEM.md)** (ce fichier)
   - Vue d'ensemble technique
   - Résumé des modifications

## 🔄 Workflow de migration

```
App démarrage
    ↓
Initialisation DB (première fois seulement)
    ↓
SeedData.initialize() (si DB vide)
    ↓
MigrationManager.runMigrations()
    ↓
getCurrentVersion() → ex: v1
    ↓
Parcourir _migrations[2], _migrations[3], etc.
    ↓
Pour chaque migration non appliquée:
    - Exécuter la migration
    - Mettre à jour database_version
    - Logger le succès/échec
    ↓
App prête
```

## 🎯 Comment utiliser

### Scénario 1 : Première installation
1. L'utilisateur installe l'app
2. `SeedData.initialize()` peuple toutes les données initiales
3. `MigrationManager` vérifie (version = 1, aucune migration à faire)
4. L'app démarre normalement

### Scénario 2 : Mise à jour avec nouvelles questions
1. Développeur crée `migration_2.dart` avec nouvelles questions
2. Développeur enregistre la migration dans `migration_manager.dart`
3. Utilisateur met à jour l'app
4. Au démarrage, `MigrationManager` détecte version 1 < 2
5. Migration 2 s'exécute, ajoute les questions
6. Version mise à jour à 2
7. L'utilisateur voit les nouvelles questions, ses données sont préservées

### Scénario 3 : Utilisateur qui saute une version
1. Utilisateur a la version avec DB v1
2. Utilisateur met à jour vers une version avec DB v4
3. Migrations 2, 3, et 4 s'exécutent dans l'ordre
4. Toutes les questions ajoutées entre-temps sont disponibles

## 🧪 Tests à effectuer

Pour vérifier que le système fonctionne :

1. **Test nouvelle installation:**
   ```bash
   flutter clean
   flutter run
   # Vérifier que l'app démarre normalement
   # Vérifier les logs : "Migration de la base de données de v1 vers v1" (aucune migration)
   ```

2. **Test migration (optionnel):**
   ```bash
   # Renommer migration_2_example.dart en migration_2.dart
   # Ajouter la migration dans migration_manager.dart
   # Relancer l'app
   # Vérifier les logs : "Migration de la base de données de v1 vers v2"
   # Vérifier que les 2 nouvelles questions apparaissent en Anatomie L1
   ```

## 🔍 Points d'attention

1. **Numéros de version séquentiels:** Toujours incrémenter de 1
2. **Pas de modification des migrations déployées:** Une fois en production, ne jamais changer
3. **Gestion d'erreurs:** Les migrations échouées stoppent le processus
4. **Transactions:** Pour des opérations critiques, envelopper dans des transactions
5. **Catégories IDs:** Toujours récupérer via requête, ne jamais hardcoder

## 📊 État actuel

- ✅ Système de migrations opérationnel
- ✅ Table database_version créée
- ✅ MigrationManager fonctionnel
- ✅ Exemple de migration fourni
- ✅ Documentation complète
- ✅ Analyse statique : 0 erreurs
- ⏸️ Aucune migration active (version 1)

## 🚀 Prochaines étapes

Pour activer la première migration exemple :

1. Renommer `migration_2_example.dart` en `migration_2.dart`
2. Dans `migration_manager.dart`, décommenter l'import :
   ```dart
   import 'package:hippoquiz/data/datasources/migrations/migration_2.dart';
   ```
3. Ajouter dans la map `_migrations` :
   ```dart
   final Map<int, Future<void> Function(Database)> _migrations = {
     2: Migration2.migrate,
   };
   ```
4. Relancer l'app

## 📝 Notes de développement

- Le système est conçu pour être extensible
- Chaque migration est isolée dans son propre fichier
- Les migrations peuvent faire plus que juste ajouter des questions :
  - Modifier le schéma (ALTER TABLE)
  - Nettoyer des données
  - Recalculer des statistiques
  - Ajouter des index

## 🆘 Support

En cas de problème avec les migrations :
1. Consulter [lib/data/datasources/migrations/README.md](lib/data/datasources/migrations/README.md)
2. Vérifier les logs de l'app (rechercher les emojis 🔄 📦 ✅ ❌)
3. Vérifier que la table `database_version` existe
4. En dernier recours : réinitialiser la DB (perte de données utilisateur)

---

**Date de création:** 2025-11-29
**Version du système:** 1.0
**Auteur:** Système de migrations HippoQuiz
