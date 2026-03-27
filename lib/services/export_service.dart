import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../features/categories/domain/entities/category.dart';
import '../features/expenses/domain/entities/expense.dart';
import '../core/utils/date_utils.dart';

class ExportService {
  ExportService._();

  static final ExportService _instance = ExportService._();
  static ExportService get instance => _instance;

  Future<void> exportToCSV(
    List<Expense> expenses,
    Map<String, Category> categories,
    String currencyCode,
    BuildContext context,
  ) async {
    final rows = <List<dynamic>>[
      ['Date', 'Amount ($currencyCode)', 'Category', 'Note'],
    ];

    for (final expense in expenses) {
      final category = categories[expense.categoryId];
      rows.add([
        AppDateUtils.formatDate(expense.date),
        expense.amount.toStringAsFixed(2),
        category?.name ?? 'Unknown',
        expense.note ?? '',
      ]);
    }

    final csvData = const ListToCsvConverter().convert(rows);
    final dir = await getTemporaryDirectory();
    final fileName = 'spendwise_export_${DateTime.now().millisecondsSinceEpoch}.csv';
    final file = File('${dir.path}/$fileName');
    await file.writeAsString(csvData);

    if (context.mounted) {
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'SpendWise Expense Export',
        text: 'Here is your expense data exported from SpendWise.',
      );
    }
  }
}
