import 'package:hive/hive.dart';
import '../../domain/entities/expense.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late double amount;

  @HiveField(2)
  late String categoryId;

  @HiveField(3)
  late DateTime date;

  @HiveField(4)
  String? note;

  @HiveField(5)
  late DateTime createdAt;

  ExpenseModel({
    required this.id,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.note,
    required this.createdAt,
  });

  factory ExpenseModel.fromEntity(Expense expense) {
    return ExpenseModel(
      id: expense.id,
      amount: expense.amount,
      categoryId: expense.categoryId,
      date: expense.date,
      note: expense.note,
      createdAt: expense.createdAt,
    );
  }

  Expense toEntity() {
    return Expense(
      id: id,
      amount: amount,
      categoryId: categoryId,
      date: date,
      note: note,
      createdAt: createdAt,
    );
  }
}
