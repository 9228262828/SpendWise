import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static String format(double amount, String currencyCode) {
    final symbol = AppConstants.currencySymbols[currencyCode] ?? currencyCode;
    final formatter = NumberFormat('#,##0.00');
    return '$symbol ${formatter.format(amount)}';
  }

  static String formatCompact(double amount, String currencyCode) {
    final symbol = AppConstants.currencySymbols[currencyCode] ?? currencyCode;
    if (amount >= 1000000) {
      return '$symbol ${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '$symbol ${(amount / 1000).toStringAsFixed(1)}K';
    }
    return '$symbol ${amount.toStringAsFixed(2)}';
  }

  static String symbol(String currencyCode) {
    return AppConstants.currencySymbols[currencyCode] ?? currencyCode;
  }
}
