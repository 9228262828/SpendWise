import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color get lighter => Color.lerp(this, Colors.white, 0.3)!;
  Color get darker => Color.lerp(this, Colors.black, 0.3)!;
  Color withLightness(double factor) => Color.lerp(this, Colors.white, factor)!;
  Color withDarkness(double factor) => Color.lerp(this, Colors.black, factor)!;
}

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
}

extension StringExtension on String {
  String get capitalize => isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
  String get titleCase => split(' ').map((w) => w.capitalize).join(' ');
}

extension DoubleExtension on double {
  String toFormattedString() {
    if (this == truncateToDouble()) {
      return toInt().toString();
    }
    return toStringAsFixed(2).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }
}

extension ListExtension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
  T? get lastOrNull => isEmpty ? null : last;
}
