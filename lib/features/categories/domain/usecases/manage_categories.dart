import '../entities/category.dart';
import '../repositories/category_repository.dart';

class GetCategories {
  const GetCategories(this._repository);
  final CategoryRepository _repository;

  Future<List<Category>> call() => _repository.getAllCategories();
}

class WatchCategories {
  const WatchCategories(this._repository);
  final CategoryRepository _repository;

  Stream<List<Category>> call() => _repository.watchCategories();
}

class AddCategory {
  const AddCategory(this._repository);
  final CategoryRepository _repository;

  Future<void> call(Category category) => _repository.addCategory(category);
}

class UpdateCategory {
  const UpdateCategory(this._repository);
  final CategoryRepository _repository;

  Future<void> call(Category category) => _repository.updateCategory(category);
}

class DeleteCategory {
  const DeleteCategory(this._repository);
  final CategoryRepository _repository;

  Future<void> call(String id) => _repository.deleteCategory(id);
}
