import '../entities/expense.dart';
import '../repositories/expense_repository.dart';

class AddExpense {
  const AddExpense(this._repository);
  final ExpenseRepository _repository;

  Future<void> call(Expense expense) => _repository.addExpense(expense);
}

class UpdateExpense {
  const UpdateExpense(this._repository);
  final ExpenseRepository _repository;

  Future<void> call(Expense expense) => _repository.updateExpense(expense);
}

class DeleteExpense {
  const DeleteExpense(this._repository);
  final ExpenseRepository _repository;

  Future<void> call(String id) => _repository.deleteExpense(id);
}
