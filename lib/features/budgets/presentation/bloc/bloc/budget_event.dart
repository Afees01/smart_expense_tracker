import 'package:smart_expense_tracker/shared/models/budget_model.dart';

abstract class BudgetEvent {}

class LoadBudgets extends BudgetEvent {}

class AddBudget extends BudgetEvent {
  final BudgetModel budget;

  AddBudget(this.budget);
}