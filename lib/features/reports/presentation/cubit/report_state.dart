import 'package:equatable/equatable.dart';
import '../../../reports/domain/usecases/get_report_data.dart';

enum ReportPeriod { weekly, monthly }

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object?> get props => [];
}

class ReportInitial extends ReportState {
  const ReportInitial();
}

class ReportLoading extends ReportState {
  const ReportLoading();
}

class ReportLoaded extends ReportState {
  const ReportLoaded({
    required this.period,
    required this.categoryBreakdown,
    required this.dailyData,
    required this.monthlyData,
    required this.totalAmount,
    required this.transactionCount,
    required this.averageExpense,
    required this.periodStart,
    required this.periodEnd,
  });

  final ReportPeriod period;
  final List<CategoryExpenseData> categoryBreakdown;
  final List<DailyExpenseData> dailyData;
  final List<MonthlyExpenseData> monthlyData;
  final double totalAmount;
  final int transactionCount;
  final double averageExpense;
  final DateTime periodStart;
  final DateTime periodEnd;

  @override
  List<Object?> get props => [period, categoryBreakdown, dailyData, monthlyData, totalAmount];
}

class ReportError extends ReportState {
  const ReportError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
