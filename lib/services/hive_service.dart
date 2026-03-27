import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../features/categories/data/models/category_model.dart';
import '../features/expenses/data/models/expense_model.dart';

class HiveService {
  HiveService._();

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExpenseModelAdapter());
    Hive.registerAdapter(CategoryModelAdapter());
    await Hive.openBox<ExpenseModel>(AppConstants.hiveExpensesBox);
    await Hive.openBox<CategoryModel>(AppConstants.hiveCategoriesBox);
    await Hive.openBox(AppConstants.hiveSettingsBox);
    await _seedDefaultCategories();
  }

  static Future<void> _seedDefaultCategories() async {
    final box = Hive.box<CategoryModel>(AppConstants.hiveCategoriesBox);
    if (box.isNotEmpty) return;

    final defaults = [
      CategoryModel(
        id: 'food',
        name: 'Food & Dining',
        iconCodePoint: Icons.restaurant_rounded.codePoint,
        colorValue: AppColors.categoryColors[0].toARGB32(),
        isDefault: true,
      ),
      CategoryModel(
        id: 'transport',
        name: 'Transport',
        iconCodePoint: Icons.directions_car_rounded.codePoint,
        colorValue: AppColors.categoryColors[1].toARGB32(),
        isDefault: true,
      ),
      CategoryModel(
        id: 'shopping',
        name: 'Shopping',
        iconCodePoint: Icons.shopping_bag_rounded.codePoint,
        colorValue: AppColors.categoryColors[2].toARGB32(),
        isDefault: true,
      ),
      CategoryModel(
        id: 'bills',
        name: 'Bills & Utilities',
        iconCodePoint: Icons.receipt_long_rounded.codePoint,
        colorValue: AppColors.categoryColors[3].toARGB32(),
        isDefault: true,
      ),
      CategoryModel(
        id: 'entertainment',
        name: 'Entertainment',
        iconCodePoint: Icons.movie_rounded.codePoint,
        colorValue: AppColors.categoryColors[4].toARGB32(),
        isDefault: true,
      ),
      CategoryModel(
        id: 'health',
        name: 'Health & Fitness',
        iconCodePoint: Icons.favorite_rounded.codePoint,
        colorValue: AppColors.categoryColors[5].toARGB32(),
        isDefault: true,
      ),
      CategoryModel(
        id: 'education',
        name: 'Education',
        iconCodePoint: Icons.school_rounded.codePoint,
        colorValue: AppColors.categoryColors[6].toARGB32(),
        isDefault: true,
      ),
      CategoryModel(
        id: 'travel',
        name: 'Travel',
        iconCodePoint: Icons.flight_rounded.codePoint,
        colorValue: AppColors.categoryColors[7].toARGB32(),
        isDefault: true,
      ),
      CategoryModel(
        id: 'other',
        name: 'Other',
        iconCodePoint: Icons.category_rounded.codePoint,
        colorValue: AppColors.categoryColors[8].toARGB32(),
        isDefault: true,
      ),
    ];

    for (final category in defaults) {
      await box.put(category.id, category);
    }
  }
}
