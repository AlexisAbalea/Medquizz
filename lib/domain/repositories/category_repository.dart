import 'package:hippoquiz/data/models/category_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getAllCategories();
  Future<List<CategoryModel>> getCategoriesByYear(String yearLevel);
  Future<CategoryModel?> getCategoryById(int id);
  Future<int> getQuestionCountByCategory(int categoryId);
}
