import 'package:get_it/get_it.dart';
import '../features/categories/data/datasources/category_local_datasource.dart';
import '../features/categories/data/repositories/category_repository_impl.dart';
import '../features/categories/domain/repositories/category_repository.dart';
import '../features/categories/domain/usecases/manage_categories.dart';
import '../features/categories/presentation/cubit/category_cubit.dart';
import '../features/expenses/data/datasources/expense_local_datasource.dart';
import '../features/expenses/data/repositories/expense_repository_impl.dart';
import '../features/expenses/domain/repositories/expense_repository.dart';
import '../features/expenses/domain/usecases/get_expenses.dart';
import '../features/expenses/domain/usecases/manage_expense.dart';
import '../features/expenses/presentation/cubit/expense_cubit.dart';
import '../features/reports/domain/usecases/get_report_data.dart';
import '../features/reports/presentation/cubit/report_cubit.dart';
import '../features/settings/presentation/cubit/settings_cubit.dart';

final GetIt sl = GetIt.instance;

void setupDI() {
  // Datasources
  sl.registerLazySingleton<ExpenseLocalDatasource>(() => ExpenseLocalDatasourceImpl());
  sl.registerLazySingleton<CategoryLocalDatasource>(() => CategoryLocalDatasourceImpl());

  // Repositories
  sl.registerLazySingleton<ExpenseRepository>(() => ExpenseRepositoryImpl(sl()));
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(sl()));

  // Use Cases - Expenses
  sl.registerLazySingleton(() => WatchExpenses(sl()));
  sl.registerLazySingleton(() => GetExpenses(sl()));
  sl.registerLazySingleton(() => GetExpensesByDateRange(sl()));
  sl.registerLazySingleton(() => SearchExpenses(sl()));
  sl.registerLazySingleton(() => AddExpense(sl()));
  sl.registerLazySingleton(() => UpdateExpense(sl()));
  sl.registerLazySingleton(() => DeleteExpense(sl()));

  // Use Cases - Categories
  sl.registerLazySingleton(() => WatchCategories(sl()));
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => AddCategory(sl()));
  sl.registerLazySingleton(() => UpdateCategory(sl()));
  sl.registerLazySingleton(() => DeleteCategory(sl()));

  // Use Cases - Reports
  sl.registerLazySingleton(() => GetCategoryBreakdown(sl(), sl()));
  sl.registerLazySingleton(() => GetDailyExpenses(sl()));
  sl.registerLazySingleton(() => GetMonthlyExpenses(sl()));

  // Cubits (factories so they're re-created)
  sl.registerFactory(() => ExpenseCubit(
        watchExpenses: sl(),
        getByDateRange: sl(),
        addExpense: sl(),
        updateExpense: sl(),
        deleteExpense: sl(),
        searchExpenses: sl(),
      ));

  sl.registerFactory(() => CategoryCubit(
        watchCategories: sl(),
        addCategory: sl(),
        updateCategory: sl(),
        deleteCategory: sl(),
      ));

  sl.registerFactory(() => ReportCubit(
        getCategoryBreakdown: sl(),
        getDailyExpenses: sl(),
        getMonthlyExpenses: sl(),
      ));

  sl.registerFactory(() => SettingsCubit());
}
