import 'package:smart_expense_tracker/features/budgets/data/models/budget_model.dart';

abstract class BudgetRepository {
  Future<List<BudgetModel>> getbudget({String? month});
}
