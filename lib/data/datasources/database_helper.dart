import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('hippoquiz.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Les migrations seront gérées par la table database_version
    // Cette méthode est gardée pour compatibilité avec sqflite
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const boolType = 'INTEGER NOT NULL';
    const textTypeNullable = 'TEXT';

    // Table students
    await db.execute('''
      CREATE TABLE students (
        id $idType,
        name $textType,
        year_level $textType,
        created_at $textType
      )
    ''');

    // Table categories
    await db.execute('''
      CREATE TABLE categories (
        id $idType,
        name $textType,
        year_level $textType,
        icon $textType,
        color $textType,
        description $textTypeNullable
      )
    ''');

    // Table questions
    await db.execute('''
      CREATE TABLE questions (
        id $idType,
        category_id $integerType,
        year_level $textType,
        question_text $textType,
        difficulty $textType,
        explanation $textType,
        FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
      )
    ''');

    // Table answers
    await db.execute('''
      CREATE TABLE answers (
        id $idType,
        question_id $integerType,
        answer_text $textType,
        is_correct $boolType,
        FOREIGN KEY (question_id) REFERENCES questions (id) ON DELETE CASCADE
      )
    ''');

    // Table user_progress
    await db.execute('''
      CREATE TABLE user_progress (
        id $idType,
        student_id $integerType,
        question_id $integerType,
        is_correct $boolType,
        answered_at $textType,
        FOREIGN KEY (student_id) REFERENCES students (id) ON DELETE CASCADE,
        FOREIGN KEY (question_id) REFERENCES questions (id) ON DELETE CASCADE
      )
    ''');

    // Table quiz_sessions
    await db.execute('''
      CREATE TABLE quiz_sessions (
        id $idType,
        student_id $integerType,
        category_id $integerType,
        score $integerType,
        total_questions $integerType,
        started_at $textType,
        completed_at $textTypeNullable,
        FOREIGN KEY (student_id) REFERENCES students (id) ON DELETE CASCADE,
        FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
      )
    ''');

    // Créer des index pour améliorer les performances
    await db.execute(
        'CREATE INDEX idx_questions_category ON questions(category_id)');
    await db
        .execute('CREATE INDEX idx_questions_year ON questions(year_level)');
    await db
        .execute('CREATE INDEX idx_answers_question ON answers(question_id)');
    await db.execute(
        'CREATE INDEX idx_progress_student ON user_progress(student_id)');
    await db.execute(
        'CREATE INDEX idx_sessions_student ON quiz_sessions(student_id)');

    // Table de versioning pour les migrations
    await db.execute('''
      CREATE TABLE database_version (
        id INTEGER PRIMARY KEY CHECK (id = 1),
        version $integerType,
        updated_at $textType
      )
    ''');

    // Initialiser la version à 1
    await db.insert('database_version', {
      'id': 1,
      'version': 1,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  // CRUD Operations génériques

  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final db = await database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryWhere(
    String table,
    String where,
    List<dynamic> whereArgs,
  ) async {
    final db = await database;
    return await db.query(table, where: where, whereArgs: whereArgs);
  }

  Future<int> update(
    String table,
    Map<String, dynamic> data,
    String where,
    List<dynamic> whereArgs,
  ) async {
    final db = await database;
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(
    String table,
    String where,
    List<dynamic> whereArgs,
  ) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> rawQuery(String query,
      [List<dynamic>? arguments]) async {
    final db = await database;
    return await db.rawQuery(query, arguments);
  }

  Future<int> rawInsert(String query, [List<dynamic>? arguments]) async {
    final db = await database;
    return await db.rawInsert(query, arguments);
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.delete('user_progress');
    await db.delete('quiz_sessions');
    await db.delete('students');
    // Ne pas supprimer les categories, questions et answers (données de base)
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }

  // Système de migrations

  /// Obtient la version actuelle de la base de données
  Future<int> getCurrentVersion() async {
    final db = await database;

    try {
      // Vérifier si la table database_version existe
      final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='database_version'"
      );

      if (tables.isEmpty) {
        // Créer la table si elle n'existe pas (migration depuis ancienne version)
        await db.execute('''
          CREATE TABLE database_version (
            id INTEGER PRIMARY KEY CHECK (id = 1),
            version INTEGER NOT NULL,
            updated_at TEXT NOT NULL
          )
        ''');

        // Initialiser à la version 1
        await db.insert('database_version', {
          'id': 1,
          'version': 1,
          'updated_at': DateTime.now().toIso8601String(),
        });

        return 1;
      }

      final result = await db.query('database_version', where: 'id = ?', whereArgs: [1]);

      if (result.isEmpty) {
        // La table existe mais est vide, initialiser
        await db.insert('database_version', {
          'id': 1,
          'version': 1,
          'updated_at': DateTime.now().toIso8601String(),
        });
        return 1;
      }

      return result.first['version'] as int;
    } catch (e) {
      // En cas d'erreur, retourner version 1 par défaut
      return 1;
    }
  }

  /// Met à jour la version de la base de données
  Future<void> updateVersion(int newVersion) async {
    final db = await database;
    await db.update(
      'database_version',
      {
        'version': newVersion,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  /// Exécute une migration spécifique
  Future<void> executeMigration(Future<void> Function(Database) migration) async {
    final db = await database;
    await migration(db);
  }
}
