import 'package:hippoquiz/data/datasources/database_helper.dart';
import 'package:hippoquiz/data/models/category_model.dart';
import 'package:hippoquiz/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final DatabaseHelper _dbHelper;

  CategoryRepositoryImpl(this._dbHelper);

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final categories = await _dbHelper.queryAll('categories');
    return categories.map((cat) => CategoryModel.fromMap(cat)).toList();
  }

  @override
  Future<List<CategoryModel>> getCategoriesByYear(String yearLevel) async {
    final categories = await _dbHelper.queryWhere(
      'categories',
      'year_level = ?',
      [yearLevel],
    );
    return categories.map((cat) => CategoryModel.fromMap(cat)).toList();
  }

  @override
  Future<CategoryModel?> getCategoryById(int id) async {
    final categories = await _dbHelper.queryWhere(
      'categories',
      'id = ?',
      [id],
    );
    if (categories.isEmpty) return null;
    return CategoryModel.fromMap(categories.first);
  }

  @override
  Future<int> getQuestionCountByCategory(int categoryId) async {
    final result = await _dbHelper.rawQuery(
      'SELECT COUNT(*) as count FROM questions WHERE category_id = ?',
      [categoryId],
    );
    return result.first['count'] as int;
  }
}
