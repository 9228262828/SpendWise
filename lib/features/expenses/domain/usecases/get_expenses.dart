import '../entities/expense.dart';
import '../repositories/expense_repository.dart';

class GetExpenses {
  const GetExpenses(this._repository);
  final ExpenseRepository _repository;

  Future<List<Expense>> call() => _repository.getAllExpenses();
}

class GetExpensesByDateRange {
  const GetExpensesByDateRange(this._repository);
  final ExpenseRepository _repository;

  Future<List<Expense>> call(DateTime start, DateTime end) =>
      _repository.getExpensesByDateRange(start, end);
}

class SearchExpenses {
  const SearchExpenses(this._repository);
  final ExpenseRepository _repository;

  Future<List<Expense>> call(String query) => _repository.searchExpenses(query);
}

class WatchExpenses {
  const WatchExpenses(this._repository);
  final ExpenseRepository _repository;

  Stream<List<Expense>> call() => _repository.watchExpenses();
}
