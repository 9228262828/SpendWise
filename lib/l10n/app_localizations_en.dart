// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'SpendWise';

  @override
  String get home => 'Home';

  @override
  String get expenses => 'Expenses';

  @override
  String get categories => 'Categories';

  @override
  String get reports => 'Reports';

  @override
  String get settings => 'Settings';

  @override
  String get addExpense => 'Add Expense';

  @override
  String get editExpense => 'Edit Expense';

  @override
  String get deleteExpense => 'Delete Expense';

  @override
  String get amount => 'Amount';

  @override
  String get category => 'Category';

  @override
  String get date => 'Date';

  @override
  String get note => 'Note';

  @override
  String get optional => 'Optional';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get totalToday => 'Today';

  @override
  String get totalThisMonth => 'This Month';

  @override
  String get recentTransactions => 'Recent Transactions';

  @override
  String get seeAll => 'See All';

  @override
  String get noExpenses => 'No expenses yet';

  @override
  String get noExpensesSubtitle => 'Tap the + button to add your first expense';

  @override
  String get noCategories => 'No categories';

  @override
  String get weekly => 'Weekly';

  @override
  String get monthly => 'Monthly';

  @override
  String get totalExpenses => 'Total Expenses';

  @override
  String get transactions => 'Transactions';

  @override
  String get average => 'Average';

  @override
  String get byCategory => 'By Category';

  @override
  String get trend => 'Trend';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get currency => 'Currency';

  @override
  String get notifications => 'Notifications';

  @override
  String get reminderTime => 'Reminder Time';

  @override
  String get exportData => 'Export Data';

  @override
  String get exportCSV => 'Export as CSV';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get deleteConfirmTitle => 'Delete Expense';

  @override
  String get deleteConfirmMessage => 'Are you sure you want to delete this expense? This action cannot be undone.';

  @override
  String get deleteCategoryConfirmMessage => 'Are you sure you want to delete this category?';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get retry => 'Retry';

  @override
  String get search => 'Search expenses...';

  @override
  String get addCategory => 'Add Category';

  @override
  String get categoryName => 'Category Name';

  @override
  String get selectIcon => 'Select Icon';

  @override
  String get selectColor => 'Select Color';

  @override
  String insightHighestSpend(String category) {
    return 'Highest spending: $category';
  }

  @override
  String insightDailyAverage(String amount) {
    return 'Daily average: $amount';
  }

  @override
  String get appearance => 'Appearance';

  @override
  String get general => 'General';

  @override
  String get systemDefault => 'System Default';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get notificationsDesc => 'Get daily reminders to log your expenses';

  @override
  String get exportDesc => 'Export your expense data to CSV';

  @override
  String get version => 'Version';

  @override
  String get about => 'About SpendWise';

  @override
  String get spendingInsights => 'Spending Insights';

  @override
  String todaySpend(String amount) {
    return 'You\'ve spent $amount today';
  }
}
