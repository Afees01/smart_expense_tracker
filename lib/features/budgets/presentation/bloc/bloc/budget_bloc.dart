import 'package:flutter_bloc/flutter_bloc.dart';

import 'budget_event.dart';
import 'budget_state.dart';

import 'package:smart_expense_tracker/features/budgets/presentation/repositories/budget_repository.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final BudgetRepository repository;

  BudgetBloc({
    required this.repository,
  }) : super(BudgetInitial()) {
    on<LoadBudgets>(_onLoadBudgets);
    on<AddBudget>(_onAddBudget);
  }

  // ============================================================
  // LOAD BUDGETS
  // ============================================================

  Future<void> _onLoadBudgets(
    LoadBudgets event,
    Emitter<BudgetState> emit,
  ) async {
    emit(BudgetLoading());

    try {
      final budgets = await repository.getbudget(
        month: event.month,
      );

      emit(
        BudgetLoadSuccess(
          budgets,
        ),
      );
    } catch (e) {
      emit(
        BudgetLoadFailure(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // ADD BUDGET
  // ============================================================

  void _onAddBudget(
    AddBudget event,
    Emitter<BudgetState> emit,
  ) {
    if (state is BudgetLoadSuccess) {
      final current = (state as BudgetLoadSuccess).budgets;

      emit(
        BudgetLoadSuccess(
          [
            ...current,
            event.budget,
          ],
        ),
      );
    }
  }
}
