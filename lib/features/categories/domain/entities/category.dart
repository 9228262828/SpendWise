import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// All icon options available for categories.
/// Keeping these as a const list of Icons.* values lets the Flutter icon
/// tree-shaker statically analyse which glyphs are needed, avoiding the
/// "non-constant invocations of IconData" build error.
const List<IconData> kCategoryIcons = [
  Icons.restaurant_rounded,
  Icons.directions_car_rounded,
  Icons.shopping_bag_rounded,
  Icons.receipt_long_rounded,
  Icons.movie_rounded,
  Icons.favorite_rounded,
  Icons.school_rounded,
  Icons.flight_rounded,
  Icons.category_rounded,
  Icons.home_rounded,
  Icons.fitness_center_rounded,
  Icons.coffee_rounded,
  Icons.phone_android_rounded,
  Icons.pets_rounded,
  Icons.games_rounded,
  Icons.music_note_rounded,
  Icons.local_hospital_rounded,
  Icons.business_rounded,
];

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    required this.iconCodePoint,
    required this.colorValue,
    this.isDefault = false,
  });

  final String id;
  final String name;
  final int iconCodePoint;
  final int colorValue;
  final bool isDefault;

  /// Resolves the stored code point back to a known const IconData.
  /// Falls back to [Icons.category_rounded] for any legacy/unknown code point.
  IconData get icon {
    for (final iconData in kCategoryIcons) {
      if (iconData.codePoint == iconCodePoint) return iconData;
    }
    return Icons.category_rounded;
  }

  Color get color => Color(colorValue);

  Category copyWith({
    String? id,
    String? name,
    int? iconCodePoint,
    int? colorValue,
    bool? isDefault,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      colorValue: colorValue ?? this.colorValue,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  List<Object?> get props => [id, name, iconCodePoint, colorValue, isDefault];
}
