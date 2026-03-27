import '../../domain/entities/expense.dart';
import '../../domain/repositories/expense_repository.dart';
import '../datasources/expense_local_datasource.dart';
import '../models/expense_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  const ExpenseRepositoryImpl(this._datasource);

  final ExpenseLocalDatasource _datasource;

  @override
  Future<List<Expense>> getAllExpenses() async {
    final models = await _datasource.getAllExpenses();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Expense>> getExpensesByDateRange(DateTime start, DateTime end) async {
    final all = await getAllExpenses();
    return all.where((e) {
      final expenseDate = DateTime(e.date.year, e.date.month, e.date.day);
      final startDate = DateTime(start.year, start.month, start.day);
      final endDate = DateTime(end.year, end.month, end.day);
      return !expenseDate.isBefore(startDate) && !expenseDate.isAfter(endDate);
    }).toList();
  }

  @override
  Future<List<Expense>> getExpensesByCategory(String categoryId) async {
    final all = await getAllExpenses();
    return all.where((e) => e.categoryId == categoryId).toList();
  }

  @override
  Future<List<Expense>> searchExpenses(String query) async {
    if (query.trim().isEmpty) return getAllExpenses();
    final all = await getAllExpenses();
    final lower = query.toLowerCase();
    return all.where((e) {
      return e.note?.toLowerCase().contains(lower) == true ||
          e.amount.toString().contains(lower);
    }).toList();
  }

  @override
  Future<Expense?> getExpenseById(String id) async {
    final model = await _datasource.getExpenseById(id);
    return model?.toEntity();
  }

  @override
  Future<void> addExpense(Expense expense) async {
    await _datasource.saveExpense(ExpenseModel.fromEntity(expense));
  }

  @override
  Future<void> updateExpense(Expense expense) async {
    await _datasource.saveExpense(ExpenseModel.fromEntity(expense));
  }

  @override
  Future<void> deleteExpense(String id) async {
    await _datasource.deleteExpense(id);
  }

  @override
  Future<double> getTotalByDateRange(DateTime start, DateTime end) async {
    final expenses = await getExpensesByDateRange(start, end);
    double total = 0.0;
    for (final e in expenses) {
      total += e.amount;
    }
    return total;
  }

  @override
  Stream<List<Expense>> watchExpenses() {
    return _datasource.watchExpenses().map(
          (models) => models.map((m) => m.toEntity()).toList(),
        );
  }
}
