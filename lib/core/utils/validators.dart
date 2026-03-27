class Validators {
  Validators._();

  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) return 'Amount is required';
    final amount = double.tryParse(value.replaceAll(',', ''));
    if (amount == null) return 'Please enter a valid amount';
    if (amount <= 0) return 'Amount must be greater than 0';
    if (amount > 999999999) return 'Amount is too large';
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    return null;
  }

  static String? validateCategoryName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Category name is required';
    if (value.trim().length < 2) return 'Name must be at least 2 characters';
    if (value.trim().length > 30) return 'Name must be 30 characters or less';
    return null;
  }
}
