import '../entities/expense.dart';

abstract class ExpenseRepository {
  Future<List<Expense>> getAllExpenses();
  Future<List<Expense>> getExpensesByDateRange(DateTime start, DateTime end);
  Future<List<Expense>> getExpensesByCategory(String categoryId);
  Future<List<Expense>> searchExpenses(String query);
  Future<Expense?> getExpenseById(String id);
  Future<void> addExpense(Expense expense);
  Future<void> updateExpense(Expense expense);
  Future<void> deleteExpense(String id);
  Future<double> getTotalByDateRange(DateTime start, DateTime end);
  Stream<List<Expense>> watchExpenses();
}
