import 'package:hive/hive.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/expense_model.dart';

abstract class ExpenseLocalDatasource {
  Future<List<ExpenseModel>> getAllExpenses();
  Future<ExpenseModel?> getExpenseById(String id);
  Future<void> saveExpense(ExpenseModel expense);
  Future<void> deleteExpense(String id);
  Stream<List<ExpenseModel>> watchExpenses();
}

class ExpenseLocalDatasourceImpl implements ExpenseLocalDatasource {
  Box<ExpenseModel> get _box => Hive.box<ExpenseModel>(AppConstants.hiveExpensesBox);

  @override
  Future<List<ExpenseModel>> getAllExpenses() async {
    final expenses = _box.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return expenses;
  }

  @override
  Future<ExpenseModel?> getExpenseById(String id) async {
    try {
      return _box.values.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveExpense(ExpenseModel expense) async {
    await _box.put(expense.id, expense);
  }

  @override
  Future<void> deleteExpense(String id) async {
    await _box.delete(id);
  }

  @override
  Stream<List<ExpenseModel>> watchExpenses() {
    return _box.watch().map((_) {
      return _box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
    });
  }
}
