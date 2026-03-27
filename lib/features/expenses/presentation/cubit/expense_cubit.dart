import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/expense.dart';
import '../../domain/usecases/get_expenses.dart';
import '../../domain/usecases/manage_expense.dart';
import '../../../../core/utils/date_utils.dart';
import 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit({
    required WatchExpenses watchExpenses,
    required GetExpensesByDateRange getByDateRange,
    required AddExpense addExpense,
    required UpdateExpense updateExpense,
    required DeleteExpense deleteExpense,
    required SearchExpenses searchExpenses,
  })  : _watchExpenses = watchExpenses,
        _getByDateRange = getByDateRange,
        _addExpense = addExpense,
        _updateExpense = updateExpense,
        _deleteExpense = deleteExpense,
        _searchExpenses = searchExpenses,
        super(const ExpenseInitial());

  final WatchExpenses _watchExpenses;
  // ignore: unused_field
  final GetExpensesByDateRange _getByDateRange;
  final AddExpense _addExpense;
  final UpdateExpense _updateExpense;
  final DeleteExpense _deleteExpense;
  // ignore: unused_field
  final SearchExpenses _searchExpenses;
  StreamSubscription<List<Expense>>? _subscription;

  void loadExpenses() {
    emit(const ExpenseLoading());
    _subscription?.cancel();
    _subscription = _watchExpenses().listen(
      (expenses) async {
        final now = DateTime.now();
        final todayStart = AppDateUtils.startOfToday;
        final todayEnd = AppDateUtils.endOfToday;
        final monthStart = AppDateUtils.startOfMonth(now);
        final monthEnd = AppDateUtils.endOfMonth(now);

        double todayTotal = 0;
        double monthTotal = 0;

        for (final e in expenses) {
          final d = e.date;
          if (!d.isBefore(todayStart) && !d.isAfter(todayEnd)) todayTotal += e.amount;
          if (!d.isBefore(monthStart) && !d.isAfter(monthEnd)) monthTotal += e.amount;
        }

        final currentState = state;
        final searchQuery = currentState is ExpenseLoaded ? currentState.searchQuery : '';

        List<Expense> filtered = expenses;
        if (searchQuery.isNotEmpty) {
          final lower = searchQuery.toLowerCase();
          filtered = expenses.where((e) =>
            e.note?.toLowerCase().contains(lower) == true ||
            e.amount.toString().contains(lower)
          ).toList();
        }

        emit(ExpenseLoaded(
          allExpenses: expenses,
          filteredExpenses: filtered,
          todayTotal: todayTotal,
          monthTotal: monthTotal,
          searchQuery: searchQuery,
        ));
      },
      onError: (e) => emit(ExpenseError(e.toString())),
    );
  }

  Future<void> addExpense({
    required double amount,
    required String categoryId,
    required DateTime date,
    String? note,
  }) async {
    try {
      final expense = Expense(
        id: const Uuid().v4(),
        amount: amount,
        categoryId: categoryId,
        date: date,
        note: note,
        createdAt: DateTime.now(),
      );
      await _addExpense(expense);
      emit(const ExpenseOperationSuccess('Expense added successfully'));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> updateExpense(Expense expense) async {
    try {
      await _updateExpense(expense);
      emit(const ExpenseOperationSuccess('Expense updated successfully'));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> deleteExpense(String id) async {
    try {
      await _deleteExpense(id);
      emit(const ExpenseOperationSuccess('Expense deleted'));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  void search(String query) {
    final currentState = state;
    if (currentState is ExpenseLoaded) {
      List<Expense> filtered;
      if (query.trim().isEmpty) {
        filtered = currentState.allExpenses;
      } else {
        final lower = query.toLowerCase();
        filtered = currentState.allExpenses.where((e) =>
          e.note?.toLowerCase().contains(lower) == true ||
          e.amount.toString().contains(lower)
        ).toList();
      }
      emit(currentState.copyWith(filteredExpenses: filtered, searchQuery: query));
    }
  }

  void clearSearch() => search('');

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
