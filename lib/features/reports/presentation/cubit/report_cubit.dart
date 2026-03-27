import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../reports/domain/usecases/get_report_data.dart';
import '../../../../core/utils/date_utils.dart';
import 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit({
    required GetCategoryBreakdown getCategoryBreakdown,
    required GetDailyExpenses getDailyExpenses,
    required GetMonthlyExpenses getMonthlyExpenses,
  })  : _getCategoryBreakdown = getCategoryBreakdown,
        _getDailyExpenses = getDailyExpenses,
        _getMonthlyExpenses = getMonthlyExpenses,
        super(const ReportInitial());

  final GetCategoryBreakdown _getCategoryBreakdown;
  final GetDailyExpenses _getDailyExpenses;
  final GetMonthlyExpenses _getMonthlyExpenses;

  Future<void> loadReport(ReportPeriod period) async {
    emit(const ReportLoading());
    try {
      final now = DateTime.now();
      DateTime start, end;

      if (period == ReportPeriod.weekly) {
        start = AppDateUtils.startOfWeek(now);
        end = AppDateUtils.endOfWeek(now);
      } else {
        start = AppDateUtils.startOfMonth(now);
        end = AppDateUtils.endOfMonth(now);
      }

      final results = await Future.wait([
        _getCategoryBreakdown(start, end),
        _getDailyExpenses(start, end),
        _getMonthlyExpenses(6),
      ]);

      final breakdown = results[0] as List<CategoryExpenseData>;
      final daily = results[1] as List<DailyExpenseData>;
      final monthly = results[2] as List<MonthlyExpenseData>;

      final totalAmount = breakdown.fold(0.0, (sum, c) => sum + c.total);
      final transactionCount = breakdown.fold(0, (sum, c) => sum + c.count);
      final averageExpense = transactionCount > 0 ? totalAmount / transactionCount : 0.0;

      emit(ReportLoaded(
        period: period,
        categoryBreakdown: breakdown,
        dailyData: daily,
        monthlyData: monthly,
        totalAmount: totalAmount,
        transactionCount: transactionCount,
        averageExpense: averageExpense,
        periodStart: start,
        periodEnd: end,
      ));
    } catch (e) {
      emit(ReportError(e.toString()));
    }
  }
}
