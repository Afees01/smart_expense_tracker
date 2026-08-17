import 'package:equatable/equatable.dart';
import 'package:smart_expense_tracker/features/budgets/data/models/budget_model.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object?> get props => [];
}

class LoadBudgets extends BudgetEvent {
  final String? month;

  const LoadBudgets({
    this.month,
  });

  @override
  List<Object?> get props => [
        month,
      ];
}

class AddBudget extends BudgetEvent {
  final BudgetModel budget;

  const AddBudget(
    this.budget,
  );

  @override
  List<Object?> get props => [
        budget,
      ];
}