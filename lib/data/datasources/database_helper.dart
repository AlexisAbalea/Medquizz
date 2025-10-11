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
    );
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const boolType = 'INTEGER NOT NULL';
    const textTypeNullable = 'TEXT';

    // Table students
    await db.execute(
        '''
      CREATE TABLE students (
        id $idType,
        name $textType,
        year_level $textType,
        created_at $textType
      )
    ''');

    // Table categories
    await db.execute(
        '''
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
    await db.execute(
        '''
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
    await db.execute(
        '''
      CREATE TABLE answers (
        id $idType,
        question_id $integerType,
        answer_text $textType,
        is_correct $boolType,
        FOREIGN KEY (question_id) REFERENCES questions (id) ON DELETE CASCADE
      )
    ''');

    // Table user_progress
    await db.execute(
        '''
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
    await db.execute(
        '''
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
}
