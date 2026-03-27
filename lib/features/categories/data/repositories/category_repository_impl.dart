import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_local_datasource.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl(this._datasource);

  final CategoryLocalDatasource _datasource;

  @override
  Future<List<Category>> getAllCategories() async {
    final models = await _datasource.getAllCategories();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Category?> getCategoryById(String id) async {
    final model = await _datasource.getCategoryById(id);
    return model?.toEntity();
  }

  @override
  Future<void> addCategory(Category category) async {
    await _datasource.saveCategory(CategoryModel.fromEntity(category));
  }

  @override
  Future<void> updateCategory(Category category) async {
    await _datasource.saveCategory(CategoryModel.fromEntity(category));
  }

  @override
  Future<void> deleteCategory(String id) async {
    await _datasource.deleteCategory(id);
  }

  @override
  Stream<List<Category>> watchCategories() {
    return _datasource.watchCategories().map(
          (models) => models.map((m) => m.toEntity()).toList(),
        );
  }
}
