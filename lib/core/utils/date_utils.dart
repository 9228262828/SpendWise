import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static String formatDate(DateTime date) => DateFormat('MMM d, yyyy').format(date);
  static String formatDateShort(DateTime date) => DateFormat('MMM d').format(date);
  static String formatDateFull(DateTime date) => DateFormat('EEEE, MMM d, yyyy').format(date);
  static String formatMonth(DateTime date) => DateFormat('MMMM yyyy').format(date);
  static String formatMonthShort(DateTime date) => DateFormat('MMM yyyy').format(date);
  static String formatDay(DateTime date) => DateFormat('d').format(date);
  static String formatWeekday(DateTime date) => DateFormat('EEE').format(date);

  static DateTime get startOfToday {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static DateTime get endOfToday {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 23, 59, 59);
  }

  static DateTime startOfMonth(DateTime date) => DateTime(date.year, date.month, 1);
  static DateTime endOfMonth(DateTime date) => DateTime(date.year, date.month + 1, 0, 23, 59, 59);

  static DateTime startOfWeek(DateTime date) {
    final weekday = date.weekday;
    return DateTime(date.year, date.month, date.day - weekday + 1);
  }

  static DateTime endOfWeek(DateTime date) {
    final weekday = date.weekday;
    return DateTime(date.year, date.month, date.day + (7 - weekday), 23, 59, 59);
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day;
  }

  static bool isSameMonth(DateTime a, DateTime b) => a.year == b.year && a.month == b.month;

  static String relativeDate(DateTime date) {
    if (isToday(date)) return 'Today';
    if (isYesterday(date)) return 'Yesterday';
    return formatDate(date);
  }

  static List<DateTime> getDaysInMonth(DateTime month) {
    final daysInMonth = endOfMonth(month).day;
    return List.generate(daysInMonth, (i) => DateTime(month.year, month.month, i + 1));
  }

  static List<DateTime> getLast7Days() {
    return List.generate(7, (i) {
      final day = DateTime.now().subtract(Duration(days: 6 - i));
      return DateTime(day.year, day.month, day.day);
    });
  }

  static List<DateTime> getLast6Months() {
    final now = DateTime.now();
    return List.generate(6, (i) {
      final month = DateTime(now.year, now.month - (5 - i));
      return DateTime(month.year, month.month, 1);
    });
  }
}
