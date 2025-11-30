import 'package:flutter/foundation.dart';
import 'package:hippoquiz/data/datasources/database_helper.dart';
import 'package:sqflite/sqflite.dart';

// Importer les migrations ici :
import 'package:hippoquiz/data/datasources/migrations/migration_2.dart';

/// Gestionnaire principal des migrations de base de données
class MigrationManager {
  final DatabaseHelper _dbHelper;

  MigrationManager(this._dbHelper);

  /// Liste de toutes les migrations disponibles
  /// Chaque migration est identifiée par sa version cible
  final Map<int, Future<void> Function(Database)> _migrations = {
    // Version 1 -> Version 2 : Ajout de la catégorie "Préparation aux urgences" L3
    // avec 125 questions (clinique, tri, urgences vitales)
    2: Migration2.migrate,
  };

  /// Exécute toutes les migrations nécessaires
  Future<void> runMigrations() async {
    final currentVersion = await _dbHelper.getCurrentVersion();
    final targetVersion = _getLatestVersion();

    if (currentVersion >= targetVersion) {
      // Aucune migration nécessaire
      return;
    }

    debugPrint('🔄 Migration de la base de données de v$currentVersion vers v$targetVersion');

    // Exécuter les migrations une par une dans l'ordre
    for (int version = currentVersion + 1; version <= targetVersion; version++) {
      if (_migrations.containsKey(version)) {
        debugPrint('📦 Application de la migration vers v$version...');

        try {
          await _dbHelper.executeMigration(_migrations[version]!);
          await _dbHelper.updateVersion(version);
          debugPrint('✅ Migration v$version terminée avec succès');
        } catch (e) {
          debugPrint('❌ Erreur lors de la migration v$version: $e');
          rethrow;
        }
      } else {
        // Pas de migration pour cette version, juste mettre à jour le numéro
        await _dbHelper.updateVersion(version);
      }
    }

    debugPrint('✨ Toutes les migrations ont été appliquées avec succès');
  }

  /// Retourne la version la plus récente disponible
  int _getLatestVersion() {
    if (_migrations.isEmpty) {
      return 1; // Version de base
    }
    return _migrations.keys.reduce((a, b) => a > b ? a : b);
  }

  /// Vérifie si des migrations sont en attente
  Future<bool> hasPendingMigrations() async {
    final currentVersion = await _dbHelper.getCurrentVersion();
    final targetVersion = _getLatestVersion();
    return currentVersion < targetVersion;
  }
}
