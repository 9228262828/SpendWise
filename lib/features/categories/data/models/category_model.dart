import 'package:hive/hive.dart';
import '../../domain/entities/category.dart';

part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late int iconCodePoint;

  @HiveField(3)
  late int colorValue;

  @HiveField(4)
  late bool isDefault;

  CategoryModel({
    required this.id,
    required this.name,
    required this.iconCodePoint,
    required this.colorValue,
    this.isDefault = false,
  });

  factory CategoryModel.fromEntity(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      iconCodePoint: category.iconCodePoint,
      colorValue: category.colorValue,
      isDefault: category.isDefault,
    );
  }

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      iconCodePoint: iconCodePoint,
      colorValue: colorValue,
      isDefault: isDefault,
    );
  }
}
