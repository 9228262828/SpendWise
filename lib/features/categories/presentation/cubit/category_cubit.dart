import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/manage_categories.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({
    required WatchCategories watchCategories,
    required AddCategory addCategory,
    required UpdateCategory updateCategory,
    required DeleteCategory deleteCategory,
  })  : _watchCategories = watchCategories,
        _addCategory = addCategory,
        _updateCategory = updateCategory,
        _deleteCategory = deleteCategory,
        super(const CategoryInitial());

  final WatchCategories _watchCategories;
  final AddCategory _addCategory;
  final UpdateCategory _updateCategory;
  final DeleteCategory _deleteCategory;
  StreamSubscription<List<Category>>? _subscription;

  void loadCategories() {
    emit(const CategoryLoading());
    _subscription?.cancel();
    _subscription = _watchCategories().listen(
      (categories) => emit(CategoryLoaded(categories)),
      onError: (e) => emit(CategoryError(e.toString())),
    );
  }

  Future<void> addCategory({
    required String name,
    required IconData icon,
    required Color color,
  }) async {
    try {
      final category = Category(
        id: const Uuid().v4(),
        name: name,
        iconCodePoint: icon.codePoint,
        colorValue: color.toARGB32(),
      );
      await _addCategory(category);
      emit(const CategoryOperationSuccess('Category added'));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  Future<void> updateCategory(Category category) async {
    try {
      await _updateCategory(category);
      emit(const CategoryOperationSuccess('Category updated'));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await _deleteCategory(id);
      emit(const CategoryOperationSuccess('Category deleted'));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  List<Category> getCategories() {
    final s = state;
    return s is CategoryLoaded ? s.categories : [];
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
