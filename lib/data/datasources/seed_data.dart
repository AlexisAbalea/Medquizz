import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hippoquiz/data/datasources/database_helper.dart';

class SeedData {
  static Future<void> initialize() async {
    final db = DatabaseHelper.instance;

    final categories = await db.queryAll('categories');

    final questions = await db.queryAll('questions');

    if (categories.isNotEmpty && questions.isNotEmpty) {
      return;
    }

    if (categories.isEmpty) {
      await _insertCategories(db);
    }

    if (questions.isEmpty) {
      await _insertQuestionsFromJson(db);
    }
  }

  static Future<void> _insertCategories(DatabaseHelper db) async {
    final categories = [
      // L1
      {
        'name': 'Anatomie',
        'year_level': 'L1',
        'icon': 'anatomy',
        'color': '#E91E63',
        'description': 'Structure du corps humain'
      },
      {
        'name': 'Physiologie',
        'year_level': 'L1',
        'icon': 'physiology',
        'color': '#2196F3',
        'description': 'Fonctionnement des organes'
      },
      {
        'name': 'Biochimie',
        'year_level': 'L1',
        'icon': 'biochemistry',
        'color': '#4CAF50',
        'description': 'Réactions chimiques dans le corps'
      },
      {
        'name': 'Biologie Cellulaire',
        'year_level': 'L1',
        'icon': 'cell',
        'color': '#FF9800',
        'description': 'Étude des cellules'
      },
      {
        'name': 'Histologie',
        'year_level': 'L1',
        'icon': 'microscope',
        'color': '#9C27B0',
        'description': 'Étude des tissus'
      },
      // L2
      {
        'name': 'Pharmacologie',
        'year_level': 'L2',
        'icon': 'pharmacy',
        'color': '#9C27B0',
        'description': 'Médicaments et leurs effets'
      },
      {
        'name': 'Pathologie',
        'year_level': 'L2',
        'icon': 'pathology',
        'color': '#F44336',
        'description': 'Étude des maladies'
      },
      {
        'name': 'Immunologie',
        'year_level': 'L2',
        'icon': 'immune',
        'color': '#00BCD4',
        'description': 'Système immunitaire'
      },
      {
        'name': 'Microbiologie',
        'year_level': 'L2',
        'icon': 'bacteria',
        'color': '#8BC34A',
        'description': 'Étude des micro-organismes'
      },
      // L3
      {
        'name': 'Sémiologie',
        'year_level': 'L3',
        'icon': 'stethoscope',
        'color': '#3F51B5',
        'description': 'Signes et symptômes'
      },
      {
        'name': 'Cardiologie',
        'year_level': 'L3',
        'icon': 'heart',
        'color': '#E91E63',
        'description': 'Maladies cardiaques'
      },
      {
        'name': 'Neurologie',
        'year_level': 'L3',
        'icon': 'brain',
        'color': '#673AB7',
        'description': 'Système nerveux'
      },
      {
        'name': 'Radiologie',
        'year_level': 'L3',
        'icon': 'xray',
        'color': '#607D8B',
        'description': 'Imagerie médicale'
      },
      // Catégories "Questions aléatoires" pour chaque niveau
      {
        'name': 'Questions aléatoires',
        'year_level': 'L1',
        'icon': 'shuffle',
        'color': '#FF5722',
        'description': 'Questions mélangées de toutes les matières'
      },
      {
        'name': 'Questions aléatoires',
        'year_level': 'L2',
        'icon': 'shuffle',
        'color': '#FF5722',
        'description': 'Questions mélangées de toutes les matières'
      },
      {
        'name': 'Questions aléatoires',
        'year_level': 'L3',
        'icon': 'shuffle',
        'color': '#FF5722',
        'description': 'Questions mélangées de toutes les matières'
      },
    ];

    for (var category in categories) {
      await db.insert('categories', category);
    }
  }

  static Future<void> _insertQuestion(
    DatabaseHelper db, {
    required int categoryId,
    required String yearLevel,
    required String questionText,
    required String difficulty,
    required String explanation,
    required List<Map<String, dynamic>> answers,
  }) async {
    // Insérer la question
    final questionId = await db.insert('questions', {
      'category_id': categoryId,
      'year_level': yearLevel,
      'question_text': questionText,
      'difficulty': difficulty,
      'explanation': explanation,
    });

    // Insérer les réponses
    for (var answer in answers) {
      await db.insert('answers', {
        'question_id': questionId,
        'answer_text': answer['text'],
        'is_correct': answer['isCorrect'] ? 1 : 0,
      });
    }
  }

  static Future<void> _insertQuestionsFromJson(DatabaseHelper db) async {
    final Map<String, List<String>> jsonFilesByLevel = {
      'L1': [
        'assets/questions/L1/anatomie.json',
        'assets/questions/L1/physiologie.json',
        'assets/questions/L1/biochimie.json',
        'assets/questions/L1/biologie_cellulaire.json',
        'assets/questions/L1/histologie.json',
      ],
      'L2': [
        'assets/questions/L2/pharmacologie.json',
        'assets/questions/L2/pathologie.json',
        'assets/questions/L2/immunologie.json',
        'assets/questions/L2/microbiologie.json',
      ],
      'L3': [
        'assets/questions/L3/semiologie.json',
        'assets/questions/L3/cardiologie.json',
        'assets/questions/L3/neurologie.json',
        'assets/questions/L3/radiologie.json',
      ],
    };

    // Récupérer toutes les catégories pour mapper les noms aux IDs
    final categoriesData = await db.queryAll('categories');

    final Map<String, int> categoryNameToId = {};
    for (var cat in categoriesData) {
      categoryNameToId[cat['name']] = cat['id'] as int;
    }

    for (final yearLevel in jsonFilesByLevel.keys) {
      final files = jsonFilesByLevel[yearLevel]!;

      for (final filePath in files) {
        final String jsonString = await rootBundle.loadString(filePath);

        final Map<String, dynamic> jsonData = json.decode(jsonString);

        final String categoryName = jsonData['category'] as String;
        final List<dynamic> questions = jsonData['questions'];

        final categoryId = categoryNameToId[categoryName];

        if (categoryId == null) {
          continue;
        }

        for (var questionData in questions) {
          await _insertQuestion(
            db,
            categoryId: categoryId,
            yearLevel: yearLevel,
            questionText: questionData['question_text'],
            difficulty: questionData['difficulty'],
            explanation: questionData['explanation'],
            answers: (questionData['answers'] as List)
                .map((a) => {
                      'text': a['text'],
                      'isCorrect': a['is_correct'],
                    })
                .toList(),
          );
        }
      }
    }
  }
}
