import 'package:flutter_bloc/flutter_bloc.dart';

import 'budget_event.dart';
import 'budget_state.dart';
import 'package:smart_expense_tracker/shared/models/budget_model.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  BudgetBloc() : super(BudgetInitial()) {
    on<LoadBudgets>(_onLoadBudgets);
    on<AddBudget>(_onAddBudget);
  }

  Future<void> _onLoadBudgets(
    LoadBudgets event,
    Emitter<BudgetState> emit,
  ) async {
    emit(BudgetLoading());

    try {
      await Future.delayed(
        const Duration(seconds: 1),
      );

      emit(
        BudgetLoadSuccess(sampleBudgets),
      );
    } catch (e) {
      emit(
        BudgetLoadFailure(
          e.toString(),
        ),
      );
    }
  }

  void _onAddBudget(
    AddBudget event,
    Emitter<BudgetState> emit,
  ) {
    if (state is BudgetLoadSuccess) {
      final current =
          (state as BudgetLoadSuccess).budgets;

      emit(
        BudgetLoadSuccess(
          [...current, event.budget],
        ),
      );
    }
  }
}