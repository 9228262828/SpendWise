import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/expenses/domain/entities/expense.dart';
import '../../features/expenses/presentation/screens/add_expense_screen.dart';
import '../../features/expenses/presentation/screens/all_expenses_screen.dart';
import '../../features/categories/presentation/screens/categories_screen.dart';
import '../../features/reports/presentation/screens/reports_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../widgets/main_scaffold.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String home = '/home';
  static const String addExpense = '/add-expense';
  static const String editExpense = '/edit-expense';
  static const String allExpenses = '/all-expenses';
  static const String categories = '/categories';
  static const String reports = '/reports';
  static const String settings = '/settings';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => const NoTransitionPage(child: SizedBox()),
        ),
        GoRoute(
          path: AppRoutes.reports,
          pageBuilder: (context, state) => const NoTransitionPage(child: ReportsScreen()),
        ),
        GoRoute(
          path: AppRoutes.categories,
          pageBuilder: (context, state) => const NoTransitionPage(child: CategoriesScreen()),
        ),
        GoRoute(
          path: AppRoutes.settings,
          pageBuilder: (context, state) => const NoTransitionPage(child: SettingsScreen()),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.addExpense,
      builder: (context, state) => const AddExpenseScreen(),
    ),
    GoRoute(
      path: AppRoutes.editExpense,
      builder: (context, state) {
        final expense = state.extra as Expense;
        return AddExpenseScreen(expenseToEdit: expense);
      },
    ),
    GoRoute(
      path: AppRoutes.allExpenses,
      builder: (context, state) => const AllExpensesScreen(),
    ),
  ],
);
