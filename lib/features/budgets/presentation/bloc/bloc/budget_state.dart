import 'package:equatable/equatable.dart';
import 'package:smart_expense_tracker/features/budgets/data/models/budget_model.dart';

abstract class BudgetState extends Equatable {
  const BudgetState();

  @override
  List<Object?> get props => [];
}

class BudgetInitial extends BudgetState {}

class BudgetLoading extends BudgetState {}

class BudgetLoadSuccess extends BudgetState {
  final List<BudgetModel> budgets;

  const BudgetLoadSuccess(this.budgets);

  @override
  List<Object?> get props => [budgets];
}

class BudgetLoadFailure extends BudgetState {
  final String message;

  const BudgetLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}