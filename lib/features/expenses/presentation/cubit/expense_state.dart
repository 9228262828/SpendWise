import 'package:equatable/equatable.dart';
import '../../domain/entities/expense.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object?> get props => [];
}

class ExpenseInitial extends ExpenseState {
  const ExpenseInitial();
}

class ExpenseLoading extends ExpenseState {
  const ExpenseLoading();
}

class ExpenseLoaded extends ExpenseState {
  const ExpenseLoaded({
    required this.allExpenses,
    required this.filteredExpenses,
    required this.todayTotal,
    required this.monthTotal,
    this.searchQuery = '',
  });

  final List<Expense> allExpenses;
  final List<Expense> filteredExpenses;
  final double todayTotal;
  final double monthTotal;
  final String searchQuery;

  @override
  List<Object?> get props => [allExpenses, filteredExpenses, todayTotal, monthTotal, searchQuery];

  ExpenseLoaded copyWith({
    List<Expense>? allExpenses,
    List<Expense>? filteredExpenses,
    double? todayTotal,
    double? monthTotal,
    String? searchQuery,
  }) {
    return ExpenseLoaded(
      allExpenses: allExpenses ?? this.allExpenses,
      filteredExpenses: filteredExpenses ?? this.filteredExpenses,
      todayTotal: todayTotal ?? this.todayTotal,
      monthTotal: monthTotal ?? this.monthTotal,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ExpenseError extends ExpenseState {
  const ExpenseError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

class ExpenseOperationSuccess extends ExpenseState {
  const ExpenseOperationSuccess(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
