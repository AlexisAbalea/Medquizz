import 'package:flutter/foundation.dart';
import 'package:hippoquiz/data/models/category_model.dart';
import 'package:hippoquiz/domain/repositories/category_repository.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryRepository _repository;

  List<CategoryModel> _categories = [];
  List<CategoryModel> _filteredCategories = [];
  final Map<int, int> _questionCounts = {};
  bool _isLoading = false;
  String? _error;
  String? _currentYearFilter;

  CategoryProvider(this._repository);

  List<CategoryModel> get categories => _filteredCategories;
  List<CategoryModel> get allCategories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get currentYearFilter => _currentYearFilter;

  int getQuestionCount(int categoryId) => _questionCounts[categoryId] ?? 0;

  /// Récupère les catégories groupées par année
  Map<String, List<CategoryModel>> getCategoriesGroupedByYear() {
    final Map<String, List<CategoryModel>> grouped = {
      'L1': [],
      'L2': [],
      'L3': [],
    };

    for (var category in _categories) {
      if (grouped.containsKey(category.yearLevel)) {
        grouped[category.yearLevel]!.add(category);
      }
    }

    return grouped;
  }

  Future<void> loadAllCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _categories = await _repository.getAllCategories();
      _filteredCategories = _categories;

      // Charger le nombre de questions pour chaque catégorie
      for (var category in _categories) {
        if (category.id != null) {
          final count =
              await _repository.getQuestionCountByCategory(category.id!);
          _questionCounts[category.id!] = count;
        }
      }
    } catch (e) {
      _error = 'Erreur lors du chargement des catégories: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCategoriesByYear(String yearLevel) async {
    _isLoading = true;
    _error = null;
    _currentYearFilter = yearLevel;
    notifyListeners();

    try {
      _filteredCategories = await _repository.getCategoriesByYear(yearLevel);

      // Charger le nombre de questions pour chaque catégorie
      for (var category in _filteredCategories) {
        if (category.id != null) {
          final count =
              await _repository.getQuestionCountByCategory(category.id!);
          _questionCounts[category.id!] = count;
        }
      }
    } catch (e) {
      _error = 'Erreur lors du chargement des catégories: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<CategoryModel?> getCategoryById(int id) async {
    try {
      return await _repository.getCategoryById(id);
    } catch (e) {
      _error = 'Erreur lors du chargement de la catégorie: $e';
      notifyListeners();
      return null;
    }
  }

  void clearFilter() {
    _currentYearFilter = null;
    _filteredCategories = _categories;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
